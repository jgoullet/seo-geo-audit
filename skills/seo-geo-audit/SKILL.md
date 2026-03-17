---
name: seo-geo-audit
description: >
  Performs an expert SEO audit (Local or General) + full GEO analysis: Technical SEO, Core Web Vitals, E-E-A-T, Entity SEO,
  GEO (AI visibility), UX-Conversion, and competitive analysis with scores /90 and a prioritized action plan.
  Use this skill for: SEO audit, local/national SEO, Google Business Profile, keyword gap, backlinks,
  link building, domain authority, cannibalization, featured snippets, Knowledge Panel, Wikidata, AI optimization
  (ChatGPT, Perplexity, AI Overviews), technical audit, content audit, organic CTR, Core Web Vitals, E-E-A-T.
  Also triggers for: "why does my competitor outrank me", "improve my SEO", "audit my site",
  "compare my site to X", "local SEO", "e-commerce SEO", "SaaS SEO", "visibility audit",
  "my site doesn't rank well", "my site doesn't appear on Google", "optimize for AI search engines",
  "audite mon site", "améliorer mon référencement", "SEO local".
---

# Skill: Expert SEO Audit (Local or General) + GEO & Competitive Analysis

All responses, analyses and reports are produced **in English by default**. Switch to the user's language if they explicitly request it (e.g., French, German, Spanish).

---

## Overview

This skill offers **two audit modes** depending on the nature of the business:

| Mode | For whom? | Blocks activated |
|---|---|---|
| 🏘️ **Local** | Local business, artisan, restaurant, doctor, local agency, freelancer... | Technical SEO + Core Web Vitals + Local SEO + E-E-A-T + Entity SEO + GEO + UX-Conversion + Competitors |
| 🌐 **General** | E-commerce, SaaS, blog, media, national/international brand, B2B, B2C... | Technical SEO + Core Web Vitals + Content & Authority + E-E-A-T + Entity SEO + GEO + UX-Conversion + Competitors |

Produces a **final expert report** with scores, scoring grids, comparison table and prioritized action plan with estimated ROI.

---

## Step 0: Information gathering

### Pipeline integration (if running as part of the SEO system)

Check for these files in the project folder `seo-project-[domain]/`:

1. **`site-data.json`** (from `seo-collector`) — If present, load it and use the technical data directly. Skip manual questions 1, 11-13 (URL, GSC, GA4, CMS are already known). Still ask questions 2-10 if not answered in the file.

2. **`client-profile.md`** (from `seo-shared-context`) — If present, load it for mode, competitors, objectives, and audience context. Skip any question already answered there.

3. **Neither file exists** — Run as standalone: ask all questions below.

### Ahrefs MCP data (if available in site-data.json)

When `site-data.json` contains Ahrefs data (`mcp_integrations.ahrefs: true`), use real metrics throughout the audit:

| Audit section | Without Ahrefs | With Ahrefs MCP |
|---|---|---|
| **Step 2B.2 Authority & Link Building** | Estimate referring domains via web search | Real DR, backlink count, referring domains, anchor profile |
| **Step 2B.3 Organic Rankings** | Manual keyword search (5-10 queries) | Real keyword positions + volumes for 50+ keywords |
| **Step 3.2 Authority & Trust** | Estimate press mentions | Real brand mention data |
| **Step 5.5 Platform Optimization** | Estimate domain authority metrics | Real Ahrefs DR + rank |
| **Step 5.6 AI Visibility Test** | Manual searches on each AI platform | Brand Radar: real citation data across AI agents |
| **Step 7 Competitive Analysis** | Identify competitors via web_search | Pre-identified organic competitors with common keyword counts |

When Ahrefs data is present, always note `Source: Ahrefs MCP (real data)` in the report. When estimated, note `Source: web search (estimate)`.

### Manual information gathering (standalone mode)

Ask the user:

```
ESSENTIAL INFORMATION
─────────────────────
1. URL of the site to audit
2. Mode: Local 🏘️ or General 🌐?
   (If not specified → analyze and suggest the appropriate mode)

3. [If Local] City / target geographic area
4. [If Local] Industry (restaurant, plumber, doctor...)
5. [If General] Main topic and target audience (B2B / B2C)
6. [If General] Site type (e-commerce, blog, SaaS, institutional...)
7. [If General] International presence / multilingual?

COMPETITORS & OBJECTIVES
────────────────────────
8. Competitor URLs to compare (1 to 3, otherwise identify automatically)
9. Primary objective (traffic, leads, sales, brand awareness...)
10. Time horizon (short-term urgency / medium-long term strategy)

ACCESS & TECHNICAL CONTEXT
───────────────────────────
11. Google Search Console available? (key data sharing possible)
12. Google Analytics / GA4 available?
13. CMS used? (WordPress, Shopify, Webflow, Wix, custom...)
14. Known Google penalty history? (manual or algorithmic)
15. Available budget/resources (solo, internal team, agency)
```

