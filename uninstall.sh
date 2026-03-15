#!/bin/bash
# SEO-GEO Audit System — Uninstaller

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SKILL_DIR="${SKILL_DIR:-$HOME/.claude/skills}"

ALL_SKILLS=(
  "seo-shared-context"
  "seo-collector"
  "seo-geo-audit"
  "seo-implementer"
  "seo-monitor"
)

echo ""
echo -e "${YELLOW}SEO-GEO Audit System — Uninstaller${NC}"
echo ""

if [ "$1" = "--skill" ] && [ -n "$2" ]; then
  # Remove single skill
  target="$SKILL_DIR/$2"
  if [ -d "$target" ]; then
    rm -rf "$target"
    echo -e "${GREEN}✓${NC} Removed $2"
  else
    echo -e "${RED}✗${NC} $2 not found at $target"
  fi
else
  # Remove all
  echo "Removing all SEO-GEO skills..."
  for s in "${ALL_SKILLS[@]}"; do
    target="$SKILL_DIR/$s"
    if [ -d "$target" ]; then
      rm -rf "$target"
      echo -e "  ${GREEN}✓${NC} Removed $s"
    fi
  done
  echo ""
  echo -e "${GREEN}Done!${NC} All SEO-GEO skills removed."
fi
