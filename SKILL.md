---
name: seo-geo-audit
description: >
  Expert SEO audit skill (Local or General) + GEO: technical SEO, Core Web Vitals, E-E-A-T, Entity SEO,
  AI visibility (GEO), UX-conversion, competitive analysis. Scored report /90 with prioritized action plan and ROI estimates.
  Use for: SEO audit, local SEO, Google Business Profile, keyword gap, backlinks, featured snippets,
  Knowledge Panel, Wikidata, AI optimization (ChatGPT, Perplexity, AI Overviews, Claude), Core Web Vitals, E-E-A-T.
  Triggers on: "why does my competitor outrank me", "improve my SEO", "audit my site", "compare my site to X",
  "local SEO", "e-commerce SEO", "SaaS SEO", "I don't rank on Google", "optimize for AI search engines".
---

# 🔍 seo-geo-audit — Expert SEO + GEO Audit Skill

> **Report language**: Always in **English** by default. Switch to French only if the user explicitly requests it.

---

## Overview

This skill runs a complete, scored SEO + GEO audit in **two modes**:

| Mode | For | Modules |
|---|---|---|
| 🏘️ **Local** | Restaurant, contractor, doctor, local agency... | Technical SEO + Core Web Vitals + Local SEO + E-E-A-T + Entity SEO + GEO + UX |
| 🌐 **General** | E-commerce, SaaS, blog, media, B2B/B2C... | Technical SEO + Core Web Vitals + Content & Authority + E-E-A-T + Entity SEO + GEO + UX |

Delivers an **expert scored report /90** with scoring grids, competitive comparison table, and prioritized action plan with ROI estimates.

---

## Step 0: Information Gathering

Before starting, ask the user:

```
ESSENTIAL INFORMATION
─────────────────────
1. URL of the site to audit
2. Mode: Local 🏘️ or General 🌐?
   (If unclear → analyze the site and suggest the best fit)
3. Report language: English (default) — mention if you prefer French

4. [If Local] Target city / geographic area
5. [If Local] Business sector (restaurant, plumber, doctor...)
6. [If General] Main topic and target audience (B2B / B2C)
7. [If General] Site type (e-commerce, blog, SaaS, institutional...)
8. [If General] International / multilingual presence?

COMPETITORS & GOALS
───────────────────
9.  Competitor URLs to compare (1 to 3 — auto-identified if not provided)
10. Primary goal (traffic, leads, sales, brand awareness...)
11. Time horizon (short-term urgency / medium-long-term strategy)

TECHNICAL CONTEXT & ACCESS
───────────────────────────
12. Google Search Console available? (key data sharing possible)
13. Google Analytics / GA4 available?
14. CMS used? (WordPress, Shopify, Webflow, Wix, custom...)
15. Known Google penalties? (manual or algorithmic)
16. Available resources (solo, internal team, agency)

OPTIONAL — CLOUDFLARE BROWSER RENDERING
─────────────────────────────────────────
17. Cloudflare API token? (enables JS-rendered schema detection + full site crawl)
    → If yes: provide token + Cloudflare Account ID
    → Unlocks: Section CF-A (schema audit) and Section CF-B (full site crawl)
    → If no: standard audit with web_fetch + manual schema check tools

OPTIONAL — MCP INTEGRATIONS
─────────────────────────────
18. GA4 MCP connected? (github.com/googleanalytics/google-analytics-mcp)
    → If yes: Unlocks Section GA-A (real Analytics data — traffic, bounce, conversions, social referrals)
    → If no: metrics estimated from observable signals

19. GSC MCP connected? (github.com/ahonn/mcp-server-gsc or github.com/AminForou/mcp-gsc)
    → If yes: Unlocks Section GA-B (real GSC data — AI Overviews impressions, rankings, quick wins, URL inspection)
    → If no: manual checks via Google Search Console interface
```

> **Note**: If Analytics/GSC data is not shared, all metrics will be **estimates based on observable signals**. State this clearly in the report.

---

## Step 1: Technical SEO Audit

Use `web_search` and `web_fetch` to analyze:

### 1.1 On-Page & Structure

| Criterion | Check | Points |
|---|---|---|
| `<title>` tag | Primary keyword present, 50–60 chars, unique | /2 |
| Meta description | Compelling, 140–160 chars, with call to action | /2 |
| H1 | Unique, relevant, contains primary keyword | /1 |
| H2/H3 | Logical hierarchy, semantic coverage | /1 |
| URLs | Clean, readable, < 100 chars, no unnecessary parameters | /1 |
| Image ALT tags | Descriptive, present on all key images | /1 |
| Internal linking | Coherent, max 3 clicks from homepage | /2 |

**On-Page subtotal: /10**

### 1.2 Technical & Crawlability

| Criterion | Check | Points |
|---|---|---|
| HTTPS | Active, valid certificate, no mixed content | /1 |
| Mobile responsive | Adaptive design, no hidden content on mobile | /1 |
| XML Sitemap | Present (`/sitemap.xml`), submitted to GSC, up to date | /1 |
| Robots.txt | Not blocking important pages — check `/robots.txt`; AI bots verified in Section 5.1 | /1 |
| Meta robots | No `noindex` on important pages; no `max-snippet:0` blocking rich results | /1 |
| 404 Errors | None on main pages, clean 301 redirects | /1 |
| Redirects | No redirect chains (max 1 hop), no loops | /1 |
| Canonicals | `rel="canonical"` tags correctly implemented | /1 |
| Duplication | No internal or cross-page duplicate content | /1 |
| Pagination | Correctly handled (canonical or GSC signal) | /1 |
| Hreflang | Present and correct if multilingual site | /1 |
| Security headers | `Strict-Transport-Security`, `X-Content-Type-Options` present (E-E-A-T trust signal) | /1 |
| URL structure | Hyphens (not underscores), lowercase, < 75 chars, keywords present, no unnecessary parameters | /1 |

**Technical subtotal: /12 → normalized /10**

> **How to check meta robots**: `web_fetch` the page HTML and search for `<meta name="robots"`. Flag any `noindex`, `noarchive`, `nosnippet`, or `max-snippet:0` on pages that should appear in SERPs.
>
> **How to check security headers**: `web_fetch` the URL and inspect response headers, or `web_search: "security headers [domain]"` using securityheaders.com.