> **Note**: If Analytics/GSC data is not shared, all metrics will be **estimates based on observable signals**. Clearly state this in the report.

---

## Step 1: Technical SEO Audit

Use `web_search` and `web_fetch` to analyze:

### 1.1 On-Page & Structure

| Criterion | Verification | Points |
|---|---|---|
| `<title>` tag | Primary keyword present, 50-60 characters, unique | /2 |
| Meta description | Compelling, 140-160 characters, with call to action | /2 |
| H1 | Unique, relevant, contains primary keyword | /1 |
| H2/H3 | Logical hierarchy, semantic coverage | /1 |
| URLs | Clean, readable, < 100 characters, no unnecessary parameters | /1 |
| Image ALT tags | Descriptive and present on all key images | /1 |
| Internal linking | Coherent, max depth 3 clicks from homepage | /2 |

**On-Page subtotal: /10**

### 1.2 Technical & Crawlability

| Criterion | Verification | Points |
|---|---|---|
| HTTPS | Active, valid certificate, no mixed content | /1 |
| Mobile responsive | Adaptive design, no hidden content on mobile | /1 |
| XML Sitemap | Present (`/sitemap.xml`), submitted to GSC, up to date | /1 |
| Robots.txt | Not blocking important pages (`/robots.txt`) | /1 |
| 404 errors | None on main pages, clean 301 redirects | /1 |
| Redirects | No redirect chains (max 1 hop), no loops | /1 |
| Canonicals | `rel="canonical"` tags correctly implemented | /1 |
| Duplication | No internal duplicate content | /1 |
| Pagination | Correctly managed (canonical or GSC signal) | /1 |
| Hreflang | Present and correct if multilingual site | /1 |

**Technical subtotal: /10**

> ⚠️ **CRITICAL LIMITATION — Schema Markup detection via `web_fetch`**
>
> `web_fetch` and `curl` **cannot detect JSON-LD structured data** injected via JavaScript. Many CMS platforms (WordPress + Yoast, RankMath, AIOSEO; Shopify; Webflow) inject schema client-side — it is **invisible in static HTML**.
>
> ❌ Concluding "no schema detected" based on `web_fetch` alone = **false audit conclusion**.
>
> ✅ **Reliable methods to audit schema:**
> 1. **Google Rich Results Test** → https://search.google.com/test/rich-results *(renders JavaScript)*
> 2. **Schema.org Validator** → https://validator.schema.org *(renders JavaScript)*
> 3. **Screaming Frog** *(if provided by client — renders JavaScript)*
>
> Always mention in the report which method was used for schema detection, and flag uncertainty if only `web_fetch` was available.

### 1.3 Core Web Vitals *(critical block — direct ranking impact)*

Search for PageSpeed Insights data (`web_search: "PageSpeed Insights [URL]"`):

| Metric | Good | Needs improvement | Poor | Points |
|---|---|---|---|---|
| **LCP** (Largest Contentful Paint) — *loading speed: time for the biggest visible element to appear* | < 2.5s | 2.5–4s | > 4s | /2 |
| **CLS** (Cumulative Layout Shift) — *visual stability: do elements jump around during loading?* | < 0.1 | 0.1–0.25 | > 0.25 | /2 |
| **INP** (Interaction to Next Paint) — *responsiveness: delay between user action and visual feedback* | < 200ms | 200–500ms | > 500ms | /2 |
| **FCP** (First Contentful Paint) — *time until first content appears* | < 1.8s | 1.8–3s | > 3s | /1 |
| **TTFB** (Time to First Byte) — *server response time* | < 800ms | 800ms–1.8s | > 1.8s | /1 |
| Mobile vs Desktop | Consistent scores | Moderate gap | Gap > 20pts | /2 |

> **Scoring grid**: Good = full points, Needs improvement = half points, Poor = 0 points

**Core Web Vitals subtotal: /10**

**Overall Technical SEO Score: /30**

---

## Step 2A: Local SEO Audit 🏘️ *(Local mode only)*

### 2A.1 Google Business Profile (GBP)

Search `"[business name] [city]"` on Google and analyze the listing:

| Criterion | Verification | Points |
|---|---|---|
| Claimed listing | Ownership verified by business | /2 |
| Primary category | Precise and matching the business | /2 |
| Secondary categories | 2-5 relevant categories filled in | /1 |
| Photos | Recent (< 6 months), varied (interior, team, products) | /2 |
| Reviews — quantity | > 20 reviews (local pack) / > 50 (very good) | /2 |
| Reviews — rating | ≥ 4.5/5 (excellent) / 4.0–4.4 (good) / < 4.0 (needs work) | /2 |
| Review responses | 100% of negative reviews responded to, positives ideally too | /2 |
| GBP Posts | Published at least 1×/week | /1 |
| Attributes | Hours, accessibility, payment methods, services filled in | /2 |
| Q&A | Questions/answers present | /1 |
| Products/Services | Section complete with descriptions and prices if applicable | /1 |
| Phone number | Correct and clickable | /1 |

