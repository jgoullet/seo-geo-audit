# SEO-GEO Audit System

> From standalone audit to autonomous SEO pipeline.
> 5 connected skills that collect, audit, implement, and monitor — so you review results instead of orchestrating steps.

[![Claude Code](https://img.shields.io/badge/Claude_Code-%E2%9C%93-8B5CF6?style=flat-square)](https://claude.ai)
[![Claude.ai](https://img.shields.io/badge/Claude.ai-%E2%9C%93-8B5CF6?style=flat-square)](https://claude.ai)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

[🇬🇧 English](README.md) · [🇫🇷 Français](README.fr.md)

---

## What's new in v2.1

v1 was a single audit skill. v2 turns it into a **skill system** — 5 connected skills that share context, chain outputs, and produce compound results.

| | v1 (standalone) | v2.1 (system) |
|---|---|---|
| **Data collection** | Manual (15 questions) | Automated crawler + Ahrefs MCP |
| **Audit** | Estimates only | Real data when MCP connected |
| **Analytics tracking** | Not covered | Detects 11 tools, scores maturity |
| **Implementation** | You figure it out | Generated fix files ready to deploy |
| **Monitoring** | Come back in 3 months | Automatic delta reports + Ahrefs trends |
| **Context** | Reset every session | Shared client profile |
| **Language** | French only | English by default (any language on request) |

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

Shared data layer. Contains the client profile template, SEO standards reference (Core Web Vitals thresholds, E-E-A-T criteria, GEO boost percentages), report formatting conventions, and GSC regex filters (RE2 patterns for branded/non-branded, intent, local, long-tail query segmentation — loaded only when GSC MCP is connected).

**Not used directly** — loaded automatically by other skills.

### seo-collector

Automated technical crawler. Run it on any URL and it produces a structured `site-data.json` with:
- HTML meta tags (title, description, H1, OG tags) for homepage + 3-5 sample pages
- `robots.txt` analysis with AI bot access check (GPTBot, ClaudeBot, PerplexityBot...)
- Sitemap detection and URL count
- Core Web Vitals (via PageSpeed Insights data)
- Schema markup detection (with JS-injection caveat)
- Analytics & tracking audit: detects 11 tools (GA4, GTM, Meta Pixel, Hotjar/Clarity, Segment, Mixpanel...), checks conversion events, consent management, assigns maturity level
- HTTPS and security headers
- Google/Bing/Brave indexation estimates

**Token budget optimization**: All `web_fetch` calls use `text_content_token_limit` to cap page responses (4000 for homepage, 3000 for inner/competitor pages, 1000 for robots.txt). This cuts context window consumption from ~175K to ~75K tokens per audit — leaving room for the full report generation.

**Optional: Ahrefs MCP** — Connect your Ahrefs account (Lite plan+) for real Domain Rating, backlink data, organic keywords with positions, competitor identification, and Brand Radar (AI citation tracking). Without Ahrefs, all metrics are estimated.

**Trigger**: "collect SEO data for [url]", "crawl this site", "get backlink data for [url]"

### seo-geo-audit

The expert audit skill — reads `site-data.json` when available (including Ahrefs and analytics data), skipping manual data collection. Produces a scored report /90 across 7 dimensions with competitive analysis and prioritized action plan. Now includes analytics maturity scoring in the UX & Conversion section.

**Trigger**: "audit [url]", "audit my site", "compare my site to [competitor]"

### seo-implementer

Reads the audit results and generates ready-to-deploy fix files: rewritten meta tags, JSON-LD schema blocks, redirect rules (Apache/Nginx/Vercel/Shopify), robots.txt corrections, content optimization snippets, analytics setup recommendations (adapted to CMS and site type), and a step-by-step implementation checklist with verification tests.

**Trigger**: "generate the fixes", "implement the recommendations", "create the schema markup"

### seo-monitor

Periodic re-crawl that compares current state against the baseline from the first audit. Produces a delta report showing improvements, regressions, and alerts. If Ahrefs MCP is connected, tracks Domain Rating evolution, backlink changes, and AI citation trends over time via Brand Radar.

**Trigger**: "monitor my SEO", "check if fixes worked", "has my SEO improved"

---

## MCP integrations (all optional)

The system works without any MCP. Each integration replaces estimates with real data:

| MCP | What it adds | Min. plan | Setup |
|---|---|---|---|
| **[Ahrefs](https://ahrefs.com/mcp/)** | Domain Rating, backlinks, organic keywords, competitors, Brand Radar (AI citations) | Lite ($29/mo) | Connect via Ahrefs MCP in Claude settings |
| **[GA4](https://github.com/googleanalytics/google-analytics-mcp)** | Real organic traffic, bounce rates, conversions, social referrals | Free | Connect GA4 MCP server |
| **[GSC](https://github.com/ahonn/mcp-server-gsc)** | Real rankings, AI Overviews impressions, quick wins, URL inspection | Free | Connect GSC MCP server |

---

## Example usage

### Full pipeline

```
"Collect SEO data for https://example.com"
→ Collector runs, produces site-data.json (+ Ahrefs data if connected)

"Run the full SEO-GEO audit"
→ Auditor reads site-data.json, produces audit-report.md with scores /90

"Generate the fixes"
→ Implementer reads audit results, produces fix files + analytics setup

"Start monitoring"
→ Monitor re-crawls, compares with baseline, alerts on regressions
```

### With Ahrefs MCP connected

```
"Collect SEO data for https://example.com"
→ Real DR: 45/100 | 890 referring domains | 2,340 organic keywords
→ Competitors auto-identified | Brand Radar: cited by 3 AI platforms
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
    │       ├── report-conventions.md   # Report formatting rules
    │       └── gsc-regex-filters.md    # GSC regex patterns (RE2) for query segmentation
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
- **Ahrefs MCP**: [Ahrefs MCP documentation](https://ahrefs.com/mcp/) — Brand Radar, Domain Rating, backlink analysis
- **GA4 MCP**: [google-analytics-mcp](https://github.com/googleanalytics/google-analytics-mcp) — official Google Analytics MCP server
- **GSC MCP**: [mcp-server-gsc](https://github.com/ahonn/mcp-server-gsc) — Google Search Console MCP
- **System architecture**: Inspired by skill system patterns (shared context, output-as-input chaining, scheduled orchestration)

---

## License

MIT — free to use, modify, and redistribute.
