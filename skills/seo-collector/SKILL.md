---
name: seo-collector
description: >
  Collecteur automatique de données SEO techniques. Crawl un site web et produit un fichier
  site-data.json structuré contenant : balises title/meta/H1, robots.txt, sitemap, headers HTTP,
  Core Web Vitals (via PageSpeed Insights), détection schema markup, analyse robots.txt pour les
  bots IA, et snapshot des pages principales. Ce skill est la première étape du pipeline SEO-GEO :
  il collecte les données brutes que le skill seo-geo-audit consomme ensuite pour produire l'audit.
  Utilise ce skill quand l'utilisateur dit : "collecte les données SEO de [url]", "crawl ce site",
  "analyse technique de [url]", "prépare les données pour l'audit", "lance le collecteur sur [url]",
  "scrape les métriques SEO", ou quand le skill seo-geo-audit a besoin de données techniques brutes.
  Déclenche aussi pour : "vérifie les Core Web Vitals de", "check le robots.txt de", "analyse les
  meta tags de", "est-ce que les bots IA peuvent accéder à".
---

# Skill: SEO Collector — Automated technical data collection

All responses and logs are produced **in English by default**. Switch to the user's language if they explicitly request it.

---

## Vue d'ensemble

Ce skill crawl automatiquement un site web et produit un fichier `site-data.json` structuré, prêt à être consommé par le skill `seo-geo-audit`. Il remplace la collecte manuelle d'informations (étape 0 de l'audit).

### Position dans le pipeline

```
[seo-shared-context] → client-profile.md
                            ↓
              ┌─────────────────────────┐
              │  SEO COLLECTOR (ce skill) │
              └─────────────────────────┘
                            ↓
                     site-data.json
                            ↓
              ┌─────────────────────────┐
              │     SEO-GEO AUDIT       │
              └─────────────────────────┘
```

---

## Étape 0 : Vérifications préalables

### Entrées requises
- **URL du site** (obligatoire)
- **client-profile.md** (optionnel — si disponible, le charger pour connaître le mode Local/Général, les concurrents, le CMS)

### Vérification de base
Avant de commencer, tester que le site est accessible :

```
web_fetch: [URL]
```

Si erreur (timeout, 5xx, site en maintenance) → noter dans le rapport et arrêter. Si redirection → suivre et noter l'URL finale.

---

## Étape 1 : Collecte des métadonnées de la page d'accueil

Utiliser `web_fetch` sur l'URL principale et extraire :

### 1.1 Balises HTML essentielles

```json
{
  "homepage": {
    "url_final": "[URL après redirections]",
    "status_code": 200,
    "title": "[contenu de <title>]",
    "title_length": 55,
    "meta_description": "[contenu de meta description]",
    "meta_description_length": 148,
    "h1": "[contenu du H1]",
    "h1_count": 1,
    "h2_list": ["H2 1", "H2 2", "..."],
    "canonical": "[URL canonical]",
    "lang": "fr",
    "hreflang": ["fr", "en"],
    "viewport_meta": true,
    "og_tags": {
      "og:title": "...",
      "og:description": "...",
      "og:image": "...",
      "og:type": "..."
    },
    "twitter_card": "summary_large_image"
  }
}
```

### 1.2 Détection du CMS

Chercher dans le HTML source des marqueurs :
- WordPress : `wp-content/`, `wp-includes/`, meta generator "WordPress"
- Shopify : `cdn.shopify.com`, `Shopify.theme`
- Webflow : `webflow.com`, `.w-` classes
- Wix : `wix.com`, `_wix_browser_sess`
- Next.js : `__NEXT_DATA__`, `_next/`
- Autre : noter les frameworks JS détectés

---

## Étape 2 : Robots.txt & Sitemap

### 2.1 Robots.txt

```
web_fetch: [URL]/robots.txt
```

Extraire et structurer :

```json
{
  "robots_txt": {
    "exists": true,
    "raw_content": "[contenu brut — tronqué si > 500 lignes]",
    "user_agents": {
      "Googlebot": { "allowed": true, "disallowed_paths": ["/admin/"] },
      "GPTBot": { "allowed": true, "disallowed_paths": [] },
      "ChatGPT-User": { "allowed": true, "disallowed_paths": [] },
      "PerplexityBot": { "allowed": false, "disallowed_paths": ["/ "] },
      "ClaudeBot": { "allowed": true, "disallowed_paths": [] },
      "anthropic-ai": { "allowed": true, "disallowed_paths": [] },
      "Bingbot": { "allowed": true, "disallowed_paths": [] }
    },
    "sitemaps_declared": ["https://example.com/sitemap.xml"],
    "crawl_delay": null
  }
}
```