> ⚠️ **Schema Markup Detection — Choose your method based on available access**
>
> `web_fetch` **cannot detect JSON-LD injected via JavaScript** (Yoast, RankMath, Shopify, Webflow...). Always use one of the methods below.
>
> **🟦 If Cloudflare API token provided** → use Section CF-A below (JS-rendered, fully automated)
>
> **🔲 Without Cloudflare token** → use one of these manual tools:
> 1. **Google Rich Results Test** → https://search.google.com/test/rich-results
> 2. **Schema.org Validator** → https://validator.schema.org
> 3. **Screaming Frog** *(if provided by client)*
>
> Always state in the report which method was used, and flag uncertainty if none was available.

### 1.3 Core Web Vitals *(critical — direct ranking impact)*

Fetch data from PageSpeed Insights (`web_search: "PageSpeed Insights [URL]"`):

| Metric | Good | Needs Work | Poor | Points |
|---|---|---|---|---|
| **LCP** (Largest Contentful Paint) | < 2.5s | 2.5–4s | > 4s | /2 |
| **CLS** (Cumulative Layout Shift) | < 0.1 | 0.1–0.25 | > 0.25 | /2 |
| **INP** (Interaction to Next Paint) | < 200ms | 200–500ms | > 500ms | /2 |
| **FCP** (First Contentful Paint) | < 1.8s | 1.8–3s | > 3s | /1 |
| **TTFB** (Time to First Byte) | < 800ms | 800ms–1.8s | > 1.8s | /1 |
| Mobile vs Desktop | Consistent scores | Moderate gap | Gap > 20pts | /2 |

> **Scoring grid**: Good = full points, Needs Work = half points, Poor = 0 points

**Core Web Vitals subtotal: /10**

**Technical SEO Global Score: /30**

---
---

## Section CF-A: Cloudflare — JS-Rendered Schema Audit *(optional — requires API token)*

> **Prerequisite**: Cloudflare API token + Account ID provided in Step 0.
> Skip this section if no token was provided and use manual tools instead (see guardrail above).

Use the Cloudflare Browser Rendering `/crawl` endpoint with `render: true` to extract JS-injected structured data.

### CF-A.1 Initiate the crawl (schema-focused)

```
POST https://api.cloudflare.com/client/v4/accounts/{account_id}/browser-rendering/crawl
Authorization: Bearer {api_token}
Content-Type: application/json

{
  "url": "[SITE URL]",
  "render": true,
  "limit": 10,
  "responseFormat": "json",
  "allowedDomains": ["[DOMAIN ONLY]"]
}
```

> Use `limit: 10` to crawl homepage + key pages (service, product, about, contact). Increase to 50+ for a deeper audit.

### CF-A.2 Retrieve and analyze results

```
GET https://api.cloudflare.com/client/v4/accounts/{account_id}/browser-rendering/crawl/{job_id}
Authorization: Bearer {api_token}
```

Poll until `status: finished`. Then for each page, extract and analyze:

| Schema type | What to check |
|---|---|
| `FAQPage` | Present on FAQ / support pages |
| `LocalBusiness` | Complete with `sameAs`, address, hours |
| `Organization` | `sameAs` pointing to all official profiles |
| `Article` + `dateModified` | On all blog/news articles |
| `Product` / `Offer` | On e-commerce product pages |
| `BreadcrumbList` | On all multi-level pages |
| `AggregateRating` | On pages with reviews |
| `HowTo` | On tutorial / guide pages |

Report: list schemas found per page, schemas missing, and pages without any structured data.

---

## Section CF-B: Cloudflare — Full Site Crawl *(optional — requires API token)*

> **Prerequisite**: Cloudflare API token + Account ID provided in Step 0.
> This section replaces the manual page-by-page sampling with a comprehensive site-wide audit.

### CF-B.1 Initiate the full crawl

```
POST https://api.cloudflare.com/client/v4/accounts/{account_id}/browser-rendering/crawl
Authorization: Bearer {api_token}
Content-Type: application/json

{
  "url": "[SITE URL]",
  "render": true,
  "limit": 100,
  "responseFormat": "markdown"
}
```

> Adjust `limit` based on site size. Use `render: false` for purely static sites (faster, free during beta).

### CF-B.2 What to extract from crawl results

Once the crawl is complete, analyze the full page inventory for:

| Audit dimension | What to look for across all pages |
|---|---|
| **Thin content** | Pages with < 300 words — flag each URL |
| **Missing title / H1** | Pages where title or H1 is absent or duplicated |
| **Duplicate content** | Near-identical pages — potential cannibalization |
| **Broken internal links** | URLs discovered but returning errors |
| **Orphan pages** | Pages not linked from anywhere else on the site |
| **Schema coverage** | % of pages with structured data vs without |
| **Crawl depth** | Pages more than 3 clicks from the homepage |
| **Missing meta descriptions** | Flag each URL |
| **hreflang consistency** | If multilingual — flag mismatches |

### CF-B.3 Crawl summary table

Add to the report:

| Metric | Value |
|---|---|
| Total pages crawled | |
| Pages with thin content (< 300 words) | |
| Pages without title tag | |
| Pages without H1 | |
| Pages without schema markup | |
| Estimated crawl depth > 3 clicks | |
| Orphan pages detected | |

> ⚠️ **Cost reminder**: `render: true` uses Cloudflare Browser Rendering billing. A 100-page crawl uses ~5 min of browser time. Free plan = 10 min/day. Paid plan ($5/mo) = ~10 hrs/mo included.

---
---

## Section GA-A: GA4 MCP — Analytics & Tracking Audit *(optional — requires GA4 MCP)*

> **Prerequisite**: Google Analytics MCP connected (`github.com/googleanalytics/google-analytics-mcp`).
> Skip this section if not connected — state "estimated from observable signals" for all metrics.

### GA-A.1 Tracking implementation check

Query GA4 MCP to verify:

| Check | Query | Expected |
|---|---|---|
| GA4 tag present | Real-time users > 0 | ✅ active tracking |
| No double counting | Sessions vs pageviews ratio | Normal ratio (1.5–4×) |
| Organic traffic identified | Sessions by channel: `organic search` | > 0 sessions |
| Goals / conversions configured | Conversion events list | ≥ 1 conversion event |
| Internal traffic excluded | Filter check | IP filters active |

Flag any anomalies as **tracking issues** in the report — bad data = bad decisions.

### GA-A.2 Organic traffic analysis

| Metric | Query | Benchmark |
|---|---|---|
| Organic sessions (last 90 days) | `sessions` filtered by `organic search` | Trend: stable or growing |
| Organic vs total traffic share | `sessions` by channel | Healthy: > 30% organic |
| Top organic landing pages | `sessions` by `landingPage`, organic | Top 10 pages |
| Organic bounce rate | `bounceRate` by channel | < 60% good, > 80% concern |
| Avg. session duration (organic) | `averageSessionDuration` organic | > 90s good |
| Mobile vs desktop organic split | `sessions` by `deviceCategory` organic | Mobile > 50% expected |

### GA-A.3 Content performance

| Metric | Query | Signal |
|---|---|---|
| Top pages by organic sessions | Top 20 pages — cross-reference with audit | Pages worth auditing first |
| Pages with high bounce + low time | Bounce rate > 70% AND duration < 30s | Content / UX issue |
| Pages with 0 organic sessions (30d) | Pages present in sitemap but no organic traffic | Thin / non-indexed content |
| New vs returning organic visitors | `newUsers` vs `returningUsers` | < 20% returning = low loyalty |

### GA-A.4 Conversion & UX signals

| Metric | Query | Signal |
|---|---|---|
| Conversion rate (organic) | `conversions / sessions` organic | Benchmark varies by sector |
| Top converting organic pages | `conversions` by `landingPage` organic | Protect and optimize these |
| Social referral traffic | `sessions` by source: `social` | Which platforms drive traffic |
| Social referral top sources | Sessions by `sessionSource` social | Facebook / LinkedIn / Instagram / Pinterest... |

> Add a **GA4 Data Summary** box to the report with: organic sessions (90d), organic share %, top 5 landing pages, conversion rate organic.

---

## Section GA-B: GSC MCP — AI Overviews & Quick Wins *(optional — requires GSC MCP)*

> **Prerequisite**: Google Search Console MCP connected (`ahonn/mcp-server-gsc` or `AminForou/mcp-gsc`).
> Skip this section if not connected — use manual GSC interface checks instead.

### GA-B.1 AI Overviews (SGE) monitoring

```
# Query GSC MCP for AI Overview impressions
dimensions: query, page
searchType: web
dateRange: last 90 days
filter: searchAppearance = AI_OVERVIEW
```

| Metric | What to look for |
|---|---|
| AI Overview impressions | Total queries where site appears in AI Overviews |
| AI Overview clicks | CTR from AI Overview citations |
| AI Overview CTR vs standard | Compare CTR — AI Overview CTR is typically lower |
| Top queries triggering AI Overview | Which keywords → AI citation |
| Pages cited in AI Overviews | Which URLs are being cited |

> If AI Overview impressions = 0: the site is not yet cited in Google AI Overviews → treat as GEO priority in the action plan.

### GA-B.2 Quick wins detection

```
# Positions 4–15 with significant impressions = quick win opportunities
detectQuickWins: true
quickWinsConfig:
  positionRange: [4, 15]
  minImpressions: 500
  minCtr: 2
```

For each quick win identified:

| Page | Keyword | Position | Impressions | CTR | Action |
|---|---|---|---|---|---|
| [URL] | [query] | [pos] | [imp] | [ctr]% | Optimize title / content / internal links |

> Quick wins = pages ranking P4–15 with volume — small optimization → jump to P1–3. Highest ROI actions in the plan.

### GA-B.3 Keyword cannibalization detection

```
# Multiple pages ranking for the same query
dimensions: query, page
filter: position < 20
rowLimit: 5000
```

Flag queries where 2+ pages rank in top 20 → cannibalization risk → consolidation recommended.

### GA-B.4 URL inspection & indexing health

For the top 20 pages (by impressions), run URL inspection:

| Check | Expected |
|---|---|
| Indexing status | Indexed |
| Last crawl date | < 30 days |
| Mobile usability | No issues |
| Rich results eligible | Yes (if schema present) |
| Canonical URL | Matches intended URL |

Flag any pages with indexing issues, mobile usability errors, or stale crawl dates.

### GA-B.5 Social signals via GSC

```
# Search appearance: sitelinks, image search, video search
dimensions: query, searchAppearance
```

| Signal | What it reveals |
|---|---|
| Sitelinks appearing | Strong brand authority |
| Image search impressions | Visual content indexed and performing |
| Video search impressions | Video content indexed |
| Rich result appearances | Schema markup triggering enhancements |

> Add a **GSC Data Summary** box to the report with: total impressions (90d), avg position, AI Overview impressions, top 5 quick wins, pages with indexing issues.

---

## Step 2A: Local SEO Audit 🏘️ *(Local mode only)*

### 2A.1 Google Business Profile (GBP)

Search `"[business name] [city]"` on Google and analyze the listing:

| Criterion | Check | Points |
|---|---|---|
| Claimed listing | Ownership verified by the business | /2 |
| Primary category | Accurate and matching the business | /2 |
| Secondary categories | 2–5 relevant categories listed | /1 |
| Photos | Recent (< 6 months), varied (interior, team, products) | /2 |
| Reviews — quantity | > 20 reviews (local pack) / > 50 (excellent) | /2 |
| Reviews — rating | ≥ 4.5/5 (excellent) / 4.0–4.4 (good) / < 4.0 (needs work) | /2 |
| Review responses | 100% of negative reviews answered, positives ideally too | /2 |
| GBP posts | Published at least once/week | /1 |
| Attributes | Hours, accessibility, payment methods, services listed | /2 |
| Q&A | Questions and answers present | /1 |
| Products/Services | Complete section with descriptions and prices if applicable | /1 |
| Phone number | Correct and clickable | /1 |

**GBP subtotal: /19 → normalized /20**

### 2A.2 Citations & NAP Consistency