**GBP subtotal: /19 → normalized to /20**

### 2A.2 Citations & NAP Consistency

| Criterion | Verification | Points |
|---|---|---|
| NAP consistency | Name, Address, Phone **identical** across all platforms | /4 |
| Local directories | Presence on top 3 directories for the industry (Yelp, TripAdvisor, Healthgrades...) | /3 |
| Industry directories | Listed on key industry-specific platforms | /2 |
| Social media | Facebook/Instagram active with consistent address | /2 |
| Website | Address in footer, complete Contact page | /2 |
| Schema LocalBusiness | Implemented with all key properties | /3 |
| Review structured data | Schema `AggregateRating` present | /2 |
| Breadcrumb | Schema `BreadcrumbList` if multi-page site | /1 |
| Open Graph | Correct OG tags for social sharing | /1 |

**Citations & NAP subtotal: /20**

### 2A.3 Local Keywords & Rankings

Search: `"[business type] [city]"`, `"[business type] near me"`, `"best [business type] [city]"`:

| Criterion | Verification | Points |
|---|---|---|
| Local Pack (3 Maps listings) | Presence in the top 3 listings | /4 |
| Organic position P1-3 | On primary keyword `[business type] [city]` | /4 |
| Organic position P4-10 | Presence on first page | /2 |
| Local long tail | Presence on variants and neighborhoods | /2 |
| Google Suggest | Brand appears in autocomplete suggestions | /2 |
| Local Featured Snippet | Position 0 captured | /2 |
| Reviews in SERPs | Star rich snippets visible | /2 |
| FAQ in SERPs | FAQ schema triggers a rich result | /2 |

**Local Keywords subtotal: /20**

**Local SEO Score: /60 → scaled to /20 in summary**

---

## Step 2B: Content & Authority SEO Audit 🌐 *(General mode only)*

### 2B.1 Content Strategy

| Criterion | Verification | Points |
|---|---|---|
| Topical Authority | Complete and coherent topic coverage | /3 |
| Pillar pages | Long articles (2000+ words), well-structured, comprehensive | /2 |
| Long tail | Questions, comparisons, guides, "how to..." content | /2 |
| Freshness | Recent update dates, regularly refreshed content | /2 |
| Cannibalization | No internal competition on the same keywords | /2 |
| Readability | Score adapted to audience, short paragraphs, lists | /2 |
| Semantic field | Relevant named entities and co-occurrences present | /2 |
| Multimedia content | Images, videos, infographics, podcasts integrated | /2 |
| No thin content | No pages < 300 words without added value | /3 |

**Content subtotal: /20**

### 2B.2 Authority & Link Building

| Criterion | Verification | Points |
|---|---|---|
| Referring domains | Estimated count (web search) | /3 |
| Source quality | Press, recognized partners, universities, government | /4 |
| Anchor diversity | Natural profile (brand, generic, exact match balanced) | /2 |
| Recent inbound links | Regular acquisition (activity signal) | /2 |
| Toxic links | No apparent spam links | /2 |
| Wikipedia/Wikidata presence | Mentions or dedicated page | /2 |
| Press mentions (unlinked) | Brand mentions without link (authority signal) | /3 |
| Outbound links | To recognized and relevant sources | /2 |

**Link Building subtotal: /20**

### 2B.3 Organic Rankings & Keyword Gap

Search for the 5-10 primary keywords in the industry:

| Criterion | Verification | Points |
|---|---|---|
| Top 3 positions | On ≥ 2 strategic keywords | /4 |
| Top 10 positions | On ≥ 5 industry keywords | /3 |
| Featured Snippets | ≥ 1 position 0 captured | /3 |
| Keyword gap | Competitor keywords not covered identified | /3 |
| Organic CTR | Attractive and differentiating Title/Meta | /3 |
| Seasonality | Content adapted to search peaks | /2 |
| Branded queries | Site dominates on its own name | /2 |

**Rankings subtotal: /20**

**Content & Authority SEO Score: /60 → scaled to /20 in summary**

---

## Step 3: E-E-A-T Audit *(common to both modes)*

> **E-E-A-T** = Experience, Expertise, Authoritativeness, Trustworthiness — fundamental criterion from Google's Quality Rater Guidelines, particularly critical for YMYL sites (health, finance, legal...).

### 3.1 Experience & Expertise

| Criterion | Verification | Points |
|---|---|---|
| Author pages | Complete bio with photo, credentials, professional network links | /3 |
| Proof of experience | Case studies, client testimonials, portfolio, before/after | /3 |
| Expert content | Source citations, data-backed claims, referenced studies | /2 |
| Content creation date | Site age and domain expertise longevity | /2 |

**Experience & Expertise subtotal: /10**

### 3.2 Authority & Trust

