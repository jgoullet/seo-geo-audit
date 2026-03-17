---
name: seo-collector
description: >
  Automated SEO data collector. Crawls a website and produces a structured site-data.json file
  containing: title/meta/H1 tags, robots.txt, sitemap, HTTP headers, Core Web Vitals (via PageSpeed
  Insights), schema markup detection, AI bot access analysis in robots.txt, and sample page snapshots.
  Optionally integrates Ahrefs MCP for real backlink data, domain rating, organic keywords, and
  competitor identification. This skill is Step 1 of the SEO-GEO pipeline: it collects raw data
  that seo-geo-audit consumes to produce the audit.
  Use this skill when the user says: "collect SEO data for [url]", "crawl this site",
  "technical analysis of [url]", "prepare data for the audit", "run the collector on [url]",
  "scrape SEO metrics", "check the Core Web Vitals of", "check the robots.txt of",
  "analyze the meta tags of", "can AI bots access [url]", "get backlink data for [url]".
  Also triggers for: "collecte les données SEO de", "analyse technique de", "crawl ce site".
---

# Skill: SEO Collector — Automated technical data collection

All responses and logs are produced **in English by default**. Switch to the user's language if they explicitly request it.

---

## Overview

This skill automatically crawls a website and produces a structured `site-data.json` file, ready to be consumed by the `seo-geo-audit` skill. It replaces manual information gathering (Step 0 of the audit).

### Position in the pipeline

```
[seo-shared-context] → client-profile.md
                            ↓
              ┌─────────────────────────┐
              │  SEO COLLECTOR (this)   │
              └─────────────────────────┘
                            ↓
                     site-data.json
                            ↓
              ┌─────────────────────────┐
              │     SEO-GEO AUDIT       │
              └─────────────────────────┘
```

---

## Step 0: Prerequisites

### Required inputs
- **Site URL** (required)
- **`client-profile.md`** (optional — if available, load it for mode, competitors, CMS info)

### Optional MCP integrations

#### Ahrefs MCP *(recommended — replaces estimates with real data)*

> Ahrefs MCP is available on **Lite, Standard, Advanced, and Enterprise plans** (from $29/month Starter). It provides real backlink data, domain rating, organic keywords, and competitor identification — all data that the collector would otherwise estimate.

If Ahrefs MCP is connected, the collector will use it to pull:

| Ahrefs endpoint | What it provides | Replaces |
|---|---|---|
| `domain-rating` | Real DR score (0-100) + Ahrefs Rank | Estimated authority |
| `backlinks-stats` | Total backlinks, referring domains, dofollow/nofollow | "Estimated from web search" |
| `broken-backlinks` | Broken inbound links list | Not available without Ahrefs |
| `organic-keywords` | Keywords the site ranks for + positions + volumes | Manual keyword search |
| `organic-competitors` | Top organic competitors identified by Ahrefs | "Identify via web_search" |
| `top-pages` | Pages driving the most organic traffic | Sample crawl guesswork |
| `batch-url-analysis` | SEO metrics for multiple URLs at once | One-by-one page crawl |
| `brand-radar` | Brand mentions across AI agents (ChatGPT, Perplexity...) | Manual GEO visibility test |

**How to connect**: The user provides their Ahrefs account via MCP. No API key pasting needed — MCP handles authentication.

**If Ahrefs MCP is NOT connected**: All metrics are estimated from observable signals via `web_search` and `web_fetch`. Clearly flag this in the output: `"source": "estimated"` vs `"source": "ahrefs_mcp"`.

#### GA4 MCP *(optional)*
If connected (`github.com/googleanalytics/google-analytics-mcp`), pull real organic traffic, bounce rates, conversions.

#### GSC MCP *(optional)*
If connected (`github.com/ahonn/mcp-server-gsc`), pull real rankings, impressions, AI Overviews data, URL inspection.

### Base verification

Before starting, test that the site is accessible:
```
web_fetch: [URL]
```
If error (timeout, 5xx, maintenance) → note and stop. If redirect → follow and note the final URL.

---

## Step 1: Homepage metadata collection

Use `web_fetch` on the main URL and extract:

### 1.1 Essential HTML tags

Extract and structure: `<title>`, meta description, H1 (count), H2 list, canonical URL, lang attribute, hreflang tags, viewport meta, Open Graph tags, Twitter Card.

### 1.2 CMS detection