| Criterion | Check | Points |
|---|---|---|
| NAP consistency | Name, Address, Phone **identical** across all platforms | /4 |
| Major directories | Present on top 3 for the sector (Yelp, TripAdvisor, Zocdoc...) | /3 |
| Social media | Facebook/Instagram active with consistent address | /2 |
| Website | Address in footer, complete Contact page | /2 |
| Schema LocalBusiness | Implemented with all key properties | /3 |
| Schema AggregateRating | Review structured data present | /2 |
| BreadcrumbList schema | If multi-page site | /1 |
| Open Graph | Correct OG tags for social sharing | /1 |

**Citations & NAP subtotal: /18 → normalized /20**

### 2A.3 Local Keywords & Rankings

Search: `"[trade] [city]"`, `"[trade] near me"`, `"best [trade] [city]"`:

| Criterion | Check | Points |
|---|---|---|
| Local Pack (3 Maps listings) | Present in top 3 map results | /4 |
| Organic position P1–3 | On primary keyword `[trade] [city]` | /4 |
| Organic position P4–10 | Present on first page | /2 |
| Local long-tail | Presence on variants and neighborhoods | /2 |
| Google Suggest | Brand appears in suggestions | /2 |
| Local Featured Snippet | Position 0 captured | /2 |
| Review stars in SERPs | Rich snippets visible | /2 |
| FAQ in SERPs | FAQ schema triggers rich result | /2 |

**Local Keywords subtotal: /20**

**Local SEO Score: /60 → normalized to /20 in recap**

---
---

### 2A.4 Review Velocity & Response Strategy *(Local mode — delivers actionable templates)*

> Reviews are the most visible local ranking factor. This section goes beyond star rating — it analyzes **velocity** (how fast competitors gain reviews) and delivers a ready-to-use **response template system** that turns every response into a keyword-rich ranking signal.

#### Review velocity analysis

Search `web_search: "site:google.com/maps [competitor name]"` and analyze recent reviews:

| Metric | My Business | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| Total reviews | | | | |
| Reviews last 30 days | | | | |
| Reviews last 90 days | | | | |
| Average rating | | | | |
| % reviews with owner response | | | | |
| Avg response time | | | | |
| Keywords mentioned in reviews | | | | |
| Neighborhoods mentioned | | | | |

> **Reviews per month needed to catch leader**: calculate `(leader total - my total) / 6 months` → this becomes the review velocity target in the action plan.

> ⚡ **Key insight**: Reviews mentioning specific services and neighborhoods ("great furnace install in Lincoln Park") are ranking signals. Analyze what customers say in competitor reviews — then ask your own happy customers to mention those same services and areas.

#### Review response template system

Generate the following templates — each must naturally include **service + city keywords** without sounding robotic. Produce **3 variations per type** to avoid repetitive-looking responses.

**Template A — 5-star review** *(keyword-rich, warm)*
```
Thank you [first name]! We're so glad the [specific service] went smoothly for you in [neighborhood/city].
The team really enjoyed working on your [job detail if mentioned]. If you ever need [related service],
don't hesitate to reach out — we're always here for [city] homeowners. ⭐
```
*Customize: insert primary keyword + service area + related service upsell*

**Template B — 4-star review** *(acknowledge + invite feedback)*
```
Thank you for the kind words, [first name]! We're glad the [service] met your expectations.
We always aim for 5-star [service] in [city] — if there's anything we can improve,
please don't hesitate to reach out directly at [phone/email]. We'd love to earn that 5th star.
```

**Template C — 3-star review** *(professional + resolution-focused)*
```
Thank you for taking the time to share your feedback, [first name].
We're sorry the [service] experience didn't fully meet your expectations — that's not the standard
we hold ourselves to for [city] customers. Please contact us at [phone] so we can make this right.
```

**Template D — 1–2 star review** *(defuse, never defensive)*
```
Thank you for your feedback, [first name]. We take every review seriously and we're sorry
your experience with [service] didn't reflect our usual standards. We'd genuinely like to
resolve this — please reach out to us directly at [phone/email] so we can make it right.
```

> 🔑 **SEO value of responses**: 12 reviews/month × keyword-rich response = 144 pieces of location + service keyword content on your GBP per year. Compounding signal that most competitors ignore entirely.

> 📋 **Deliverable**: Include the 4 template sets (3 variations each = 12 templates total) as an appendix in the final report, ready to copy-paste.

---

## Step 2B: Content & Authority Audit 🌐 *(General mode only)*

### 2B.1 Content Strategy

| Criterion | Check | Points |
|---|---|---|
| Topical Authority | Complete and coherent thematic coverage | /3 |
| Pillar pages | Long-form articles (2000+ words), well-structured, exhaustive | /2 |
| Long-tail content | Questions, comparisons, guides, "how to..." | /2 |
| Freshness | Recent update dates, content kept current | /2 |
| Cannibalization | No internal competition on the same keywords | /2 |
| Readability | Appropriate for the audience, short paragraphs, lists | /2 |
| Semantic field | Named entities and relevant co-occurrences present | /2 |
| Multimedia content | Images, videos, infographics, podcasts integrated | /2 |
| No thin content | No pages < 300 words without added value | /3 |

**Content subtotal: /20**

### 2B.2 Authority & Link Building

| Criterion | Check | Points |
|---|---|---|
| Referring domains | Estimated count (web search) | /3 |
| Source quality | Press, recognized partners, universities, institutions | /4 |
| Anchor diversity | Natural profile (brand, generic, exact match balanced) | /2 |
| Recent inbound links | Regular acquisition (activity signal) | /2 |
| Toxic links | No apparent spam links | /2 |
| Wikipedia/Wikidata presence | Mentions or dedicated page | /2 |
| Unlinked press mentions | Brand mentions without links (authority signal) | /3 |
| Outbound links | To recognized and relevant sources | /2 |

**Link Building subtotal: /20**

### 2B.3 Organic Rankings & Keyword Gap

Search for the 5–10 main sector keywords:

| Criterion | Check | Points |
|---|---|---|
| Top 3 positions | On ≥ 2 strategic keywords | /4 |
| Top 10 positions | On ≥ 5 sector keywords | /3 |
| Featured Snippets | ≥ 1 position 0 captured | /3 |
| Keyword gap | Competitor keywords not covered — identified | /3 |
| Organic CTR | Compelling and differentiated title/meta | /3 |
| Seasonality | Content adapted to search volume peaks | /2 |
| Brand queries | Site dominates on its own name | /2 |

**Rankings subtotal: /20**

**Content & Authority Score: /60 → normalized to /20 in recap**

---

## Step 3: E-E-A-T Audit *(both modes)*

> **E-E-A-T** = Experience, Expertise, Authoritativeness, Trustworthiness — a core criterion of Google's Quality Rater Guidelines, especially critical for YMYL sites (health, finance, legal...).

### 3.1 Experience & Expertise

| Criterion | Check | Points |
|---|---|---|
| Author pages | Full bio with photo, credentials, professional network links | /3 |
| Proof of experience | Case studies, client testimonials, portfolio, before/after | /3 |
| Expert content | Source citations, verifiable data, referenced studies | /2 |
| Content age | Site seniority and domain of expertise | /2 |

**Experience & Expertise subtotal: /10**

### 3.2 Authority & Trust

| Criterion | Check | Points |
|---|---|---|
| "About" page | History, team, values, certifications | /2 |
| Press mentions | Appearances in recognized media (verify via search) | /2 |
| Certifications & badges | Quality labels, professional memberships | /2 |
| Privacy policy | Present, up to date, GDPR/CCPA compliant | /1 |
| Legal notices | Complete and accessible | /1 |
| T&Cs | Present if commercial site | /1 |
| Verified third-party reviews | Trustpilot, Google Reviews, Verified Reviews | /3 |
| Complete contact info | Physical address, phone, email visible | /2 |
| YMYL signals | For sensitive sectors: disclaimers, "consult a professional" notices | /3 |
| Active social media | Consistent presence and communication | /3 |

**Authority & Trust subtotal: /20**

**E-E-A-T Score: /30 → normalized to /10 in recap**

---

## Step 4: Entity SEO *(both modes)*

> **Entity SEO** measures the recognition of the entity (brand, business, person) by Google and LLMs, independently of keywords. It is the foundation of GEO.

### 4.1 Entity Existence in the Knowledge Graph

| Criterion | Check | Points |
|---|---|---|
| Google Knowledge Panel | Side panel present on brand search | /4 |
| Wikidata | Q identifier present, consistent data | /3 |
| Wikipedia | Dedicated page or mention in relevant articles | /3 |
| Google Maps (if local) | Entity correctly linked to Maps listing | /2 |

**Knowledge Graph subtotal: /12 → normalized /10**

### 4.2 Entity Consistency

| Criterion | Check | Points |
|---|---|---|
| Entity name | Identical across all channels (site, social, GBP, Wikidata...) | /3 |
| `Organization` / `LocalBusiness` schema | Present with `sameAs` pointing to all official profiles | /3 |
| Canonical entity URLs | LinkedIn, Twitter/X, Facebook, YouTube profiles consistent | /2 |
| Geographic anchoring | Address consistent everywhere (if local) | /2 |

**Entity Consistency subtotal: /10**

**Entity SEO Score: /20 → normalized to /10 in recap**

---

## Step 5: GEO Audit *(both modes)*

> **GEO** (Generative Engine Optimization) measures a site's ability to be **cited, summarized, or recommended by generative AI**: Google AI Overviews, ChatGPT Search, Perplexity, Gemini, Copilot, Claude...
>
> **Core principle:** AIs don't "rank" pages — they **cite sources**. Being cited = the new "ranking #1". *(Source: Princeton/KDD 2024, arXiv:2311.09735)*

---

### 5.1 AI Bot Accessibility *(critical prerequisite)*

> A site blocking AI crawlers in `robots.txt` is **invisible to all AI engines**. Check via `web_fetch: "[URL]/robots.txt"`.

| AI Bot | User-agent to allow | Platform | Points |
|---|---|---|---|
| Googlebot | `Googlebot` | Google AI Overview | /2 |
| GPTBot | `GPTBot` | ChatGPT (OpenAI) | /2 |
| ChatGPT-User | `ChatGPT-User` | ChatGPT with browsing | /1 |
| PerplexityBot | `PerplexityBot` | Perplexity AI | /2 |
| ClaudeBot | `ClaudeBot` | Claude (Anthropic) | /1 |
| anthropic-ai | `anthropic-ai` | Claude (Anthropic) | /1 |
| Bingbot | `Bingbot` | Copilot / Bing | /1 |

> ⚠️ **Important**: Claude uses **Brave Search** (not Google or Bing). To be cited by Claude, the site must be indexed by Brave Search AND allow ClaudeBot/anthropic-ai.

> 🚨 **Cloudflare WAF check** (Bobbink/Friends of Search 2026): Cloudflare's default WAF rules can silently block AI crawlers even when `robots.txt` allows them. Check: Cloudflare dashboard → Security → Events → filter by blocked user-agents. GPTBot, ClaudeBot, PerplexityBot must not appear as blocked. This is a common invisible GEO blocker.

> 📊 **AI crawler growth context** (Cloudflare 2025): GPTBot +305% YoY — ChatGPT-User +2,825% — PerplexityBot +157,490% in raw requests. Crawl-to-citation ratio: Google 3:1 vs OpenAI 400:1 vs Anthropic 100,000:1. Note: 30% of AI scrapers now bypass `robots.txt` blocks (TollBit Q4 2025).

**AI Bot Accessibility subtotal: /10**

---

### 5.2 Content Optimization — The 9 GEO Methods (Princeton/KDD 2024)

> Validated on Perplexity.ai (10,000+ queries tested). Percentages = **average visibility boost** in AI responses.

| Method | Boost | How to evaluate | Points |
|---|---|---|---|
| **1. Cite sources** | +40% | Content cites studies, reports, recognized institutions | /3 |
| **2. Add statistics** | +37% | Verifiable quantitative data with dated sources | /3 |
| **3. Add expert quotes** | +30% | Quotes attributed to named experts | /2 |
| **4. Authoritative tone** | +25% | Assertive, expert language, no vague phrasing | /2 |
| **5. Accessible content** | +20% | Complex concepts explained simply | /2 |
| **6. Technical terminology** | +18% | Relevant sector jargon used correctly | /2 |
| **7. Varied vocabulary** | +15% | No repetition, synonyms, lexical richness | /1 |
| **8. Fluency optimization** | +15–30% | Well-written, logical transitions, short paragraphs | /2 |
| **9. ❌ Keyword stuffing** | **-10%** | Absence of keyword over-optimization | /3 |

