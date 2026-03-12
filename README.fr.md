# 🔍 seo-geo-audit — Skill d'Audit SEO + GEO Expert

[🇬🇧 English](./README.md) · [🇫🇷 Français](./README.fr.md)

> **Audit SEO expert (Local ou Général) + GEO (Generative Engine Optimization)**  
> Rapport scoré /90 · Analyse concurrentielle · Visibilité IA · Plan d'action priorisé avec ROI estimé  
> Rapports générés en **anglais par défaut** · Français disponible sur demande

---

## ⚡ Installation

```bash
# Claude Code
npx skills add https://github.com/jgoullet/seo-geo-audit --skill seo-geo-audit

# OpenAI Codex CLI
npx skills add https://github.com/jgoullet/seo-geo-audit --skill seo-geo-audit
```

Pour **Claude.ai** : télécharger le fichier `.skill` depuis les Releases et l'installer via Paramètres > Skills.

---

## Ce que ça fait

Ce skill transforme Claude en **consultant SEO senior** capable de produire un audit complet et scoré de n'importe quel site web — qu'il s'agisse d'un commerce local ou d'une marque nationale.

### Deux modes d'audit

| Mode | Pour qui ? | Couverture |
|---|---|---|
| 🏘️ **Local** | Restaurant, artisan, médecin, agence locale... | SEO Technique + Core Web Vitals + SEO Local + E-E-A-T + Entity SEO + GEO + UX |
| 🌐 **Général** | E-commerce, SaaS, blog, média, B2B/B2C... | SEO Technique + Core Web Vitals + Contenu & Autorité + E-E-A-T + Entity SEO + GEO + UX |

### Décomposition du score — /90 au total

| Dimension | Max | Ce qui est évalué |
|---|---|---|
| SEO Technique | /10 | Title, meta, H1, URLs, HTTPS, sitemap, robots, canonicals, redirections |
| Core Web Vitals | /10 | LCP, CLS, INP, FCP, TTFB — mobile vs desktop |
| SEO Local ou Contenu & Autorité | /20 | GBP, NAP, Local Pack / Topical authority, backlinks, positionnement |
| E-E-A-T | /10 | Expérience, Expertise, Autorité, Confiance |
| Entity SEO | /10 | Knowledge Panel, Wikidata, cohérence d'entité, schema `sameAs` |
| GEO | /20 | Méthodes Princeton, accès bots, signaux par plateforme, tests de citation IA |
| UX & Conversion | /10 | Navigation, CTA, trust signals, mobile-first, cohérence SERP → landing |

---

## Ce qu'il y a dedans

### 📊 Rapport scoré expert
Chaque dimension reçoit un score chiffré avec justification. Plus de recommandations vagues — le client voit exactement où il en est et pourquoi.

### 🤖 GEO — Generative Engine Optimization
Basé sur la **recherche Princeton/KDD 2024** (arXiv:2311.09735), le skill évalue :
- Les **9 méthodes GEO** avec leurs boosts de visibilité mesurés (+40% citations, +37% statistiques...)
- **L'accès des bots IA** dans `robots.txt` (GPTBot, PerplexityBot, ClaudeBot, anthropic-ai, Bingbot...)
- Les signaux de ranking spécifiques à **ChatGPT, Perplexity, Google AI Overview, Copilot et Claude**
- À noter : Claude utilise **Brave Search** (pas Google/Bing) — un détail critique souvent manqué

### 🏘️ SEO Local approfondi
- Audit complet Google Business Profile (12 critères)
- Cohérence NAP sur tous les annuaires
- Positionnement Local Pack
- Validation du schema LocalBusiness

### 🎯 E-E-A-T & Entity SEO
- Credentials auteurs, conformité YMYL, signaux de confiance
- Google Knowledge Panel, identifiant Wikidata, schema `Organization` + `sameAs`

