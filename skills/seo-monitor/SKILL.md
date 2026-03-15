---
name: seo-monitor
description: >
  SEO monitoring and delta tracking. Re-runs the collector on a previously audited site, compares
  current data against the baseline from the first audit, and produces a delta report showing
  improvements, regressions, and alerts. Use this skill for: "monitor my SEO", "check if the fixes
  worked", "compare my site to the last audit", "run a follow-up audit", "track SEO progress",
  "has my SEO improved", "re-scan my site", "SEO health check", "check for regressions",
  "schedule SEO monitoring", "surveille mon SEO", "vérifie les améliorations".
  Also triggers when the user references a previous audit or asks about SEO progress over time,
  or when baseline.json exists in the project monitoring/ folder.
---

# Skill: SEO Monitor — Periodic Delta Tracking

All responses and reports are produced **in English by default**. Switch to the user's language if they explicitly request it.

---

## Overview

This skill is **Step 4** in the SEO-GEO pipeline. It re-crawls a previously audited site, compares the current state against the original baseline, and produces a delta report highlighting what improved, what regressed, and what needs attention.

### Position in the pipeline

```
[seo-collector] → site-data.json ──────────────────────┐
                       ↓                                │
[seo-geo-audit] → audit-report.md + audit-actions.json  │
                       ↓                                │
[seo-implementer] → fixes/                              │
                       ↓                                │
             ┌─────────────────────────┐                │
             │   SEO MONITOR (this)    │ ←──────────────┘
             └─────────────────────────┘    (re-uses collector)
                       ↓
              monitoring/
              ├── baseline.json
              ├── delta-[date].md
              └── alerts.md
                       ↓
              ↻ loops back to collector for next cycle
```

### What it produces

```
seo-project-[domain]/
└── monitoring/
    ├── baseline.json           ← Snapshot from the first audit (created once)
    ├── scan-[date].json        ← Each new crawl result
    ├── delta-[date].md         ← Comparison report (human-readable)
    ├── delta-[date].json       ← Comparison data (machine-readable)
    ├── alerts.md               ← Active alerts (updated each scan)
    └── history.md              ← Score evolution over time
```

---

## Step 0: Determine monitoring mode

### First run (no baseline exists)

If no `monitoring/baseline.json` exists in the project folder:

1. Check if `site-data.json` and `audit-actions.json` exist from a previous audit
2. If yes → convert them into the baseline:
   - Copy `site-data.json` → `monitoring/baseline.json` (add `baseline_date` field)
   - Extract scores from `audit-actions.json` → store in baseline
3. If no → ask the user:
   ```
   No previous audit found for this domain.
   Would you like me to:
     1. Run a full audit first (collector + audit) to establish the baseline
     2. Run a quick scan now and use it as the baseline
   ```

### Subsequent runs (baseline exists)

1. Load `monitoring/baseline.json`
2. Run a fresh data collection (re-use `seo-collector` methodology)
3. Compare and generate the delta

---

## Step 1: Re-collect current data

Re-run the collector methodology on the same URL. Collect the same data points as the original `site-data.json`:

### 1.1 Quick scan (default)

Focused on the metrics most likely to change:

| Data point | Method | Why it matters |
|---|---|---|
| Homepage meta tags | `web_fetch` homepage | Detect if fixes were applied |
| Robots.txt | `web_fetch` /robots.txt | Detect if AI bots were unblocked |
| Core Web Vitals | `web_search` PageSpeed data | Detect performance changes |
| Indexation count | `web_search` site:[domain] | Detect indexation gains/losses |
| Schema markup | `web_fetch` HTML check | Detect if schemas were added |
| Sample pages (3-5) | `web_fetch` key pages | Detect meta tag changes |
| AI bot access | Parse robots.txt for each bot | Detect GEO improvements |

### 1.2 Full re-scan (on request)

Runs the complete `seo-collector` methodology. Use when the user requests a comprehensive re-audit or when significant changes are expected.

Save the scan result to `monitoring/scan-[date].json`.

---

## Step 2: Compare against baseline

For each data point, compute the delta:

### 2.1 Score comparison

```json
{
  "comparison_date": "[ISO 8601]",
  "baseline_date": "[ISO 8601 from baseline]",
  "days_since_baseline": 0,
  "scores": {
    "technical_seo": {
      "baseline": 0,
      "current": 0,
      "delta": 0,
      "trend": "improved|regressed|unchanged"
    },
    "core_web_vitals": { "..." },
    "local_or_content": { "..." },
    "eeat": { "..." },
    "entity_seo": { "..." },
    "geo": { "..." },
    "ux_conversion": { "..." },
    "overall": {
      "baseline": 0,
      "current": 0,
      "delta": 0,
      "max": 90
    }
  }
}
```