> 🏆 **Best combination**: Fluency + Statistics = maximum boost per Princeton research.

**GEO Methods subtotal: /20**

---

### 5.3 Content Structure for LLMs

| Criterion | Check | Points |
|---|---|---|
| Answer-first format | Direct answer in the first paragraph | /3 |
| Paragraph length | < 3–4 sentences per block | /2 |
| Structured FAQ | Questions/answers in explicit Q&A format | /3 |
| Clear definitions | Services/products defined at the start of sections | /2 |
| Lists and tables | Visually structured data (highly cited by AIs) | /2 |
| Question-based headings | H2/H3 phrased as questions ("How to...", "Why...") | /2 |
| Unique content | Real added value, no paraphrasing of existing content | /3 |
| Public PDFs | Accessible PDF documents (prioritized by Perplexity) | /1 |
| Freshness | Content updated within the last 30 days (×3.2 ChatGPT citations) | /2 |

**LLM Content Structure subtotal: /20**

---

### 5.4 Structured Data for AI

| Criterion | Check | Points |
|---|---|---|
| `FAQPage` schema (JSON-LD) | Present on FAQ pages — **+40% AI visibility** | /3 |
| `LocalBusiness` schema | [Local mode] Complete with all key properties | /3 |
| `Article` + `dateModified` | [General mode] On all articles, with update date | /2 |
| `Product` / `Offer` schema | [E-commerce] On product pages | /2 |
| `Organization` + `sameAs` | Links to all official profiles | /2 |
| `BreadcrumbList` schema | Structured breadcrumb trail | /1 |
| `Review` / `AggregateRating` | Structured customer reviews | /2 |
| `HowTo` schema | [If relevant] Step-by-step guides | /2 |
| Open Graph & Twitter Card | Correct social metadata | /1 |
| JSON-LD format | Google's recommended format (vs Microdata) | /2 |

**Structured Data subtotal: /20**

---

### 5.5 Platform-Specific AI Optimization

#### 🤖 ChatGPT (OpenAI)
*Index: Bing-based + web browsing. Factor #1: Domain Authority*

| Signal | Target value | Present? |
|---|---|---|
| Referring domains | > 350K = 8.4 avg citations (SE Ranking study — 129K domains) | ✅/❌/🟡 |
| Content freshness | < 30 days = ×3.2 citations | ✅/❌/🟡 |
| Branded domain | +11.1 pts vs third-party domains | ✅/❌ |
| Content-Answer Fit | Content matches ChatGPT's response style | ✅/❌ |
| Wikipedia/Reddit presence | Top citation sources (7.8% + 1.8% of citations) | ✅/❌ |

#### 🔍 Perplexity AI
*3-layer RAG architecture. Factor #1: Semantic relevance*

| Signal | Target value | Present? |
|---|---|---|
| PerplexityBot allowed | `robots.txt` not blocking | ✅/❌ |
| FAQPage schema | FAQ pages cited more often | ✅/❌ |
| Public PDFs | Prioritized for citation | ✅/❌ |
| Topical authority | Complete subject coverage | ✅/❌ |
| Publishing velocity | New content evaluated quickly | ✅/❌ |

#### 🌐 Google AI Overview (SGE)
*5-stage pipeline. Factor #1: E-E-A-T + Knowledge Graph*

| Signal | Target value | Present? |
|---|---|---|
| Strong E-E-A-T | Expertise + Authority + Trust | ✅/❌ |
| Knowledge Graph | Entity in Google's graph | ✅/❌ |
| Authoritative citations | +132% visibility with trusted references | ✅/❌ |
| Authoritative tone | +89% visibility | ✅/❌ |
| Topical clusters | Coherent internal linking by subject | ✅/❌ |

#### 🖥️ Microsoft Copilot / Bing
*Bing index. Factor #1: Bing indexation*

| Signal | Target value | Present? |
|---|---|---|
| Indexed by Bing | Check `bing.com/search?q=site:[domain]` | ✅/❌ |
| Bingbot allowed | `robots.txt` not blocking | ✅/❌ |
| LinkedIn/GitHub presence | Boost in Microsoft ecosystem | ✅/❌ |
| Page speed | < 2 seconds | ✅/❌ |

#### 🤖 Claude (Anthropic)
*Index: **Brave Search** (≠ Google/Bing). Crawl-to-citation ratio: 38,065:1 — highly selective*

| Signal | Target value | Present? |
|---|---|---|
| Indexed by Brave Search | Check `search.brave.com/search?q=site:[domain]` | ✅/❌ |
| ClaudeBot + anthropic-ai allowed | `robots.txt` not blocking | ✅/❌ |
| Factual density | Content rich in verifiable data | ✅/❌ |
| Structural clarity | Information easily extractable | ✅/❌ |

**Platform Optimization subtotal: /10** *(overall qualitative assessment)*

> 📊 **Brand mentions vs backlinks** (Ahrefs, December 2025 — 75,000 brands analyzed): Brand mentions across the web correlate **3× more** with AI citations than traditional backlinks. YouTube mentions show the strongest correlation across all AI platforms. 76.1% of AI-cited URLs also rank in Google's top 10. Key implication: *topics are the new keywords, topical authority is the new PageRank* — unlinked brand mentions are now a first-class GEO signal to track and build.

