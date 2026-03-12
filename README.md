# 🔍 seo-geo-audit — Expert SEO + GEO Audit Skill

[🇬🇧 English](./README.md) · [🇫🇷 Français](./README.fr.md)

> **Expert SEO audit (Local or General) + GEO (Generative Engine Optimization)**  
> Score-based report /90 · Competitive analysis · AI visibility · Prioritized action plan with ROI estimates  
> Reports generated in **English by default** · French available on request

---

## ⚡ Install

```bash
# Claude.ai (claude.ai interface)
# Download the .skill file from Releases and install via Settings > Skills

# Claude Code
npx skills add https://github.com/jgoullet/seo-geo-audit --skill seo-geo-audit

# OpenAI Codex CLI
npx skills add https://github.com/jgoullet/seo-geo-audit --skill seo-geo-audit
```

---

## What it does

This skill turns Claude into a **senior SEO consultant** capable of producing a complete, scored audit of any website — whether a local business or a national/international brand.

### Two audit modes

| Mode | For | Coverage |
|---|---|---|
| 🏘️ **Local** | Restaurant, artisan, doctor, local agency... | Technical SEO + Core Web Vitals + Local SEO + E-E-A-T + Entity SEO + GEO + UX |
| 🌐 **General** | E-commerce, SaaS, blog, media, B2B/B2C... | Technical SEO + Core Web Vitals + Content & Authority + E-E-A-T + Entity SEO + GEO + UX |

### Score breakdown — /90 total

| Dimension | Max | What's evaluated |
|---|---|---|
| SEO Technique | /10 | Title, meta robots, H1, URLs, HTTPS, security headers, sitemap, robots.txt, canonicals, redirects |
| Core Web Vitals | /10 | LCP, CLS, INP, FCP, TTFB — mobile vs desktop |
| Local SEO or Content & Authority | /20 | GBP, NAP, Local Pack / Topical authority, backlinks, rankings |
| E-E-A-T | /10 | Experience, Expertise, Authoritativeness, Trustworthiness |
| Entity SEO | /10 | Knowledge Panel, Wikidata, entity consistency, `sameAs` schema |
| GEO | /20 | Princeton methods, bot access, platform-specific signals, AI citation tests, SGE/AI Overviews monitoring |
| UX & Conversion | /10 | Navigation, CTAs, trust signals, analytics tracking, social signals, SERP → landing coherence |

---

## What's inside

### 📊 Expert scored report
Every dimension gets a numerical score with justification. No more vague "recommendations" — the client sees exactly where they stand and why.

### 🤖 GEO — Generative Engine Optimization
Based on the **Princeton/KDD 2024 research** (arXiv:2311.09735), the skill evaluates:
- The **9 GEO methods** with measured visibility boosts (+40% citations, +37% statistics...)
- **IA bot access** in `robots.txt` (GPTBot, PerplexityBot, ClaudeBot, anthropic-ai, Bingbot...)
- Platform-specific ranking signals for **ChatGPT, Perplexity, Google AI Overview, Copilot, and Claude**
- Note: Claude uses **Brave Search** (not Google/Bing) — a critical, often-missed detail

### 🏘️ Deep Local SEO
- Google Business Profile complete audit (12 criteria)
- NAP consistency across all directories
- Local Pack positioning
- LocalBusiness schema validation

### 🎯 E-E-A-T & Entity SEO
- Author credentials, YMYL compliance, trust signals
- Google Knowledge Panel, Wikidata ID, `Organization` + `sameAs` schema

### ⚠️ Schema detection guard
`web_fetch` cannot detect JavaScript-injected JSON-LD (Yoast, RankMath, AIOSEO...). The skill flags this and offers two paths: use **Cloudflare Browser Rendering** (automated, JS-rendered) if a token is available, or redirect to **Google Rich Results Test** to avoid false negatives.


### ☁️ Cloudflare Browser Rendering *(optional)*
If you have a Cloudflare account, provide your API token + Account ID to unlock:
- **CF-A — JS-rendered schema audit**: crawls key pages in a headless browser, detects all JSON-LD including JS-injected markup (Yoast, RankMath, Shopify...)
- **CF-B — Full site crawl**: audits up to 100+ pages automatically — thin content, orphan pages, missing titles/H1, schema coverage, crawl depth


### 📊 GA4 + GSC MCP Integrations *(optional)*
Connect official MCP servers to replace estimates with real data:
- **GA4 MCP** (`github.com/googleanalytics/google-analytics-mcp`) → real organic traffic, bounce rates, conversions, social referrals
- **GSC MCP** (`github.com/ahonn/mcp-server-gsc`) → real rankings, AI Overviews impressions, quick wins, URL inspection, keyword cannibalization

Without MCP: all metrics are estimated from observable signals (clearly flagged in the report).

