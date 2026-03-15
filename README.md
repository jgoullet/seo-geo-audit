# SEO-GEO Audit System

> From standalone audit to autonomous SEO pipeline.
> 5 connected skills that collect, audit, implement, and monitor — so you review results instead of orchestrating steps.

[![Claude Code](https://img.shields.io/badge/Claude_Code-%E2%9C%93-8B5CF6?style=flat-square)](https://claude.ai)
[![Claude.ai](https://img.shields.io/badge/Claude.ai-%E2%9C%93-8B5CF6?style=flat-square)](https://claude.ai)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

[🇬🇧 English](README.md) · [🇫🇷 Français](README.fr.md)

---

## What changed in v2.0

v1 was a single audit skill. v2 turns it into a **skill system** (plugin) — multiple skills that share context, pass output between each other, and produce compound results.

| | v1 (standalone) | v2 (system) |
|---|---|---|
| **Data collection** | Manual (15 questions) | Automated crawler |
| **Audit** | Same skill | Same skill, now reads crawler output |
| **Implementation** | You figure it out | Generated fix files ready to deploy |
| **Monitoring** | Come back in 3 months | Automatic delta reports |
| **Context** | Reset every session | Shared client profile |

If you just want the audit skill like before, that still works — see [Standalone install](#standalone-install-v1-behavior) below.

---

## Install

### Full system (recommended)

```bash
# One command — installs all 5 skills
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash
```

### Individual skill

```bash
# Install just the collector
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash -s -- --skill seo-collector

# Install just the monitor
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash -s -- --skill seo-monitor
```

> Shared context (`seo-shared-context`) is auto-installed when you install any other skill.

### Standalone install (v1 behavior)

```bash
# Just the audit skill, no dependencies
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash -s -- --audit-only
```

### Claude Code

```bash
npx skills add https://github.com/jgoullet/seo-geo-audit --skill seo-geo-audit
```

### Claude.ai (manual)

Download `.skill` files from [Releases](https://github.com/jgoullet/seo-geo-audit/releases) → install via Settings > Skills.

### Uninstall

```bash
# Remove everything
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/uninstall.sh | bash

# Remove one skill
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/uninstall.sh | bash -s -- --skill seo-collector
```

---

## The system — how skills connect

```
┌─────────────────────────────────────────────┐
│         seo-shared-context                  │
│   client-profile.md · seo-standards.md      │
│   report-conventions.md                     │
│         (loaded by all skills)              │
└──────────────────┬──────────────────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-collector          │
    │  Crawls site automatically  │──→ site-data.json
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-geo-audit          │
    │  Expert audit, scores /90   │──→ audit-report.md
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-implementer        │
    │  Generates fix files        │──→ fixes/ (meta, schema, redirects)
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-monitor            │
    │  Re-crawl + delta report    │──→ monitoring-delta.md
    └──────────────┘
         ↻ loops back to collector
```

**Pattern 1 — Shared context**: All skills load the same `client-profile.md` and standards files. One voice, one client profile, consistent scoring.

**Pattern 2 — Output-as-input chaining**: Each skill writes structured output that the next skill reads. The collector doesn't know what the auditor does — it just writes JSON. Loose coupling, shared files as the API layer.

**Pattern 3 — Orchestration** (optional): Schedule the collector weekly, the monitor monthly. The system runs without you.

---

## Skills reference

### seo-shared-context

Shared data layer. Contains the client profile template, SEO standards reference (Core Web Vitals thresholds, E-E-A-T criteria, GEO boost percentages), and report formatting conventions.

**Not used directly** — loaded automatically by other skills.

### seo-collector

Automated technical crawler. Run it on any URL and it produces a structured `site-data.json` with:
- HTML meta tags (title, description, H1, OG tags) for homepage + 3-5 sample pages
- `robots.txt` analysis with AI bot access check (GPTBot, ClaudeBot, PerplexityBot...)
- Sitemap detection and URL count
- Core Web Vitals (via PageSpeed Insights data)
- Schema markup detection (with JS-injection caveat)
- HTTPS and security headers
- Google/Bing/Brave indexation estimates

**Trigger**: "collecte les données SEO de [url]", "crawl ce site", "prépare les données pour l'audit"

### seo-geo-audit

The original expert audit skill — now enhanced to read `site-data.json` when available, skipping manual data collection. Produces a scored report /90 across 7 dimensions with competitive analysis and prioritized action plan.

**Trigger**: "audit SEO de [url]", "audite mon site", "compare mon site à [concurrent]"

### seo-implementer

*(Coming in v2.1)* Reads the audit report and generates ready-to-deploy fix files: rewritten meta tags, JSON-LD schema blocks, .htaccess redirects, robots.txt corrections, and an implementation checklist.

### seo-monitor

*(Coming in v2.2)* Periodic re-crawl that compares current state against the baseline from the first audit. Produces a delta report showing improvements, regressions, and alerts.

---

## Example usage

### Full pipeline

```
"Collecte les données SEO de https://example.com"
→ Collector runs, produces site-data.json

"Lance l'audit SEO-GEO complet"
→ Auditor reads site-data.json, produces audit-report.md with scores /90

"Génère les corrections"
→ Implementer reads audit-report.md, produces fix files

"Lance le monitoring"
→ Monitor re-crawls, compares with baseline
```

### Standalone audit (still works)

```
"Audit https://mypizza.com in Local mode.
I run a pizza restaurant in Chicago.
Competitors: giordanos.com and loumalnatispizza.com"
```

---

## Repo structure

```
seo-geo-audit/
├── install.sh                          # System installer
├── uninstall.sh                        # System uninstaller
├── README.md                           # This file
├── README.fr.md                        # French documentation
├── LICENSE
└── skills/
    ├── seo-shared-context/
    │   ├── SKILL.md                    # Shared data layer
    │   └── references/
    │       ├── seo-standards.md        # Thresholds & metrics
    │       └── report-conventions.md   # Report formatting rules
    ├── seo-collector/
    │   └── SKILL.md                    # Automated crawler
    ├── seo-geo-audit/
    │   ├── SKILL.md                    # Expert audit /90
    │   └── ai-writing-detection.md     # AI writing markers reference
    ├── seo-implementer/
    │   └── SKILL.md                    # Fix file generator
    └── seo-monitor/
        └── SKILL.md                    # Delta monitoring
```

---

## Upgrading from v1

Your existing `seo-geo-audit` skill continues to work as-is. To upgrade:

1. Uninstall the old skill
2. Run the full system installer
3. The audit skill is the same — it just now has friends

```bash
# Remove old
rm -rf ~/.claude/skills/seo-geo-audit

# Install new system
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash
```

---

## Sources & methodology

- **GEO methods**: Princeton / IIT Delhi / Georgia Tech — *"GEO: Generative Engine Optimization"*, KDD 2024 (arXiv:2311.09735)
- **Platform algorithms**: SE Ranking (129K domains), Perplexity Sonar analysis, Google Quality Rater Guidelines
- **System architecture**: Inspired by skill system patterns (shared context, output-as-input chaining, scheduled orchestration)

---

## License

MIT — free to use, modify, and redistribute.