> 🛠️ **Recommended tools for GEO audit**: [Glippy.dev](https://glippy.dev) (AI visibility auditor by Jan-Willem Bobbink) — audits crawlability, renderability, and structured data from an AI agent perspective.

---

### 5.6 AI Visibility Test

Run the following searches and note whether the site is cited:

**[Local mode]**
- `"best [trade] in [city]"` → Google AI Overview present? Site cited?
- `"[trade] [city] reviews"` → Perplexity / ChatGPT Search → Site mentioned?
- `"[business name]"` → ChatGPT + Brave Search → Correct information returned?

**[General mode]**
- Top informational queries in the sector → AI Overview → Site cited?
- `"best [product/service] for [use case]"` → Perplexity → Site recommended?
- Long-tail sector questions → ChatGPT → Site mentioned as a source?

| Test Result | Points |
|---|---|
| Cited in Google AI Overview | /4 |
| Cited in Perplexity | /3 |
| Cited in ChatGPT Search | /3 |
| Indexed and cited via Brave/Claude | /2 |
| Entity information correct in AIs | /3 |
| No AI bot blocked | /5 |

**AI Visibility Test subtotal: /20**

### 5.7 SGE / AI Overviews Monitoring

> **If GSC MCP connected** → use Section GA-B for real impression data.
> **Without GSC MCP** → use manual checks below.

| Check | Method | Signal |
|---|---|---|
| AI Overview presence on brand queries | Search `"[brand name]"` — AI Overview visible? | Brand authority |
| AI Overview presence on sector queries | Search top 5 keywords — site cited? | GEO visibility |
| GSC AI Overview impressions (if GSC MCP) | Section GA-B query | Trending up / down / zero |
| SGE CTR vs standard organic CTR | GA-B data or manual estimate | AI Overview CTR typically lower |
| Featured Snippet → AI Overview correlation | Pages with Featured Snippets often cited in AIO | Protect these pages |

> Pages ranking in Featured Snippets are significantly more likely to be cited in AI Overviews. Identify and protect them as high-priority GEO assets.

#### 🔲 Without GSC MCP — Query Fan-Out Detection (manual)

AI systems (ChatGPT, Perplexity, Google AI Mode) decompose user queries into multiple sub-queries before searching the web — a mechanism called **query fan-out**. These sub-queries are longer, more conversational, and invisible in standard keyword reports. They do appear in GSC as long-tail impressions.

**Manual method — GSC Performance tab → Queries → Filter → Custom (regex):**

```
# Step 1 — Capture all queries 10+ words (typical AI sub-query length)
(\b\w+\b\s){9,}
Filter: impressions > 100 to go straight to real opportunities
```

```
# Step 2 — Isolate AI-preferred formats (combine with Step 1)
^(?i)(how|what|which|why|best way|step by step|guide|compare|vs|difference|is it|can i|should i).*
```

**What this reveals:**
- Pages already ranking on AI sub-queries without intentional targeting
- Thematic clusters that AIs push as sub-queries
- Content to enrich in priority: step-by-step, comparisons (X vs Y), practical guides

> ⚡ **Enrichment priority**: any page generating 100+ impressions on 10+ word queries is a GEO quick win — add structured steps, a comparison table, or a FAQ block to increase citation probability.

**GEO Score: /100 → normalized to /20 in recap**

---

## Step 6: UX & Conversion Audit *(both modes)*

> Traffic without conversion produces no business results. This audit detects friction that drives visitors away.

### 6.1 User Experience

| Criterion | Check | Points |
|---|---|---|
| Navigation | Clear menu, max 7 primary items | /2 |
| Internal search | Present and functional (if site > 20 pages) | /1 |
| Visual hierarchy | CTAs visible above the fold | /2 |
| Mobile-first design | Touch-optimized interface, buttons ≥ 44px | /2 |
| Readability | Sufficient contrast, font ≥ 16px on mobile | /1 |
| Perceived speed | Progressive loading, no blank screen | /1 |
| Basic accessibility | Form labels, alt text, visible focus | /1 |

**UX subtotal: /10**

### 6.2 Trust Signals & Conversion

| Criterion | Check | Points |
|---|---|---|
| Visible trust signals | Certifications, guarantees, payment security, GDPR/CCPA | /2 |
| Testimonials / Reviews | Visible on key pages (home, service, product) | /2 |
| Primary CTA | Clear, compelling, above-the-fold on all key pages | /2 |
| Contact form | Simple, max 5 fields for first contact | /1 |
| Phone number | Visible at top of page, clickable on mobile | /1 |
| SERP → Landing coherence | Search intent satisfied upon arrival | /2 |

**Conversion subtotal: /10**

### 6.3 Analytics & Tracking Implementation

> Check manually via `web_fetch` (look for GA4/GTM tags in HTML) or via GA4 MCP if connected (Section GA-A).

| Criterion | Check | Points |
|---|---|---|
| GA4 / analytics tag present | `gtag.js` or GTM snippet in page source | /2 |
| No duplicate tracking | Single analytics instance per page | /1 |
| Conversion events configured | ≥ 1 goal / conversion event active | /2 |
| Internal traffic filtered | Dev/agency IPs excluded | /1 |
| GSC property verified | Site verified in Search Console | /2 |
| GSC sitemap submitted | Sitemap present and submitted | /2 |

**Analytics subtotal: /10**

### 6.4 Social Signals & Open Graph

> Social traffic = indirect SEO signal (brand awareness → branded searches → authority). Check via `web_fetch` for OG tags + `web_search` for social presence.

| Criterion | Check | Points |
|---|---|---|
| Open Graph tags | `og:title`, `og:description`, `og:image` (1200×630px) present | /2 |
| Twitter / X Card | `twitter:card` meta tag present | /1 |
| OG image quality | Image present, correct dimensions, not generic | /2 |
| Active social profiles | ≥ 2 active profiles with recent posts (< 30 days) | /2 |
| Social share buttons | Present on blog/article pages | /1 |
| Social referral traffic | Measurable social traffic (GA4 MCP if available) | /2 |

**Social subtotal: /10**

**UX & Conversion Score: /40 → normalized to /10 in recap**

---

## Step 7: Competitive Analysis

For each competitor (auto-identify if not provided via `web_search: "[trade] [city/sector] competitor"`), run Steps 1–6 in condensed form.

### Comparison Table — Local Mode 🏘️

| Criterion | My Site | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| **Technical SEO /10** | | | | |
| **Core Web Vitals /10** | | | | |
| **Local SEO /20** | | | | |
| **E-E-A-T /10** | | | | |
| **Entity SEO /10** | | | | |
| **GEO /20** | | | | |
| **UX & Conversion /10** | | | | |
| **GLOBAL SCORE /90** | | | | |
| GBP complete | ✅/❌ | | | |
| Average review rating | | | | |
| Number of reviews | | | | |
| In Local Pack | ✅/❌ | | | |
| Knowledge Panel | ✅/❌ | | | |
| LocalBusiness schema | ✅/❌ | | | |
| FAQ present | ✅/❌ | | | |
| Cited by AIs | ✅/❌ | | | |
| Mobile speed (LCP) | | | | |
| Publishing frequency | | | | |

### Comparison Table — General Mode 🌐

| Criterion | My Site | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| **Technical SEO /10** | | | | |
| **Core Web Vitals /10** | | | | |
| **Content & Authority /20** | | | | |
| **E-E-A-T /10** | | | | |
| **Entity SEO /10** | | | | |
| **GEO /20** | | | | |
| **UX & Conversion /10** | | | | |
| **GLOBAL SCORE /90** | | | | |
| Referring domains (est.) | | | | |
| Indexed pages (`site:`) | | | | |
| Featured Snippets captured | | | | |
| Knowledge Panel | ✅/❌ | | | |
| Structured schema | ✅/❌ | | | |
| FAQ / AI-friendly content | ✅/❌ | | | |
| Keyword gap identified | | | | |
| Mobile speed (LCP) | | | | |
| Publishing frequency | | | | |
| Cited by AIs | ✅/❌ | | | |

### Qualitative Competitive Analysis

For each competitor, identify:
1. **What they do better** (max 3 points)
2. **Exploitable weaknesses** (max 3 points)
3. **Identified content strategy** (dominant content type)
4. **Estimated share of voice** (% of strategic keywords in top 10)

---

## Step 8: Expert Final Report

Generate a structured report. The title and intro clearly state the mode (🏘️ Local or 🌐 General) and the language (English by default, or French if requested).

### Report Structure

```
════════════════════════════════════════════
EXPERT SEO + GEO AUDIT — [SITE NAME]
Mode: [Local 🏘️ / General 🌐] | Date: [MM/DD/YYYY]
════════════════════════════════════════════

1. EXECUTIVE SUMMARY
   ──────────────────
   → Global score: [X]/90
   → Ranking vs competitors: [1st / 2nd / 3rd / 4th]
   → Priority level: [URGENT / MODERATE / GOOD — optimization]
   → 3 main strengths
   → 3 critical weaknesses
   → Estimated additional traffic potential (if actions taken)

2. SCORE DASHBOARD
   ─────────────────
   | Dimension | Score | /max | Level |
   |---|---|---|---|
   | Technical SEO | | /10 | 🔴/🟡/🟢 |
   | Core Web Vitals | | /10 | 🔴/🟡/🟢 |
   | Local SEO OR Content & Authority | | /20 | 🔴/🟡/🟢 |
   | E-E-A-T | | /10 | 🔴/🟡/🟢 |
   | Entity SEO | | /10 | 🔴/🟡/🟢 |
   | GEO | | /20 | 🔴/🟡/🟢 |
   | UX & Conversion | | /10 | 🔴/🟡/🟢 |
   | TOTAL | | /90 | |
   Legend: 🔴 < 50% | 🟡 50–75% | 🟢 > 75%

3. DETAILED RESULTS BY DIMENSION
   Score + justification + strengths + weaknesses + sources per dimension.

4. COMPETITIVE ANALYSIS
   Full comparison table + market positioning + keyword gap (top 10 targets).

5. PRIORITIZED ACTION PLAN WITH ROI
   🟢 QUICK WINS (< 1 week): action / effort / impact / ROI / resources
   🟡 MEDIUM TERM (1–3 months): same format
   🔴 LONG TERM (3–6 months): same format

6. TRACKING METRICS
   KPIs: GSC impressions/clicks (weekly), avg positions, organic traffic (GA4 monthly),
   [Local] GBP rating + calls, [General] referring domains, AI citations (monthly test).
   Alerts: Google Alerts on brand + competitors, GSC coverage alerts.

7. GLOSSARY
   Define all technical terms used in the report.

8. CONCLUSION & NEXT STEPS
   3-sentence synthesis + re-audit in 3 months + monthly KPI monitoring proposal.
```

### Delivery format

- **Default**: full Markdown report in the conversation
- **On request**: professional `.docx` via the `docx` skill
- **Always offer** an export at the end
- **Always offer** follow-up: *"Would you like me to track these indicators in 3 months?"*

---

## Best Practices & Notes

### Data reliability
- Always **cite sources** (URL + retrieval date)
- If data is inaccessible, state clearly with 🔍 *"Estimate based on [method]"*
- Scores are **estimates based on observable signals**, not official Google data
- Without GSC/GA4, flag uncertainty in the report

### Sector adaptation

| Sector | Specific priorities |
|---|---|
| Restaurant / Hotel | GBP +++, reviews, photos, structured menu |
| Health / Medical | E-E-A-T +++, YMYL, disclaimers |
| Finance / Legal | E-E-A-T +++, YMYL, expert authors |
| E-commerce | Product schema, Core Web Vitals, faceted navigation |
| SaaS / B2B | Topical Authority, industry backlinks, case studies |
| Contractor / SMB | GBP, NAP consistency, local citations |

### Edge case handling
- **Site unreachable**: note it, retry after 5 min, continue with available data
- **Unknown competitor**: identify via `web_search: "[trade] [city/sector]"` top 3 organic
- **Multilingual site**: audit the main language, note hreflang issues separately
- **Site under construction**: state clearly and audit what is accessible

### Ethics & transparency
- Never invent metrics or positions
- Always indicate the margin of uncertainty for estimates
- Remind that recommendations are best practices, not guarantees of results

---

## Reference: Content Recommendation Writing

When the audit leads to **editorial recommendations**, read [`ai-writing-detection.md`](./ai-writing-detection.md) to:

- Avoid typical AI writing markers in examples provided to the client (em dashes, "leverage", "robust", "in today's digital age"...)
- Ensure optimized content examples sound natural and human
- Flag these same patterns as **unrefined AI content signals** during the content audit — a negative E-E-A-T factor

> Load this file only when the audit includes an editorial component, not systematically.
