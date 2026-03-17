# 🔍 seo-geo-audit — Système d'Audit SEO + GEO Expert

[🇬🇧 English](./README.md) · [🇫🇷 Français](./README.fr.md)

> **D'un skill isolé à un pipeline SEO autonome.**
> 5 skills connectés qui collectent, auditent, implémentent et surveillent — vous validez les résultats au lieu d'orchestrer les étapes.
> Rapports en **anglais par défaut** · Français disponible sur demande

---

## ⚡ Installation

```bash
# Système complet (5 skills)
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash

# Un skill spécifique
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash -s -- --skill seo-collector

# Audit seul (comportement v1)
curl -fsSL https://raw.githubusercontent.com/jgoullet/seo-geo-audit/main/install.sh | bash -s -- --audit-only
```

Pour **Claude.ai** : télécharger les fichiers `.skill` depuis les [Releases](https://github.com/jgoullet/seo-geo-audit/releases) et les installer via Paramètres > Skills.

---

## Quoi de neuf en v2.1

| | v1 (standalone) | v2.1 (système) |
|---|---|---|
| **Collecte de données** | Manuelle (15 questions) | Crawler automatique + Ahrefs MCP |
| **Audit** | Estimations uniquement | Données réelles si MCP connecté |
| **Tracking analytics** | Non couvert | Détecte 11 outils, score de maturité |
| **Implémentation** | À vous de trouver | Fichiers de correction prêts à déployer |
| **Monitoring** | Revenez dans 3 mois | Rapports delta automatiques + tendances Ahrefs |
| **Contexte** | Réinitialisé à chaque session | Profil client partagé |
| **Langue** | Français uniquement | Anglais par défaut (toute langue sur demande) |

---

## Le système — comment les skills se connectent

```
┌─────────────────────────────────────────────┐
│         seo-shared-context                  │
│   client-profile.md · seo-standards.md      │
│   report-conventions.md                     │
│         (chargé par tous les skills)        │
└──────────────────┬──────────────────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-collector          │
    │  Crawl automatique du site  │──→ site-data.json
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-geo-audit          │
    │  Audit expert, scores /90   │──→ audit-report.md + audit-actions.json
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-implementer        │
    │  Génère les corrections     │──→ fixes/ (meta, schema, redirects, analytics)
    └──────────────┬──────────────┘
                   │
    ┌──────────────▼──────────────┐
    │      seo-monitor            │
    │  Re-crawl + rapport delta   │──→ monitoring/ (baseline, delta, alertes)
    └──────────────┘
         ↻ boucle vers le collecteur
```

---

## Référence des skills

### seo-shared-context

Couche de données partagées. Contient le template de profil client, le référentiel SEO (seuils Core Web Vitals avec définitions claires, critères E-E-A-T, pourcentages de boost GEO), et les conventions de rapport.

### seo-collector

Crawler technique automatisé. Produit un `site-data.json` structuré avec :
- Balises HTML (title, meta, H1, OG tags) pour la page d'accueil + 3-5 pages échantillons
- Analyse `robots.txt` avec vérification d'accès des bots IA
- Détection sitemap et comptage d'URLs
- Core Web Vitals (via PageSpeed Insights)
- Détection schema markup (avec avertissement injection JS)
- Audit analytics & tracking : détecte 11 outils (GA4, GTM, Meta Pixel, Hotjar/Clarity, Segment, Mixpanel...), vérifie les événements de conversion, consent management, attribue un niveau de maturité
- HTTPS et en-têtes de sécurité
- Estimations d'indexation Google/Bing/Brave

**Optionnel : Ahrefs MCP** — Connectez votre compte Ahrefs (plan Lite+) pour obtenir le Domain Rating réel, les données de backlinks, les mots-clés organiques avec positions, l'identification de concurrents, et Brand Radar (suivi des citations IA).

### seo-geo-audit

Le skill d'audit expert — lit `site-data.json` quand disponible (y compris les données Ahrefs et analytics), sautant la collecte manuelle. Produit un rapport scoré /90 sur 7 dimensions avec analyse concurrentielle et plan d'action priorisé. Inclut désormais le scoring de maturité analytics dans la section UX & Conversion.

### seo-implementer

Lit les résultats de l'audit et génère des fichiers prêts à déployer : meta tags réécrites, blocs JSON-LD, règles de redirection (Apache/Nginx/Vercel/Shopify), corrections robots.txt, snippets de contenu optimisé, recommandations de setup analytics (adaptées au CMS et type de site), et une checklist d'implémentation étape par étape avec tests de vérification.

### seo-monitor

Re-crawl périodique qui compare l'état actuel avec le baseline du premier audit. Produit un rapport delta montrant les améliorations, régressions et alertes. Si Ahrefs MCP est connecté, suit l'évolution du Domain Rating, les changements de backlinks, et les tendances de citation IA via Brand Radar.

---

## Intégrations MCP (toutes optionnelles)

Le système fonctionne sans aucun MCP. Chaque intégration remplace les estimations par des données réelles :

| MCP | Ce qu'il ajoute | Plan minimum | Configuration |
|---|---|---|---|
| **[Ahrefs](https://ahrefs.com/mcp/)** | Domain Rating, backlinks, mots-clés organiques, concurrents, Brand Radar (citations IA) | Lite ($29/mois) | Connecter via Ahrefs MCP dans les paramètres Claude |
| **[GA4](https://github.com/googleanalytics/google-analytics-mcp)** | Trafic organique réel, taux de rebond, conversions | Gratuit | Connecter le serveur MCP GA4 |
| **[GSC](https://github.com/ahonn/mcp-server-gsc)** | Positions réelles, impressions AI Overviews, quick wins | Gratuit | Connecter le serveur MCP GSC |

---

## Décomposition du score — /90 au total

| Dimension | Max | Ce qui est évalué |
|---|---|---|
| SEO Technique | /10 | Title, meta, H1, URLs, HTTPS, sitemap, robots.txt, canonicals, redirections |
| Core Web Vitals | /10 | LCP (vitesse de chargement), CLS (stabilité visuelle), INP (réactivité) — mobile vs desktop |
| SEO Local ou Contenu & Autorité | /20 | GBP, NAP, Local Pack / Topical authority, backlinks, positionnement |
| E-E-A-T | /10 | Expérience, Expertise, Autorité, Confiance |
| Entity SEO | /10 | Knowledge Panel, Wikidata, cohérence d'entité, schema `sameAs` |
| GEO | /20 | Méthodes Princeton, bots IA, signaux par plateforme, tests de citation IA |
| UX & Conversion | /10 | Navigation, CTAs, signaux de confiance, maturité analytics, cohérence SERP → landing |

---

## Exemples d'utilisation

### Pipeline complet

```
"Collecte les données SEO de https://example.com"
→ Le Collecteur crawl, produit site-data.json (+ données Ahrefs si connecté)

"Lance l'audit SEO-GEO complet"
→ L'Auditeur lit site-data.json, produit le rapport scoré /90

"Génère les corrections"
→ L'Implémenteur lit les résultats, produit les fichiers de correction + setup analytics

"Lance le monitoring"
→ Le Moniteur re-crawl, compare au baseline, alerte si régression
```

### Audit standalone (fonctionne toujours)

```
"Audite https://monsite.fr en mode Local.
Je suis plombier à Lyon.
Concurrents : plombier-lyon1.fr et plombier-express-lyon.fr
Objectif : apparaître dans le Local Pack"
```

---

## Structure du repo

```
seo-geo-audit/
├── install.sh                          # Installeur système
├── uninstall.sh                        # Désinstalleur
├── README.md                           # Documentation anglaise 🇬🇧
├── README.fr.md                        # Ce fichier 🇫🇷
├── LICENSE
└── skills/
    ├── seo-shared-context/
    │   ├── SKILL.md                    # Couche de données partagées
    │   └── references/
    │       ├── seo-standards.md        # Seuils & métriques (avec définitions CWV)
    │       └── report-conventions.md   # Règles de formatage des rapports
    ├── seo-collector/
    │   └── SKILL.md                    # Crawler automatisé + Ahrefs MCP + audit analytics
    ├── seo-geo-audit/
    │   ├── SKILL.md                    # Audit expert /90
    │   └── ai-writing-detection.md     # Référence marqueurs écriture IA
    ├── seo-implementer/
    │   └── SKILL.md                    # Générateur de corrections + setup analytics
    └── seo-monitor/
        └── SKILL.md                    # Monitoring delta + Brand Radar
```

---

## Adaptation sectorielle

| Secteur | Priorités spécifiques |
|---|---|
| Restaurant / Hôtel | GBP +++, avis, photos, menu structuré |
| Santé / Médecin | E-E-A-T +++, YMYL, disclaimers |
| Finance / Juridique | E-E-A-T +++, auteurs experts, signaux de confiance |
| E-commerce | Schema Product, Core Web Vitals, navigation à facettes |
| SaaS / B2B | Topical authority, backlinks sectoriels, études de cas |
| Artisan / TPE | GBP, cohérence NAP, citations locales |

---

## Sources & méthodologie

- **Méthodes GEO** : Princeton / IIT Delhi / Georgia Tech — *"GEO: Generative Engine Optimization"*, KDD 2024 ([arXiv:2311.09735](https://arxiv.org/abs/2311.09735))
- **Algorithmes plateformes** : Étude SE Ranking (129K domaines), analyse Perplexity Sonar, Google Quality Rater Guidelines
- **Ahrefs MCP** : [Documentation Ahrefs MCP](https://ahrefs.com/mcp/) — Brand Radar, Domain Rating, analyse backlinks
- **GA4 MCP** : [google-analytics-mcp](https://github.com/googleanalytics/google-analytics-mcp) — serveur MCP officiel
- **GSC MCP** : [mcp-server-gsc](https://github.com/ahonn/mcp-server-gsc) — MCP Google Search Console
- **Architecture système** : Inspirée des patterns de skill systems (contexte partagé, chaînage output-as-input, orchestration planifiée)

---

## Licence

MIT — libre d'utilisation, modification et redistribution.

---

*Rapport en anglais par défaut · Français disponible sur demande · Compatible Claude Code, Claude.ai & Codex CLI*