### 2.2 Specific change detection

For each category, track specific changes:

**Meta tags changes:**
```json
{
  "url": "https://example.com/page",
  "field": "title",
  "baseline_value": "[old title]",
  "current_value": "[new title]",
  "status": "fixed|regressed|unchanged|new_issue"
}
```

**Robots.txt changes:**
```json
{
  "bot": "GPTBot",
  "baseline_status": "blocked",
  "current_status": "allowed",
  "status": "fixed"
}
```

**Indexation changes:**
```json
{
  "google_indexed": { "baseline": "~340", "current": "~380", "delta": "+~40" },
  "bing_indexed": { "baseline": true, "current": true },
  "brave_indexed": { "baseline": "unknown", "current": true }
}
```

**Core Web Vitals changes:**
```json
{
  "lcp_mobile": { "baseline": "3.2s", "current": "2.4s", "delta": "-0.8s", "status": "improved" },
  "cls_mobile": { "baseline": "0.12", "current": "0.08", "delta": "-0.04", "status": "improved" },
  "inp_mobile": { "baseline": "280ms", "current": "190ms", "delta": "-90ms", "status": "improved" }
}
```

Save the full comparison to `monitoring/delta-[date].json`.

---

## Step 3: Generate alerts

Evaluate each change against alert thresholds:

### Alert levels

| Level | Trigger | Example |
|---|---|---|
| 🔴 **CRITICAL** | Score dropped by > 10 points overall, or a previously fixed issue has returned | Overall score went from 62 to 48; H1 that was fixed is missing again |
| 🟠 **WARNING** | Score dropped in any single dimension by > 3 points, or a new issue appeared | GEO score dropped from 14 to 10; a new 404 page detected |
| 🟢 **POSITIVE** | Score improved in any dimension, or a fix was confirmed working | Core Web Vitals improved; schema markup now detected |
| ℹ️ **INFO** | Change detected but no clear positive/negative impact | Indexation count changed by < 5%; new page added to sitemap |

### Alert file: `monitoring/alerts.md`

```markdown
# SEO Alerts — [domain]
Last scan: [date] | Baseline: [date] | Days elapsed: [N]

## 🔴 CRITICAL
- [Description of critical alert with details and recommended action]

## 🟠 WARNING
- [Description of warning with details]

## 🟢 POSITIVE CHANGES
- [Description of improvement confirmed]

## ℹ️ INFO
- [Description of neutral change]

---
No alerts = ✅ All clear — site is stable since last scan.
```

---

## Step 4: Generate delta report

File: `monitoring/delta-[date].md`

```markdown
# SEO Monitoring Report — [domain]
Scan date: [date] | Baseline: [date] | Days since baseline: [N]

---

## Score evolution

| Dimension | Baseline | Current | Delta | Trend |
|---|---|---|---|---|
| Technical SEO | [X]/10 | [Y]/10 | [+/-Z] | ↑/↓/→ |
| Core Web Vitals | [X]/10 | [Y]/10 | [+/-Z] | ↑/↓/→ |
| Local/Content & Authority | [X]/20 | [Y]/20 | [+/-Z] | ↑/↓/→ |
| E-E-A-T | [X]/10 | [Y]/10 | [+/-Z] | ↑/↓/→ |
| Entity SEO | [X]/10 | [Y]/10 | [+/-Z] | ↑/↓/→ |
| GEO | [X]/20 | [Y]/20 | [+/-Z] | ↑/↓/→ |
| UX & Conversion | [X]/10 | [Y]/10 | [+/-Z] | ↑/↓/→ |
| **OVERALL** | **[X]/90** | **[Y]/90** | **[+/-Z]** | **↑/↓/→** |

## Fixes confirmed working ✅
[List each fix from audit-actions.json that has been successfully implemented]

## Fixes not yet applied ⏳
[List each fix that was recommended but hasn't been implemented yet]

## Regressions detected 🔴
[List any metrics that got worse since the baseline]

## New issues found 🆕
[List any problems that didn't exist at baseline time]

## Recommendations
[Prioritized next actions based on the current state]

---

## Next scan recommended: [date — baseline + interval]
```

---

## Step 5: Update history

File: `monitoring/history.md`

Append each scan result to a running history:

```markdown
# SEO Score History — [domain]

| Date | Overall /90 | Tech | CWV | Content | E-E-A-T | Entity | GEO | UX | Notes |
|---|---|---|---|---|---|---|---|---|---|
| [baseline date] | [X] | [x] | [x] | [x] | [x] | [x] | [x] | [x] | Initial audit |
| [scan date] | [Y] | [y] | [y] | [y] | [y] | [y] | [y] | [y] | [key change noted] |
| ... | | | | | | | | | |
```