| Criterion | Verification | Points |
|---|---|---|
| "About" page | History, team, values, certifications | /2 |
| Press mentions | Appearances in recognized media (verify via search) | /2 |
| Certifications & labels | Badges, quality labels, professional memberships | /2 |
| Privacy policy | Present, up to date, GDPR/CCPA compliant | /1 |
| Legal notice | Complete and accessible | /1 |
| Terms of service | Present if commercial site | /1 |
| HTTPS | Basic trust signal (already counted in Technical) | /0 |
| Third-party verified reviews | Trustpilot, Google Reviews, verified platforms | /3 |
| Complete contact info | Physical address, phone, visible email | /2 |
| YMYL signals | For sensitive sectors: disclaimers, "consult a professional" mentions | /3 |
| Active social media | Presence and communication consistency | /3 |

**Authority & Trust subtotal: /20**

**E-E-A-T Score: /30 → scaled to /10 in summary**

---

## Step 4: Entity SEO *(common to both modes)*

> **Entity SEO** measures how well the entity (brand, business, person) is recognized by Google and LLMs, independent of keywords. It is the foundation of GEO.

### 4.1 Entity existence in the Knowledge Graph

| Criterion | Verification | Points |
|---|---|---|
| Google Knowledge Panel | Side panel present on brand search | /4 |
| Wikidata | Q identifier present, consistent data | /3 |
| Wikipedia | Dedicated page or mention in relevant articles | /3 |
| Google Maps (if local) | Entity correctly linked to Maps listing | /2 |

**Knowledge Graph subtotal: /12 → normalized to /10**

### 4.2 Entity Consistency

| Criterion | Verification | Points |
|---|---|---|
| Entity name | Identical across all channels (site, social, GBP, Wikidata...) | /3 |
| Schema `Organization` / `LocalBusiness` | Present with `sameAs` pointing to all official profiles | /3 |
| Canonical entity URLs | LinkedIn, Twitter/X, Facebook, YouTube profiles consistent | /2 |
| Geographic anchoring | Consistent address everywhere (if local) | /2 |

**Entity Consistency subtotal: /10**

**Entity SEO Score: /20 → scaled to /10 in summary**

---

## Step 5: GEO Audit *(common to both modes)*

> **GEO** (Generative Engine Optimization) measures a site's ability to be **cited, summarized or recommended by generative AI**: Google AI Overviews, ChatGPT Search, Perplexity, Gemini, Copilot, Claude...
>
> **Core principle:** AI engines don't "rank" pages — they **cite sources**. Being cited = the new "being #1". *(Source: Princeton/KDD 2024, arXiv:2311.09735)*

---

### 5.1 AI Bot Accessibility *(critical prerequisite)*

> A site blocking AI crawlers in its `robots.txt` is **invisible to all AI engines**. Verify via `web_fetch: "[URL]/robots.txt"`.

| AI Bot | User-agent to allow | Platform | Points |
|---|---|---|---|
| Googlebot | `Googlebot` | Google AI Overview | /2 |
| GPTBot | `GPTBot` | ChatGPT (OpenAI) | /2 |
| ChatGPT-User | `ChatGPT-User` | ChatGPT with browsing | /1 |
| PerplexityBot | `PerplexityBot` | Perplexity AI | /2 |
| ClaudeBot | `ClaudeBot` | Claude (Anthropic) | /1 |
| anthropic-ai | `anthropic-ai` | Claude (Anthropic) | /1 |
| Bingbot | `Bingbot` | Copilot / Bing | /1 |

> ⚠️ **Important note**: Claude uses **Brave Search** (not Google or Bing). To be cited by Claude, a site must be indexed by Brave Search AND allow ClaudeBot/anthropic-ai.

**Bot Accessibility subtotal: /10**

---

### 5.2 Content Optimization — The 9 GEO Methods (Princeton/KDD 2024)

> These methods are from peer-reviewed academic research validated on Perplexity.ai (10,000+ queries tested). Percentages indicate the **average visibility boost** in AI responses.

| Method | Boost | How to evaluate | Points |
|---|---|---|---|
| **1. Cite sources** | +40% | Content cites studies, reports, recognized institutions | /3 |
| **2. Add statistics** | +37% | Verifiable data with dated sources | /3 |
| **3. Add expert quotes** | +30% | Quotes attributed to named experts | /2 |
| **4. Authoritative tone** | +25% | Affirmative, expert language, no vague formulations | /2 |
| **5. Accessible content** | +20% | Complex concepts explained simply | /2 |
| **6. Technical terminology** | +18% | Relevant industry jargon used correctly | /2 |
| **7. Varied vocabulary** | +15% | No repetitions, synonyms, lexical richness | /1 |
| **8. Optimized fluency** | +15-30% | Well-written text, logical transitions, short paragraphs | /2 |
| **9. ❌ Keyword stuffing** | **-10%** | Absence of keyword over-optimization | /3 |