### 📝 AI writing detection
When auditing content quality, the skill checks for AI writing markers (em dashes, "leverage", "robust", "in today's digital age"...) as E-E-A-T negative signals. Includes a full reference with replacements.

### 🏆 Competitive analysis
Side-by-side comparison table against up to 3 competitors across all 7 dimensions.

### 📋 Prioritized action plan with ROI
- 🟢 Quick wins (< 1 week)
- 🟡 Medium term (1–3 months)
- 🔴 Long term (3–6 months)

Each action includes: effort estimate, traffic/leads impact, required resources.

---

## Example usage

```
Audit https://mypizza.com in Local mode.
I run a pizza restaurant in Chicago.
Competitors: giordanos.com and loumalnatispizza.com
Goal: appear in the Google Local Pack
```

```
Run a full SEO audit of https://my-store.com
General mode — fashion & accessories e-commerce
Competitors: asos.com, zara.com
I have access to Google Search Console
```

The skill will collect missing info, run the full audit using web search and web fetch, and deliver a structured report scored /90 with a prioritized action plan.

```
Run a full SEO audit of https://my-saas.com
General mode — B2B SaaS
Cloudflare token: [token] / Account ID: [id]
```
*(With a Cloudflare token, schema detection and full site crawl are automated.)*

```
Audit https://my-saas.com in General mode — B2B SaaS
GA4 MCP: connected
GSC MCP: connected
```
*(With GA4 + GSC MCP, all traffic and ranking data is pulled live from real APIs.)*

---

## Report structure

```
1. EXECUTIVE SUMMARY         — Score /90, ranking vs competitors, top 3 strengths/weaknesses
2. SCORE DASHBOARD         — All 7 dimensions with 🔴/🟡/🟢 indicators
3. DETAILED RESULTS     — Score + justification + sources per dimension
4. COMPETITIVE ANALYSIS — Comparison table + keyword gap (top 10 targets)
5. ACTION PLAN + ROI     — Quick wins / Medium / Long term with impact estimates
6. TRACKING METRICS      — KPIs to track + alerts to configure
7. GLOSSARY               — Technical terms explained for non-specialists
8. CONCLUSION              — 3-sentence synthesis + re-audit recommendation
```

---

## Sector adaptation

| Sector | Specific priorities |
|---|---|
| Restaurant / Hotel | GBP +++, reviews, photos, structured menu |
| Health / Medical | E-E-A-T +++, YMYL disclaimers |
| Finance / Legal | E-E-A-T +++, expert authors, trust signals |
| E-commerce | Product schema, Core Web Vitals, faceted nav |
| SaaS / B2B | Topical authority, industry backlinks, case studies |
| Artisan / SMB | GBP, NAP consistency, local citations |

---

## Compatible with

![Claude Code](https://img.shields.io/badge/Claude_Code-✓-8B5CF6?style=flat-square)
![Claude.ai](https://img.shields.io/badge/Claude.ai-✓-8B5CF6?style=flat-square)
![OpenAI Codex CLI](https://img.shields.io/badge/Codex_CLI-✓-10B981?style=flat-square)

---

## Files

```
seo-geo-audit/
├── SKILL.md                  # Main skill — full audit framework
├── README.md                 # This file
├── README.fr.md              # French documentation
└── ai-writing-detection.md   # Reference — AI writing markers to avoid
```

---

## Sources & methodology

- **GEO methods**: Princeton University / IIT Delhi / Georgia Tech / Allen Institute for AI — *"GEO: Generative Engine Optimization"*, KDD 2024 ([arXiv:2311.09735](https://arxiv.org/abs/2311.09735))
- **Platform algorithms**: SE Ranking study (129K domains), Perplexity Sonar architecture analysis, Google Search Quality Rater Guidelines
- **AI writing detection**: Grammarly, Microsoft 365 Life Hacks, GPTHuman, Textero (2025)
- **Schema validation**: Informed by Google Rich Results Test limitations of static HTML parsers
- **Technical SEO checklist**: Inspired by [addyosmani/web-quality-skills](https://github.com/addyosmani/web-quality-skills) (meta robots, security headers, URL structure)
- **Cloudflare Browser Rendering**: [/crawl endpoint documentation](https://developers.cloudflare.com/browser-rendering/rest-api/crawl-endpoint/) (open beta, March 2026)
- **GA4 MCP**: [google-analytics-mcp](https://github.com/googleanalytics/google-analytics-mcp) — official Google Analytics MCP server
- **GSC MCP**: [mcp-server-gsc](https://github.com/ahonn/mcp-server-gsc) — Google Search Console MCP with Quick Wins detection

---

## License

MIT — free to use, modify, and redistribute.

---

*English report by default · French available on request · Compatible Claude Code & Claude.ai*