> **Important** : Pour chaque bot IA, vérifier s'il est explicitement bloqué par un `Disallow: /` ou hérité du `User-agent: *`. Distinguer les deux cas.

### 2.2 Sitemap XML

```
web_fetch: [URL]/sitemap.xml
```

Si absent, chercher dans le robots.txt. Extraire :

```json
{
  "sitemap": {
    "exists": true,
    "url": "https://example.com/sitemap.xml",
    "type": "index|urlset",
    "total_urls": 342,
    "sample_urls": ["[5 premières URLs]"],
    "last_modified": "2024-01-15",
    "sub_sitemaps": ["[si sitemap index]"]
  }
}
```

---

## Étape 3 : Core Web Vitals

Rechercher les données PageSpeed Insights :

```
web_search: "PageSpeed Insights [URL]"
web_search: "[domaine] core web vitals"
web_search: "[domaine] site speed test"
```

Structurer les résultats trouvés :

```json
{
  "core_web_vitals": {
    "source": "PageSpeed Insights / estimation web",
    "mobile": {
      "performance_score": 72,
      "lcp": { "value": "2.8s", "rating": "needs_improvement" },
      "cls": { "value": "0.05", "rating": "good" },
      "inp": { "value": "180ms", "rating": "good" },
      "fcp": { "value": "1.6s", "rating": "good" },
      "ttfb": { "value": "0.9s", "rating": "needs_improvement" }
    },
    "desktop": {
      "performance_score": 89,
      "lcp": { "value": "1.2s", "rating": "good" },
      "cls": { "value": "0.02", "rating": "good" },
      "inp": { "value": "95ms", "rating": "good" },
      "fcp": { "value": "0.8s", "rating": "good" },
      "ttfb": { "value": "0.5s", "rating": "good" }
    },
    "data_freshness": "estimated",
    "note": "[si données non trouvées, indiquer clairement]"
  }
}
```

> Si les données PageSpeed précises ne sont pas trouvées, chercher via des outils tiers (GTmetrix, WebPageTest) ou estimer à partir du HTML (taille de page, nombre de scripts, images non optimisées).

---

## Étape 4 : HTTPS & Headers de sécurité

Analyser via `web_fetch` les headers HTTP :

```json
{
  "security": {
    "https": true,
    "http_to_https_redirect": true,
    "hsts": true,
    "content_security_policy": false,
    "x_frame_options": "SAMEORIGIN",
    "x_content_type_options": "nosniff",
    "mixed_content_detected": false
  }
}
```

---

## Étape 5 : Détection Schema Markup

> ⚠️ **LIMITE CRITIQUE** : `web_fetch` ne peut PAS détecter les données structurées JSON-LD injectées via JavaScript. De nombreux CMS injectent le schema côté client.

### Ce que le Collecteur peut faire :
1. Chercher `<script type="application/ld+json">` dans le HTML statique
2. Chercher les attributs `itemscope`, `itemtype` (Microdata)
3. Chercher les attributs `typeof`, `property` (RDFa)

### Ce qu'il doit signaler :
- Si aucun schema trouvé ET CMS détecté (WordPress + Yoast/RankMath, Shopify...) → signaler : "Schema probablement injecté côté client — non détectable via web_fetch. Vérifier via Google Rich Results Test."

```json
{
  "schema_markup": {
    "detection_method": "web_fetch HTML statique",
    "json_ld_found": true,
    "json_ld_types": ["Organization", "LocalBusiness", "FAQPage"],
    "microdata_found": false,
    "rdfa_found": false,
    "reliability": "high|medium|low",
    "note": "[avertissement si CMS détecté mais aucun schema trouvé]"
  }
}
```

---

## Étape 6 : Pages secondaires (sample crawl)

Crawler 3-5 pages supplémentaires en se basant sur :
- Le sitemap (si disponible)
- Les liens de navigation principale
- Les types de pages clés (page service, article blog, fiche produit, page contact)

Pour chaque page, collecter les mêmes données que l'étape 1 (title, meta, H1, H2).