> 🏆 **Best combination**: Fluency + Statistics = maximum boost per the Princeton study.

**GEO Methods subtotal: /20**

---

### 5.3 Content Structure for LLMs

| Criterion | Verification | Points |
|---|---|---|
| "Answer-first" format | Direct answer in the first paragraph | /3 |
| Paragraph length | < 3-4 sentences per block | /2 |
| Structured FAQs | Questions/answers in explicit Q&A format | /3 |
| Clear definitions | Services/products defined at the beginning of sections | /2 |
| Lists and tables | Visually structured data | /2 |
| Interrogative headings | H2/H3 phrased as questions ("How...", "Why...") | /2 |
| Unique content | Real added value, not paraphrased from others | /3 |
| Public PDFs | Accessible PDF documents (favored by Perplexity) | /1 |
| Freshness | Content updated within the last 30 days (×3.2 ChatGPT citations) | /2 |

**LLM Structure subtotal: /20**

---

### 5.4 Structured Data for AI

| Criterion | Verification | Points |
|---|---|---|
| Schema `FAQPage` (JSON-LD) | Present on pages with FAQ — **+40% AI visibility** | /3 |
| Schema `LocalBusiness` | [Local mode] Complete with all key properties | /3 |
| Schema `Article` + `dateModified` | [General mode] On all articles, with update date | /2 |
| Schema `Product` / `Offer` | [E-commerce] On product pages | /2 |
| Schema `Organization` + `sameAs` | Links to all official profiles | /2 |
| Schema `BreadcrumbList` | Structured breadcrumb trail | /1 |
| Schema `Review` / `AggregateRating` | Structured customer reviews | /2 |
| Schema `HowTo` | [If relevant] Step-by-step guides | /2 |
| Open Graph & Twitter Card | Correct social metadata | /1 |
| JSON-LD format | Google-recommended format (vs Microdata) | /2 |

**Structured Data subtotal: /20**

---

### 5.5 Platform-Specific Optimization

Evaluate signals specific to each generative engine:

#### 🤖 ChatGPT (OpenAI)
*Index: Bing-based + web browsing. #1 factor: Domain Authority*

| Signal | Target value | Present? |
|---|---|---|
| Referring domains | > 350K = 8.4 average citations | ✅/❌/🟡 |
| Content freshness | < 30 days = ×3.2 citations | ✅/❌/🟡 |
| Branded domain | +11.1 pts vs third-party domains | ✅/❌ |
| "Content-Answer Fit" | Content matches ChatGPT response style | ✅/❌ |
| Wikipedia/Reddit presence | Preferred sources (7.8% + 1.8% of citations) | ✅/❌ |

#### 🔍 Perplexity AI
*3-layer RAG architecture. #1 factor: Semantic relevance*

| Signal | Target value | Present? |
|---|---|---|
| PerplexityBot allowed | `robots.txt` not blocking | ✅/❌ |
| Schema FAQPage | FAQ pages cited more often | ✅/❌ |
| Public PDFs | Prioritized for citation | ✅/❌ |
| Topical authority | Complete subject coverage | ✅/❌ |
| Publication speed | New content evaluated quickly | ✅/❌ |

#### 🌐 Google AI Overview (SGE)
*5-step pipeline. #1 factor: E-E-A-T + Knowledge Graph*

| Signal | Target value | Present? |
|---|---|---|
| Strong E-E-A-T | Expertise + Authority + Trust | ✅/❌ |
| Knowledge Graph | Entity in Google's knowledge graph | ✅/❌ |
| Authoritative citations | +132% visibility with trusted references | ✅/❌ |
| Authoritative tone | +89% visibility | ✅/❌ |
| Topic clusters | Coherent internal linking by subject | ✅/❌ |

#### 🖥️ Microsoft Copilot / Bing
*Bing index. #1 factor: Bing indexation*

| Signal | Target value | Present? |
|---|---|---|
| Indexed by Bing | Verify `bing.com/search?q=site:[domain]` | ✅/❌ |
| Bingbot allowed | `robots.txt` not blocking | ✅/❌ |
| LinkedIn/GitHub presence | Boost in Microsoft ecosystem | ✅/❌ |
| Page speed | < 2 seconds | ✅/❌ |

#### 🤖 Claude (Anthropic)
*Index: **Brave Search** (≠ Google/Bing). Crawl/citation ratio: 38,065:1 — very selective*

| Signal | Target value | Present? |
|---|---|---|
| Indexed by Brave Search | Verify `search.brave.com/search?q=site:[domain]` | ✅/❌ |
| ClaudeBot + anthropic-ai allowed | `robots.txt` not blocking | ✅/❌ |
| Factual density | Content rich in verifiable data | ✅/❌ |
| Structural clarity | Information easily extractable | ✅/❌ |

**Platform Optimization subtotal: /10** *(qualitative global assessment)*

---

### 5.6 AI Visibility Test

Perform the following searches and note if the site is cited:

**[Local mode]**
- `"best [business type] in [city]"` → Google AI Overview present? Site cited?
- `"[business type] [city] reviews"` → Perplexity / ChatGPT Search → Site mentioned?
- `"[business name]"` → ChatGPT + Brave Search → Information correct?

**[General mode]**
- Key informational queries in the industry → AI Overview → Site cited?
- `"best [product/service] for [use case]"` → Perplexity → Site recommended?
- Long-tail industry questions → ChatGPT → Site mentioned as source?

| Test result | Points |
|---|---|
| Cited in Google AI Overview | /4 |
| Cited in Perplexity | /3 |
| Cited in ChatGPT Search | /3 |
| Indexed and cited via Brave/Claude | /2 |
| Entity information correct in AI engines | /3 |
| No AI bot blocked | /5 |

**AI Visibility Test subtotal: /20**

**GEO Score: /100 → scaled to /20 in summary**

---

## Step 6: UX & Conversion Audit *(common to both modes)*

> Traffic without conversion doesn't produce business results. This audit detects friction points that drive visitors away.

### 6.1 User Experience

| Criterion | Verification | Points |
|---|---|---|
| Navigation | Clear menu, max 7 items at first level | /2 |
| Internal search | Present and functional (if site > 20 pages) | /1 |
| Visual hierarchy | CTAs visible above the fold | /2 |
| Mobile-first design | Touch-optimized interface, buttons ≥ 44px | /2 |
| Readability | Sufficient contrast, font ≥ 16px on mobile | /1 |
| Perceived speed | Progressive loading, no white screen | /1 |
| Accessibility (basic) | Form labels, alt text, visible focus | /1 |

**UX subtotal: /10**

### 6.2 Trust Signals & Conversion

| Criterion | Verification | Points |
|---|---|---|
| Visible trust signals | Certifications, guarantees, payment security, GDPR/CCPA | /2 |
| Testimonials/Reviews | Visible on key pages (home, service, product) | /2 |
| Primary CTA | Clear, compelling, above-the-fold on all key pages | /2 |
| Contact form | Simple, max 5 fields for first contact | /1 |
| Phone number | Visible at top of page, clickable on mobile | /1 |
| SERP → Landing coherence | Search intent satisfied upon arrival | /2 |

**Conversion subtotal: /10**

### 6.3 Analytics & Tracking Maturity

