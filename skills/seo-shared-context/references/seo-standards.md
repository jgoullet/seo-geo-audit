# SEO-GEO Reference — Standards & Thresholds

## Table of contents
1. Core Web Vitals (with plain-language definitions)
2. Technical SEO thresholds
3. Local SEO thresholds
4. Content & Authority thresholds
5. GEO thresholds
6. AI Bots — User-agents

---

## 1. Core Web Vitals

Google uses these three metrics to measure how users experience your site. They directly affect search rankings.

### LCP — Largest Contentful Paint (loading speed)

**What it measures:** How long it takes for the biggest visible element on the page (usually the hero image or a large text block) to fully appear. On an e-commerce site, this is typically the main product image or the homepage banner.

**Why it matters:** If it takes too long, users leave before seeing your content. Every extra second of load time increases bounce rate significantly.

| Rating | Threshold |
|---|---|
| Good | < 2.5s |
| Needs improvement | 2.5–4s |
| Poor | > 4s |

### CLS — Cumulative Layout Shift (visual stability)

**What it measures:** Whether elements on the page jump around unexpectedly while loading. For example: you're about to tap "Add to cart" and suddenly an image loads above it, pushing the button down — so you tap the wrong thing.

**Why it matters:** Layout shifts frustrate users and cause misclicks. This is especially problematic on mobile, where screen space is limited.

| Rating | Threshold |
|---|---|
| Good | < 0.1 |
| Needs improvement | 0.1–0.25 |
| Poor | > 0.25 |

### INP — Interaction to Next Paint (responsiveness)

**What it measures:** The delay between a user action (click, tap, keypress) and the site's visible response. When a customer clicks "Add to cart," INP measures how long before the site shows any visual feedback.

**Why it matters:** Slow responses make a site feel broken. Users expect near-instant feedback — anything above half a second feels laggy.

| Rating | Threshold |
|---|---|
| Good | < 200ms |
| Needs improvement | 200–500ms |
| Poor | > 500ms |

### Additional performance metrics

| Metric | What it measures | Good | Medium | Poor |
|---|---|---|---|---|
| FCP (First Contentful Paint) | Time until the first piece of content appears | < 1.8s | 1.8–3s | > 3s |
| TTFB (Time to First Byte) | Time until the server sends its first response | < 800ms | 800ms–1.8s | > 1.8s |

---

## 2. Technical SEO thresholds

### Title & Meta
- Title: 50–60 characters, primary keyword present
- Meta description: 140–160 characters, compelling with a CTA
- H1: one per page, contains the primary keyword

### Structure
- Maximum depth: 3 clicks from the homepage
- URLs: < 100 characters, clean, no unnecessary parameters
- Images: all key images with descriptive alt text

### Protocol & security
- HTTPS required, valid certificate, no mixed content
- XML Sitemap present and submitted to GSC
- Robots.txt not blocking important pages

---

## 3. Local SEO thresholds

### Google Business Profile
- Review count: > 20 (local pack) / > 50 (excellent)
- Review rating: ≥ 4.5 (excellent) / 4.0–4.4 (good) / < 4.0 (needs work)
- Review responses: 100% of negatives, ideally all reviews
- Posts: at least 1×/week
- Photos: recent (< 6 months), varied (interior, team, products)

### NAP (Name, Address, Phone)
- Must be identical across all listings, without exception

---

## 4. Content & Authority thresholds

### Content
- Pillar pages: 2000+ words, well-structured, comprehensive
- Thin content: no pages < 300 words with no added value
- Freshness: updated within last 30 days (×3.2 ChatGPT citations)

### E-E-A-T (Experience, Expertise, Authoritativeness, Trustworthiness)
- Author pages with bio, credentials, professional links
- Complete "About" page
- Sources cited in articles
- YMYL (Your Money Your Life): disclaimers required for health, finance, legal topics

### Authority
- Referring domains: > 350K = 8.4 ChatGPT citations on average
- Quality backlinks: press, universities, government sites
- Natural anchor text profile

---

## 5. GEO thresholds (Generative Engine Optimization)

### AI visibility boost (Princeton/KDD 2024)

| Method | Average boost |
|---|---|
| Citing authoritative sources | +40% |
| Adding verifiable statistics | +37% |
| Including expert quotes | +30% |
| Authoritative tone | +25% |
| Accessible language | +20% |
| Relevant technical terminology | +18% |
| Varied vocabulary | +15% |
| Optimized fluency | +15–30% |
| Keyword stuffing | **-10%** |

### LLM-friendly content structure
- "Answer-first" format: direct answer in the first paragraph
- Paragraphs: < 3–4 sentences per block
- Structured FAQ in explicit Q&A format
- Interrogative headings (How..., Why..., What...)

---

## 6. AI Bots — User-agents to check in robots.txt

| Company | User-agent | Platform |
|---|---|---|
| Google | Googlebot | Google AI Overview |
| OpenAI | GPTBot | ChatGPT |
| OpenAI | ChatGPT-User | ChatGPT browsing |
| Perplexity | PerplexityBot | Perplexity AI |
| Anthropic | ClaudeBot | Claude |
| Anthropic | anthropic-ai | Claude |
| Microsoft | Bingbot | Copilot / Bing |

> Note: Claude uses **Brave Search** (not Google/Bing). To be cited by Claude, a site must be indexed by Brave Search AND allow ClaudeBot/anthropic-ai.