> This table grows with each scan. It provides a quick view of the site's SEO health trajectory.

---

## Monitoring frequency recommendations

| Site type | Recommended interval | Rationale |
|---|---|---|
| E-commerce (active) | Weekly | Frequent product/price changes, competitive market |
| SaaS / B2B | Bi-weekly | Moderate content velocity, feature pages change |
| Blog / Media | Weekly | New content published frequently |
| Local business | Monthly | Slower pace of change, review monitoring more important |
| Corporate / Institutional | Monthly | Rarely changes, but regressions must be caught |
| Post-fix verification | 1 week after deployment | Confirm fixes took effect before next audit |

---

## Output summary

After generating the monitoring report, present:

```
═══════════════════════════════════════════
SEO MONITORING REPORT — [domain]
Scan: [date] | vs Baseline: [date] ([N] days)
═══════════════════════════════════════════

📊 Score evolution: [baseline]/90 → [current]/90 ([+/-delta])

✅ Fixes confirmed: [N] of [total] recommendations implemented
⏳ Pending fixes: [N] not yet applied
🔴 Regressions: [N] metrics worsened
🆕 New issues: [N] new problems detected

📁 Files updated:
   monitoring/delta-[date].md    — Full comparison report
   monitoring/delta-[date].json  — Machine-readable delta
   monitoring/alerts.md          — Active alerts
   monitoring/history.md         — Score timeline

[If regressions detected:]
⚠️ Action needed: [brief description of most critical regression]

[If all good:]
✅ All stable — no critical changes since baseline.

Next scan recommended: [date]

Would you like me to:
  1. Detail the regressions and suggest fixes?
  2. Re-run the full audit for a complete re-score?
  3. Generate an updated implementation checklist?
```

---

## Integration with scheduled tasks

When running as a scheduled task (Pattern 3 from the skill system architecture):

### Cron / scheduled task setup

```bash
# Weekly SEO monitoring — runs every Monday at 7am
0 7 * * 1 claude "Run SEO monitor on https://[domain]"

# Bi-weekly
0 7 * * 1 [ $(( $(date +%V) % 2 )) -eq 0 ] && claude "Run SEO monitor on https://[domain]"

# Monthly (1st of month)
0 7 1 * * claude "Run SEO monitor on https://[domain]"
```

### Claude Code / Cowork scheduled tasks

```
Schedule: "Every Monday at 7am, run a quick SEO scan on https://[domain] and compare to baseline. If any critical alerts, notify me."
```

The monitor should:
1. Load the baseline silently
2. Run the quick scan
3. Generate the delta
4. **Only notify the user if there are 🔴 CRITICAL or 🟠 WARNING alerts**
5. If all clear, log the scan silently to `monitoring/history.md`

> **Pattern 3 applied**: Scheduled orchestration. The monitor runs on a schedule without user intervention. It triggers alerts only when something needs attention. The user reviews results, not processes.

---

## Edge cases

| Situation | Handling |
|---|---|
| Site is down during scan | Log the failure, retry once after 5 min. If still down → 🔴 CRITICAL alert "Site unreachable" |
| Domain changed | Detect via redirect. Ask user to confirm new domain. Create new baseline. |
| Major redesign detected | If > 50% of tracked URLs return 404 or different structure → 🟠 WARNING "Major site changes detected — recommend full re-audit" |
| CMS changed | Detect via `cms_detected` mismatch. Flag in delta report. |
| robots.txt disappeared | 🔴 CRITICAL alert — all crawlers may be blocked |
| Score dropped but fixes were applied | Check if fixes are still in place (could be overwritten by CMS update). Flag specifically. |
| Baseline is > 6 months old | ℹ️ INFO "Baseline is aging — consider running a full re-audit to reset" |

---

## Best practices

### Data continuity
- Never overwrite `baseline.json` — it's the reference point
- Each scan creates a new `scan-[date].json` — full history preserved
- If a full re-audit is done, offer to update the baseline (with user confirmation)

### Alert fatigue prevention
- Don't alert on changes within normal variance (< 2% indexation change, < 0.5pt score change)
- Group related alerts (if 3 meta tags regressed on the same template, that's 1 alert, not 3)
- Distinguish between "fix not applied yet" (expected) and "fix was applied but broke" (critical)

### Comparison accuracy
- Always compare against the same data points
- If the collector methodology changed between scans, note it in the delta report
- Estimations vs. real data: if baseline was estimated and current has real data, flag the methodology difference