Look for markers in the HTML source: WordPress (`wp-content/`), Shopify (`cdn.shopify.com`), Webflow (`webflow.com`), Wix (`wix.com`), Next.js (`__NEXT_DATA__`), and others.

---

## Step 2: Robots.txt & Sitemap

### 2.1 Robots.txt

Fetch and parse robots.txt. For each AI bot (Googlebot, GPTBot, ChatGPT-User, PerplexityBot, ClaudeBot, anthropic-ai, Bingbot), determine if explicitly blocked, allowed, or inheriting from `User-agent: *`.

### 2.2 Sitemap XML

Fetch sitemap.xml. Extract: existence, URL, type (index or urlset), total URL count, sample URLs, last modified date.

---

## Step 3: Core Web Vitals

Search for PageSpeed Insights data via `web_search`. Structure results for LCP, CLS, INP, FCP, TTFB — both mobile and desktop. Note data source and freshness.

If data is not found, estimate based on HTML analysis (page weight, script count, image optimization).

---

## Step 4: HTTPS & Security headers

Analyze HTTP headers via `web_fetch`: HTTPS status, HSTS, Content-Security-Policy, X-Frame-Options, mixed content detection.

---

## Step 5: Schema markup detection

> ⚠️ **CRITICAL LIMITATION**: `web_fetch` cannot detect JavaScript-injected JSON-LD. Flag uncertainty if CMS is detected but no schema found in static HTML.

Search for `<script type="application/ld+json">`, `itemscope`/`itemtype` (Microdata), and `typeof`/`property` (RDFa) in the HTML.

---

## Step 5.5: Analytics & tracking audit

Analyze the HTML source from the homepage (and sample pages in Step 6) to detect which analytics and tracking tools are installed, and whether basic conversion tracking appears to be configured.

### 5.5.1 Analytics tool detection

Search the HTML for these markers:

| Tool | Detection pattern | What it means |
|---|---|---|
| Google Analytics 4 (GA4) | `gtag.js`, `G-XXXXXXX`, `googletagmanager.com/gtag` | Modern analytics — good |
| Google Tag Manager (GTM) | `googletagmanager.com/gtm.js`, `GTM-XXXXXXX` | Tag container — enables event tracking without code changes |
| Universal Analytics (UA) | `analytics.js`, `UA-XXXXXXX` | Legacy — deprecated July 2024, should be migrated to GA4 |
| Facebook/Meta Pixel | `fbq(`, `connect.facebook.net/en_US/fbevents.js` | Ad tracking — indicates paid social activity |
| Hotjar / Clarity | `hotjar.com`, `clarity.ms` | Heatmaps / session recording — indicates UX focus |
| Segment | `analytics.segment.com`, `cdn.segment.com` | CDP — indicates mature tracking stack |
| Mixpanel | `mixpanel.com/track`, `cdn.mxpnl.com` | Product analytics — indicates event-level tracking |
| Matomo / Piwik | `matomo.js`, `piwik.js` | Privacy-first analytics |
| Pinterest Tag | `pintrk(`, `s.pinimg.com` | Pinterest ad tracking |
| TikTok Pixel | `ttq.load`, `analytics.tiktok.com` | TikTok ad tracking |
| LinkedIn Insight | `snap.licdn.com/li.lms-analytics` | LinkedIn B2B tracking |

### 5.5.2 Conversion tracking signals

Look for indicators that conversion events are configured:

| Signal | What to look for | Status |
|---|---|---|
| Enhanced ecommerce | `purchase`, `add_to_cart`, `begin_checkout` in gtag calls or dataLayer pushes | ✅/❌ |
| Form tracking | Event listeners on `<form>` submit, or GTM form trigger patterns | ✅/❌ |
| Scroll tracking | `scroll` event in gtag or GTM | ✅/❌ |
| Click tracking | `click` events on CTAs, outbound links | ✅/❌ |
| dataLayer present | `window.dataLayer` initialized | ✅/❌ |
| Consent management | Cookie banner / CMP detected (Cookiebot, OneTrust, Axeptio, Didomi) | ✅/❌ |

### 5.5.3 UTM parameter handling

Check if the site preserves UTM parameters:
- Are UTMs visible in internal links (leak) or stripped properly?
- Does the site use consistent UTM naming? (search for `utm_source`, `utm_medium`, `utm_campaign` patterns)

### 5.5.4 Output structure