```json
{
  "pages_sample": [
    {
      "url": "https://example.com/services",
      "type": "service",
      "title": "...",
      "title_length": 48,
      "meta_description": "...",
      "meta_description_length": 0,
      "h1": "...",
      "h1_count": 1,
      "issues": ["meta_description_missing"]
    }
  ]
}
```

---

## Étape 7 : Indexation & Présence externe

### 7.1 Indexation Google
```
web_search: "site:[domaine]"
```
Estimer le nombre de pages indexées.

### 7.2 Indexation Bing
```
web_search: "site:[domaine] bing"
```

### 7.3 Indexation Brave
```
web_search: "[domaine] brave search index"
```

### 7.4 Présence dans les annuaires (mode Local)
```
web_search: "[nom entreprise] [ville] pages jaunes"
web_search: "[nom entreprise] [ville] yelp OR tripadvisor OR doctolib"
```

```json
{
  "indexation": {
    "google_pages_indexed": "~340",
    "bing_indexed": true,
    "brave_indexed": true,
    "external_listings": {
      "pages_jaunes": true,
      "yelp": false,
      "tripadvisor": false,
      "doctolib": false,
      "other": []
    }
  }
}
```

---

## Étape 8 : Assemblage du site-data.json

Assembler toutes les données collectées dans un fichier JSON unique :

```json
{
  "metadata": {
    "collector_version": "1.0",
    "collection_date": "[ISO 8601]",
    "url_audited": "[URL]",
    "url_final": "[URL après redirections]",
    "domain": "[domaine extrait]",
    "collection_duration": "[temps estimé]",
    "data_completeness": "high|medium|low"
  },
  "homepage": { "..." },
  "robots_txt": { "..." },
  "sitemap": { "..." },
  "core_web_vitals": { "..." },
  "security": { "..." },
  "schema_markup": { "..." },
  "pages_sample": [ "..." ],
  "indexation": { "..." },
  "cms_detected": "wordpress",
  "issues_summary": {
    "critical": ["[liste des problèmes critiques détectés]"],
    "warnings": ["[liste des avertissements]"],
    "info": ["[notes informatives]"]
  }
}
```

### Écriture du fichier

Sauvegarder dans le répertoire de travail :
```
seo-project-[domaine]/site-data.json
```

Si un `client-profile.md` n'existe pas encore, en créer un pré-rempli avec les informations détectées (CMS, langue, type de site estimé).

---

## Étape 9 : Résumé pour l'utilisateur

Après la collecte, présenter un résumé clair :

```
═══════════════════════════════════════
COLLECTE SEO TERMINÉE — [domaine]
Date : [date]
═══════════════════════════════════════

📊 Données collectées :
   ✅ Homepage : title, meta, H1, OG tags
   ✅ Robots.txt : [X] bots IA autorisés / [Y] bloqués
   ✅ Sitemap : [N] URLs trouvées
   ✅ Core Web Vitals : [source]
   ✅ Sécurité : HTTPS [oui/non]
   ✅ Schema : [types trouvés]
   ✅ Sample : [N] pages analysées
   ✅ Indexation : ~[N] pages Google

⚠️ Problèmes détectés : [N critique] / [N warning]
   [Liste des 3 problèmes les plus importants]

📁 Fichier généré : site-data.json
   → Prêt pour le skill seo-geo-audit

Souhaitez-vous lancer l'audit complet maintenant ?
```

---

## Gestion des erreurs

| Situation | Action |
|---|---|
| Site inaccessible (timeout) | Réessayer après 5s. Si échec → noter et arrêter. |
| Robots.txt absent | Noter `exists: false`, continuer. |
| Sitemap absent | Chercher dans robots.txt, sinon noter `exists: false`. |
| PageSpeed non trouvé | Estimer via l'analyse HTML, noter `source: "estimation"`. |
| Page 403/401 | Noter, continuer avec les autres pages. |
| Rate limiting détecté | Espacer les requêtes, noter dans le rapport. |

---

## Chaînage avec le skill suivant

Le fichier `site-data.json` est conçu pour être lu directement par le skill `seo-geo-audit`. Quand l'utilisateur demande de lancer l'audit après la collecte :

1. Vérifier que `site-data.json` existe
2. Le passer en contexte au skill seo-geo-audit
3. Le skill d'audit peut sauter l'Étape 0 (collecte manuelle) et aller directement à l'analyse

> **Pattern 2 appliqué** : Output-as-input chaining. Le collecteur écrit un JSON structuré, l'auditeur le lit. Couplage faible, format partagé comme couche API.