### ⚠️ Garde-fou détection schema
`web_fetch` ne peut pas détecter le JSON-LD injecté par JavaScript (Yoast, RankMath, AIOSEO...). Le skill signale cette limitation et redirige vers **Google Rich Results Test** pour éviter les faux négatifs.

### 📝 Détection écriture IA
Lors de l'audit du contenu, le skill repère les marqueurs d'écriture IA (em dashes, "leverage", "robust", "in today's digital age"...) comme signaux E-E-A-T négatifs. Inclut une référence complète avec alternatives.

### 🏆 Analyse concurrentielle
Tableau comparatif côte à côte contre jusqu'à 3 concurrents sur les 7 dimensions.

### 📋 Plan d'action priorisé avec ROI
- 🟢 Quick wins (< 1 semaine)
- 🟡 Moyen terme (1–3 mois)
- 🔴 Long terme (3–6 mois)

Chaque action inclut : estimation d'effort, impact trafic/leads, ressources nécessaires.

---

## Exemples d'utilisation

```
Audite mon site https://monsite.fr en mode Local.
Je suis plombier à Lyon.
Mes concurrents : plombier-lyon1.fr et plombier-express-lyon.fr
Objectif : apparaître dans le Local Pack Google
```

```
Fais un audit SEO complet de https://ma-boutique.com
Mode Général — e-commerce mode & accessoires
Concurrents : asos.fr, zalando.fr
J'ai accès à Google Search Console
```

Le skill collecte les informations manquantes, lance l'audit complet via web search et web fetch, et livre un rapport structuré scoré /90 avec plan d'action priorisé.

---

## Structure du rapport

```
1. RÉSUMÉ EXÉCUTIF         — Score /90, classement vs concurrents, 3 forces/faiblesses
2. TABLEAU DE BORD         — 7 dimensions avec indicateurs 🔴/🟡/🟢
3. RÉSULTATS DÉTAILLÉS     — Score + justification + sources par dimension
4. ANALYSE CONCURRENTIELLE — Tableau comparatif + keyword gap (top 10 cibles)
5. PLAN D'ACTION + ROI     — Quick wins / Moyen terme / Long terme avec impact estimé
6. MÉTRIQUES DE SUIVI      — KPIs à tracker + alertes à configurer
7. GLOSSAIRE               — Termes techniques expliqués pour les non-spécialistes
8. CONCLUSION              — Synthèse en 3 phrases + recommandation de re-audit
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

## Compatible avec

![Claude Code](https://img.shields.io/badge/Claude_Code-✓-8B5CF6?style=flat-square)
![Claude.ai](https://img.shields.io/badge/Claude.ai-✓-8B5CF6?style=flat-square)
![OpenAI Codex CLI](https://img.shields.io/badge/Codex_CLI-✓-10B981?style=flat-square)

---

## Fichiers

```
seo-geo-audit/
├── SKILL.md                  # Skill principal — framework d'audit complet
├── ai-writing-detection.md   # Référence — marqueurs d'écriture IA à éviter
├── README.md                 # Documentation en anglais 🇬🇧
└── README.fr.md              # Documentation en français 🇫🇷
```

---

## Sources & méthodologie

- **Méthodes GEO** : Princeton University / IIT Delhi / Georgia Tech / Allen Institute for AI — *"GEO: Generative Engine Optimization"*, KDD 2024 ([arXiv:2311.09735](https://arxiv.org/abs/2311.09735))
- **Algorithmes plateformes** : Étude SE Ranking (129K domaines), analyse architecture Perplexity Sonar, Google Search Quality Rater Guidelines
- **Détection écriture IA** : Grammarly, Microsoft 365 Life Hacks, GPTHuman, Textero (2025)
- **Validation schema** : Basé sur les limitations connues des parseurs HTML statiques vs Rich Results Test

---

## Licence

MIT — libre d'utilisation, modification et redistribution.

---

*Rapport en anglais par défaut · Français disponible sur demande · Compatible Claude Code & Claude.ai*