```json
{
  "analytics_tracking": {
    "tools_detected": {
      "ga4": { "present": true, "measurement_id": "G-XXXXXXX" },
      "gtm": { "present": true, "container_id": "GTM-XXXXXXX" },
      "ua_legacy": { "present": false },
      "meta_pixel": { "present": true },
      "hotjar_clarity": { "present": false, "tool": null },
      "segment": { "present": false },
      "mixpanel": { "present": false },
      "other": []
    },
    "conversion_tracking": {
      "ecommerce_events": false,
      "form_tracking": false,
      "scroll_tracking": false,
      "click_tracking": false,
      "datalayer_present": true,
      "consent_management": { "present": true, "tool": "Axeptio" }
    },
    "utm_handling": {
      "utm_params_detected_in_links": false,
      "consistent_naming": "unknown"
    },
    "maturity_level": "basic|intermediate|advanced",
    "issues": [
      "No ecommerce conversion tracking detected",
      "No heatmap/session recording tool installed"
    ],
    "recommendations": [
      "Set up GA4 ecommerce events (add_to_cart, purchase)",
      "Install Hotjar or Clarity for UX insights"
    ]
  }
}
```

**Maturity levels:**
- **basic**: GA4 or GTM present but no conversion events detected
- **intermediate**: GA4 + GTM + some conversion events + consent management
- **advanced**: Full event tracking + CDP (Segment) or product analytics (Mixpanel) + heatmaps + structured dataLayer

> This data feeds directly into the auditor's **Step 6: UX & Conversion** section, replacing guesswork with detected tracking state.

---

## Step 6: Sample pages crawl

Crawl 3-5 additional pages (from sitemap or navigation). For each, collect the same data as Step 1.

---

## Step 7: Ahrefs MCP data *(if connected)*

> This entire step is **skipped** if Ahrefs MCP is not connected. All data points are then marked as `"source": "estimated"` in the output.

### 7.1 Domain authority & backlinks

Query Ahrefs MCP:
- **Domain Rating**: `domain-rating` endpoint → real DR score
- **Backlinks stats**: `backlinks-stats` → total backlinks, referring domains, dofollow ratio
- **Broken backlinks**: `broken-backlinks` → list of broken inbound links (for the Implementer to generate redirects)

```json
{
  "ahrefs": {
    "source": "ahrefs_mcp",
    "domain_rating": 45,
    "ahrefs_rank": 123456,
    "backlinks_total": 12500,
    "referring_domains": 890,
    "dofollow_ratio": 0.72,
    "broken_backlinks": [
      { "url_from": "https://partner.com/old-link", "url_to": "https://example.com/404-page" }
    ]
  }
}
```

### 7.2 Organic keywords & positions

Query Ahrefs MCP:
- **Organic keywords**: `organic-keywords` → top 50 keywords the site ranks for with positions and volumes
- **Top pages**: `top-pages` → pages driving the most organic traffic

```json
{
  "ahrefs_keywords": {
    "total_organic_keywords": 2340,
    "top_keywords": [
      { "keyword": "linen curtains", "position": 3, "volume": 8100, "url": "/collections/lin" },
      { "keyword": "velvet cushions", "position": 7, "volume": 3200, "url": "/collections/coussins-velours" }
    ],
    "top_pages": [
      { "url": "/collections/rideau", "organic_traffic": 4500, "keywords_count": 120 }
    ]
  }
}
```

### 7.3 Competitors identification

Query Ahrefs MCP:
- **Organic competitors**: `organic-competitors` → sites competing for the same keywords

```json
{
  "ahrefs_competitors": [
    { "domain": "laredoute.fr", "common_keywords": 450, "competition_level": "high" },
    { "domain": "maison-monde.com", "common_keywords": 280, "competition_level": "medium" }
  ]
}
```

> This replaces the manual "identify competitors via web_search" step. The auditor can use these directly.

### 7.4 Brand Radar — AI visibility *(if available on user's plan)*

Query Ahrefs MCP:
- **Brand Radar**: `brand-radar` → brand mentions across AI agents

```json
{
  "ahrefs_brand_radar": {
    "source": "ahrefs_mcp",
    "ai_mentions": {
      "chatgpt": { "mentioned": true, "citation_count": 5 },
      "perplexity": { "mentioned": true, "citation_count": 3 },
      "google_ai_overview": { "mentioned": false },
      "claude": { "mentioned": true, "citation_count": 1 }
    },
    "real_prompts_with_citations": [
      { "platform": "chatgpt", "prompt": "best linen curtains France", "cited": true }
    ]
  }
}
```

