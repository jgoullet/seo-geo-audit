---
name: seo-shared-context
description: >
  Contexte partagé du système SEO-GEO. Contient le profil client, les standards SEO de référence
  et les conventions de rapport. Ce skill est chargé automatiquement par les autres skills du pipeline
  SEO (seo-collector, seo-geo-audit, seo-implementer, seo-monitor). Ne pas utiliser directement —
  il sert de couche de données partagées. Se déclenche si l'utilisateur demande de "configurer un profil client SEO",
  "initialiser un projet SEO", ou "créer un profil pour l'audit".
---

# SEO Shared Context — Shared data layer

All responses and reports are produced **in English by default**. Switch to the user's language if they explicitly request it (e.g., French, German, Spanish).

This skill provides the context files that all skills in the SEO-GEO pipeline load before executing their work.

## Fichiers de contexte

### 1. `client-profile.md` — Profil client

Ce fichier est créé une seule fois par projet et réutilisé par tous les skills.

Quand l'utilisateur lance un audit pour la première fois, **créer ce fichier** dans le répertoire de travail :

```markdown
# Profil Client SEO

## Identité
- **Nom du site** : [nom]
- **URL** : [url]
- **Secteur** : [secteur d'activité]
- **Type de site** : [e-commerce / blog / SaaS / institutionnel / vitrine]
- **CMS** : [WordPress / Shopify / Webflow / Wix / custom]
- **Mode d'audit** : [Local 🏘️ / Général 🌐]

## Cible
- **Audience** : [B2B / B2C / les deux]
- **Zone géographique** : [ville / pays / international]
- **Langue(s)** : [fr / en / multilingue]

## Concurrents identifiés
1. [URL concurrent 1]
2. [URL concurrent 2]
3. [URL concurrent 3]

## Objectifs
- **Objectif principal** : [trafic / leads / ventes / notoriété]
- **Horizon** : [court terme urgence / moyen-long terme]
- **Budget/ressources** : [solo / équipe interne / agence]

## Accès données
- **Google Search Console** : [oui / non]
- **Google Analytics / GA4** : [oui / non]
- **Historique pénalités** : [oui / non / inconnu]

## Notes
[Contexte supplémentaire fourni par le client]
```

### 2. `seo-standards.md` — Référentiel SEO

Lire le fichier [`references/seo-standards.md`](./references/seo-standards.md) pour les seuils, métriques et bonnes pratiques de référence. Ce fichier est chargé par le Collecteur (pour savoir quoi mesurer) et l'Auditeur (pour savoir comment scorer).

### 3. `report-conventions.md` — Conventions de rapport

Lire le fichier [`references/report-conventions.md`](./references/report-conventions.md) pour le format standardisé des rapports. Assure la cohérence entre le rapport d'audit, le rapport d'implémentation et le rapport de monitoring.

### 4. `gsc-regex-filters.md` — GSC Regex Filters (RE2)

Lire le fichier [`references/gsc-regex-filters.md`](./references/gsc-regex-filters.md) **uniquement quand le GSC MCP est connecté** et que la tâche nécessite une segmentation des requêtes. Contient des patterns regex prêts à l'emploi pour segmenter le trafic par : branded/non-branded, intent (question, transactionnel, local), long-tail conversationnel (query fan-out IA), et requêtes concurrentes. Utilisé par l'Auditeur (scoring) et le Moniteur (delta tracking).

---

## Convention de nommage des fichiers de sortie

Tous les skills du pipeline écrivent dans un dossier projet structuré ainsi :

```
seo-project-[domaine]/
├── client-profile.md          ← Contexte partagé (créé une fois)
├── site-data.json             ← Sortie du Collecteur
├── audit-report.md            ← Sortie de l'Auditeur
├── audit-report.docx          ← Version Word (optionnelle)
├── fixes/                     ← Sortie de l'Implémenteur
│   ├── meta-tags.html
│   ├── schema-jsonld.json
│   ├── redirects.htaccess
│   └── implementation-checklist.md
├── monitoring/                ← Sortie du Moniteur
│   ├── baseline.json          ← Snapshot initial
│   ├── delta-[date].md        ← Comparaisons successives
│   └── alerts.md              ← Alertes actives
└── history/                   ← Historique des audits
    ├── audit-[date].md
    └── site-data-[date].json
```

Chaque skill doit respecter cette structure pour que le chaînage output→input fonctionne.