> If `site-data.json` contains `analytics_tracking` data (from the collector's Step 5.5), use it directly. Otherwise, check the HTML source manually.

| Criterion | Verification | Points |
|---|---|---|
| GA4 or equivalent installed | Modern analytics tool detected and active | /2 |
| Tag Manager (GTM) | Container present — enables flexible event tracking | /1 |
| Conversion events configured | E-commerce events (add_to_cart, purchase) or form/CTA tracking detected | /3 |
| Consent management (CMP) | Cookie banner / GDPR-CCPA compliant consent tool present | /1 |
| Heatmap / Session recording | Hotjar, Clarity, or equivalent installed (UX insight capability) | /1 |
| No legacy analytics | Universal Analytics (UA) migrated to GA4 | /1 |
| dataLayer structured | GTM dataLayer initialized with meaningful data | /1 |

**Analytics & Tracking subtotal: /10**

**Maturity assessment** (from collector data or manual check):
- 🔴 **No analytics** (0-2 pts): No GA4, no tracking — flying blind
- 🟡 **Basic** (3-5 pts): GA4 present but minimal event tracking
- 🟢 **Intermediate** (6-8 pts): GA4 + GTM + conversion events + consent
- 🟢🟢 **Advanced** (9-10 pts): Full stack with CDP/product analytics + heatmaps

> **Why this matters for SEO**: Google's ranking signals increasingly rely on user engagement metrics (dwell time, scroll depth, click satisfaction). Without proper tracking, you can't measure whether your SEO improvements are actually driving conversions — and you can't prove ROI to stakeholders.

**UX & Conversion Score: /30 → scaled to /10 in summary**

---

## Step 7: Competitive Analysis

For each competitor (identify automatically if not provided via `web_search: "[business type] [city/industry] competitor site"`), reproduce steps 1 to 6 in a lighter version.

### Comparison Table — Local Mode 🏘️

| Criterion | My Site | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| **Technical SEO Score /10** | | | | |
| **Core Web Vitals /10** | | | | |
| **Local SEO Score /20** | | | | |
| **E-E-A-T Score /10** | | | | |
| **Entity SEO Score /10** | | | | |
| **GEO Score /20** | | | | |
| **UX & Conversion Score /10** | | | | |
| **OVERALL SCORE /90** | | | | |
| Complete GBP listing | ✅/❌ | | | |
| Average review rating | | | | |
| Number of reviews | | | | |
| In Local Pack | ✅/❌ | | | |
| Knowledge Panel | ✅/❌ | | | |
| Schema LocalBusiness | ✅/❌ | | | |
| FAQ present | ✅/❌ | | | |
| Cited by AI engines | ✅/❌ | | | |
| Mobile speed (LCP) | | | | |
| Analytics maturity | | | | |
| Publishing frequency | | | | |

| Criterion | My Site | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| **Technical SEO Score /10** | | | | |
| **Core Web Vitals /10** | | | | |
| **Content & Authority Score /20** | | | | |
| **E-E-A-T Score /10** | | | | |
| **Entity SEO Score /10** | | | | |
| **GEO Score /20** | | | | |
| **UX & Conversion Score /10** | | | | |
| **OVERALL SCORE /90** | | | | |
| Referring domains (estimated) | | | | |
| Indexed pages (`site:`) | | | | |
| Featured Snippets captured | | | | |
| Knowledge Panel | ✅/❌ | | | |
| Structured schema | ✅/❌ | | | |
| FAQ / AI-friendly content | ✅/❌ | | | |
| Keyword gap identified | | | | |
| Mobile speed (LCP) | | | | |
| Analytics maturity | | | | |
| Publishing frequency | | | | |

### Qualitative Competitive Analysis

For each competitor, identify:
1. **What they do better** (3 points max)
2. **Their exploitable weaknesses** (3 points max)
3. **Identified content strategy** (dominant content type)
4. **Estimated share of voice** (% of strategic keywords in top 10)

---

## Step 8: Final Expert Report

Generate a structured report. The title and introduction clearly indicate the mode used (🏘️ Local or 🌐 General).

### Report structure

```
════════════════════════════════════════════
SEO + GEO EXPERT AUDIT — [SITE NAME]
Mode: [Local 🏘️ / General 🌐] | Date: [MM/DD/YYYY]
════════════════════════════════════════════

1. EXECUTIVE SUMMARY
   ────────────────
   → Overall score: [X]/90
   → Ranking vs competitors: [1st / 2nd / 3rd / 4th]
   → Priority level: [URGENT / MODERATE / GOOD — optimization only]
   → Top 3 strengths
   → Top 3 critical weaknesses
   → Estimated additional traffic potential (if actions are taken)

2. SCORE DASHBOARD
   ────────────────
   | Dimension | Score | /max | Level |
   |---|---|---|---|
   | Technical SEO | | /10 | 🔴/🟡/🟢 |
   | Core Web Vitals | | /10 | 🔴/🟡/🟢 |
   | Local SEO OR Content & Authority | | /20 | 🔴/🟡/🟢 |
   | E-E-A-T | | /10 | 🔴/🟡/🟢 |
   | Entity SEO | | /10 | 🔴/🟡/🟢 |
   | GEO | | /20 | 🔴/🟡/🟢 |
   | UX & Conversion | | /10 | 🔴/🟡/🟢 |
   | **TOTAL** | | **/90** | |
   
   Legend: 🔴 < 50% | 🟡 50-75% | 🟢 > 75%

3. DETAILED RESULTS BY DIMENSION
   For each dimension:
   - Score obtained + justification
   - Strengths identified
   - Weaknesses identified
   - Source data cited

4. COMPETITIVE ANALYSIS
   - Complete comparison table (adapted to mode)
   - Site positioning in the market
   - What competitors do better → opportunities
   - Exploitable differentiators
   - Keyword gap: top 10 priority keywords to target

5. PRIORITIZED ACTION PLAN WITH ESTIMATED ROI
   
   🟢 QUICK WINS (< 1 week — fast impact)
   For each action:
   - Precise description
   - Estimated effort (hours)
   - Potential impact (traffic / leads / positions)
   - Estimated ROI (e.g., "+15-25% clicks in 2-4 weeks")
   - Required resources (solo / developer / writer)
   
   🟡 MEDIUM TERM (1-3 months)
   [Same format]
   
   🔴 LONG TERM (3-6 months)
   [Same format]

6. TRACKING METRICS TO IMPLEMENT
   Recommended KPIs:
   - Impressions & clicks (GSC — weekly)
   - Average positions on 10 target keywords
   - Organic traffic (GA4 — monthly)
   - [Local] GBP rating and review count
   - [Local] Calls and directions from GBP
   - [General] Referring domains (monthly)
   - AI citations (monthly test)
   
   Alerts to configure:
   - Google Alerts on brand name
   - Google Alerts on main competitors
   - Search Console: coverage and performance alerts

7. GLOSSARY (for non-technical clients)
   Define the technical terms used in the report.

8. CONCLUSION & NEXT STEPS
   - 3-sentence synthesis
   - Re-audit recommendation in 3 months
   - Monthly KPI tracking proposal
```

### Delivery format

- **Default**: full report in Markdown in the conversation
- **On request**: generate a professional `.docx` via the `docx` skill
- **Always offer** an export at the end of the report
- **Always offer** follow-up: *"Would you like me to monitor these indicators in 3 months?"*

---

## Step 9: Pipeline output (for the Implementer skill)

> This step runs **automatically** after the report is generated. It produces a structured JSON file that the `seo-implementer` skill can consume directly to generate fix files.

Save the following file to `seo-project-[domain]/audit-actions.json`:

```json
{
  "metadata": {
    "audit_date": "[ISO 8601]",
    "domain": "[domain]",
    "mode": "local|general",
    "overall_score": 0,
    "overall_max": 90
  },
  "scores": {
    "technical_seo": { "score": 0, "max": 10 },
    "core_web_vitals": { "score": 0, "max": 10 },
    "local_or_content": { "score": 0, "max": 20, "type": "local|content_authority" },
    "eeat": { "score": 0, "max": 10 },
    "entity_seo": { "score": 0, "max": 10 },
    "geo": { "score": 0, "max": 20 },
    "ux_conversion": { "score": 0, "max": 10 }
  },
  "fixes_needed": {
    "meta_tags": [
      {
        "url": "https://example.com/page",
        "issue": "title_too_short|meta_missing|h1_missing|h1_duplicate",
        "current_value": "[current title/meta/h1 or null]",
        "suggested_value": "[recommended title/meta/h1]",
        "priority": "high|medium|low"
      }
    ],
    "schema_markup": [
      {
        "url": "https://example.com/",
        "missing_type": "Organization|LocalBusiness|FAQPage|Product|BreadcrumbList|Article",
        "properties_needed": ["name", "url", "sameAs", "..."],
        "priority": "high|medium|low"
      }
    ],
    "robots_txt": {
      "needs_update": true,
      "blocked_bots": ["PerplexityBot"],
      "recommended_additions": ["Allow: /\nUser-agent: PerplexityBot"],
      "priority": "high"
    },
    "redirects": [
      {
        "from": "/old-path",
        "to": "/new-path",
        "type": "301",
        "reason": "404_error|chain_redirect|duplicate"
      }
    ],
    "content": [
      {
        "url": "https://example.com/page",
        "issue": "thin_content|outdated|no_faq|no_answer_first",
        "recommendation": "[specific content recommendation]",
        "priority": "high|medium|low"
      }
    ],
    "technical": [
      {
        "issue": "missing_sitemap|missing_canonical|mixed_content|slow_lcp|hreflang_error",
        "details": "[specific details]",
        "fix": "[specific fix instruction]",
        "priority": "high|medium|low"
      }
    ]
  },
  "action_plan": {
    "quick_wins": [
      {
        "action": "[description]",
        "effort_hours": 0,
        "impact": "[traffic/leads/positions impact]",
        "roi_estimate": "[e.g. +15-25% clicks in 2-4 weeks]"
      }
    ],
    "medium_term": ["..."],
    "long_term": ["..."]
  }
}
```

Also save the human-readable report to `seo-project-[domain]/audit-report.md`.

> **Pattern 2 applied**: The audit produces two outputs — a human-readable report (Markdown) and a machine-readable action file (JSON). The Implementer reads the JSON to generate fix files automatically. The Monitor reads both to compare against future crawls.

---

## Best practices & important notes

### Data reliability
- Always **cite sources** of data found (URL + date of consultation)
- If data is inaccessible (private site, no API), clearly indicate with 🔍 *"Estimate based on [method]"*
- Scores are **estimates based on observable signals**, not official Google data
- Without GSC/GA4 access, specify the uncertainty in the report

### Industry adaptation
| Industry | Specific priorities |
|---|---|
| Restaurant / Hotel | GBP +++, reviews, photos, structured menu |
| Health / Medical | E-E-A-T +++, YMYL, disclaimers |
| Finance / Legal | E-E-A-T +++, YMYL, expert authors |
| E-commerce | Product schema, Core Web Vitals, faceted navigation |
| SaaS / B2B | Topical Authority, industry backlinks, case studies |
| Artisan / SMB | GBP, NAP, local citations |

### Edge case handling
- **Inaccessible site** (server error, maintenance): note, retry after 5 min, continue with available data
- **Unknown competitor**: identify via `web_search: "[business type] [city/industry]"` top 3 organic results
- **Multilingual site**: audit the primary language, note hreflang issues separately
- **Site under construction**: clearly indicate and audit what is accessible

### Ethics & transparency
- Never fabricate metrics or rankings
- Systematically indicate the margin of uncertainty for estimates
- Remind that recommendations are best practices, not guaranteed results

---

## Reference: Content writing recommendations

When the audit leads to **editorial recommendations** (page rewriting, text optimization, content creation), read the file [`ai-writing-detection.md`](./ai-writing-detection.md) to:

- Avoid typical AI writing markers in examples provided to the client (em dash, "leverage", "robust", "in today's digital age"...)
- Ensure that optimized content examples look natural and human
- Identify these same patterns as **unedited AI content signal** during client content audit — a negative E-E-A-T factor

> Read this file only when the audit includes an editorial component, not systematically.