> This is a **direct replacement for the manual GEO visibility test** (Step 5.6 in the auditor). Real data instead of manual searches.

---

## Step 8: Indexation & external presence

### 8.1 Google indexation
`web_search: "site:[domain]"` — estimate indexed page count.

### 8.2 Bing indexation
`web_search: "[domain] bing indexed"` — verify presence.

### 8.3 Brave Search indexation
`web_search: "[domain] brave search"` — verify presence (critical for Claude citations).

### 8.4 Local directories (Local mode)
Search for business on key directories (Yelp, TripAdvisor, Healthgrades, etc.).

---

## Step 9: Assemble site-data.json

Assemble all collected data into a single structured JSON file:

```json
{
  "metadata": {
    "collector_version": "2.0",
    "collection_date": "[ISO 8601]",
    "url_audited": "[URL]",
    "url_final": "[URL after redirects]",
    "domain": "[extracted domain]",
    "data_completeness": "high|medium|low",
    "mcp_integrations": {
      "ahrefs": true|false,
      "ga4": true|false,
      "gsc": true|false
    }
  },
  "homepage": { "..." },
  "cms_detected": "shopify|wordpress|...",
  "robots_txt": { "..." },
  "sitemap": { "..." },
  "core_web_vitals": { "..." },
  "security": { "..." },
  "schema_markup": { "..." },
  "analytics_tracking": { "..." },
  "pages_sample": [ "..." ],
  "indexation": { "..." },
  "ahrefs": { "..." },
  "ahrefs_keywords": { "..." },
  "ahrefs_competitors": [ "..." ],
  "ahrefs_brand_radar": { "..." },
  "issues_summary": {
    "critical": ["[list]"],
    "warnings": ["[list]"],
    "info": ["[list]"]
  }
}
```

Save to `seo-project-[domain]/site-data.json`.

If no `client-profile.md` exists, create a pre-filled one with detected information.

---

## Step 10: Summary for the user

After collection, present a clear summary:

```
═══════════════════════════════════════════
SEO DATA COLLECTION COMPLETE — [domain]
Date: [date]
═══════════════════════════════════════════

📊 Data collected:
   ✅ Homepage: title, meta, H1, OG tags
   ✅ Robots.txt: [X] AI bots allowed / [Y] blocked
   ✅ Sitemap: [N] URLs found
   ✅ Core Web Vitals: [source]
   ✅ Security: HTTPS [yes/no]
   ✅ Schema: [types found or "check needed"]
   ✅ Analytics: [tools detected] | Maturity: [basic/intermediate/advanced]
   ✅ Sample: [N] pages analyzed
   ✅ Indexation: ~[N] pages on Google

[If Ahrefs MCP connected:]
   ✅ Ahrefs DR: [score]/100 | Referring domains: [N]
   ✅ Organic keywords: [N] tracked | Top position: [N]
   ✅ Competitors: [N] identified
   ✅ Brand Radar: cited by [N] AI platforms

[If Ahrefs MCP NOT connected:]
   ℹ️ Backlinks & keywords: estimated (connect Ahrefs MCP for real data)

⚠️ Issues detected: [N critical] / [N warning]
   [Top 3 most important issues]

📁 File generated: site-data.json
   → Ready for seo-geo-audit

Would you like to run the full audit now?
```

---

## Error handling

| Situation | Action |
|---|---|
| Site inaccessible (timeout) | Retry after 5s. If still down → note and stop. |
| Robots.txt missing | Note `exists: false`, continue. |
| Sitemap missing | Check robots.txt for sitemap URL, otherwise note `exists: false`. |
| PageSpeed not found | Estimate via HTML analysis, note `source: "estimation"`. |
| Page 403/401 | Note, continue with other pages. |
| Rate limiting detected | Space out requests, note in report. |
| Ahrefs MCP timeout | Note the failure, continue without Ahrefs data. Flag in output. |
| Ahrefs MCP not connected | Skip Step 7 entirely, all metrics marked `"source": "estimated"`. |

---

## Pipeline chaining

The `site-data.json` file is designed to be read directly by `seo-geo-audit`. When the user asks to run the audit after collection:

1. Verify `site-data.json` exists
2. Pass it in context to the audit skill
3. The audit skill skips Step 0 (manual collection) and goes directly to analysis
4. If Ahrefs data is present, the auditor uses real metrics instead of estimates

> **Pattern 2 applied**: Output-as-input chaining. The collector writes structured JSON, the auditor reads it. Loose coupling, shared files as the API layer.
