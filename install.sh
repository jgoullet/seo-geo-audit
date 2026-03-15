#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# SEO-GEO Audit System — Installer
# Installs all skills or individual skills to Claude's skill dir
# ═══════════════════════════════════════════════════════════════

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Default install path
SKILL_DIR="${SKILL_DIR:-$HOME/.claude/skills}"
REPO_URL="https://github.com/jgoullet/seo-geo-audit"

# All available skills
ALL_SKILLS=(
  "seo-shared-context"
  "seo-collector"
  "seo-geo-audit"
  "seo-implementer"
  "seo-monitor"
)

# Skills that depend on shared context
DEPENDENT_SKILLS=("seo-collector" "seo-geo-audit" "seo-implementer" "seo-monitor")

print_header() {
  echo ""
  echo -e "${BLUE}═══════════════════════════════════════════${NC}"
  echo -e "${BLUE}  SEO-GEO Audit System — Installer${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════${NC}"
  echo ""
}

print_usage() {
  echo "Usage:"
  echo "  install.sh              Install all skills (full system)"
  echo "  install.sh --skill X    Install a specific skill"
  echo "  install.sh --list       List available skills"
  echo "  install.sh --audit-only Install only the audit skill (standalone, v1 behavior)"
  echo ""
  echo "Skills:"
  echo "  seo-shared-context   Shared data layer (auto-installed with any other skill)"
  echo "  seo-collector        Automated site crawler → site-data.json"
  echo "  seo-geo-audit        Expert audit /90 (the original skill)"
  echo "  seo-implementer      Generates fix files from audit report"
  echo "  seo-monitor          Periodic re-crawl + delta comparison"
  echo ""
  echo "Examples:"
  echo "  curl -fsSL $REPO_URL/raw/main/install.sh | bash"
  echo "  curl -fsSL $REPO_URL/raw/main/install.sh | bash -s -- --skill seo-collector"
  echo "  curl -fsSL $REPO_URL/raw/main/install.sh | bash -s -- --audit-only"
}

install_skill() {
  local skill_name="$1"
  local skill_dir="$SKILL_DIR/$skill_name"

  echo -e "  ${YELLOW}→${NC} Installing ${GREEN}$skill_name${NC}..."

  # Create directory
  mkdir -p "$skill_dir"

  # Download skill files from GitHub
  local base_url="$REPO_URL/raw/main/skills/$skill_name"

  # Always download SKILL.md
  curl -fsSL "$base_url/SKILL.md" -o "$skill_dir/SKILL.md" 2>/dev/null

  # Handle skill-specific extra files
  case "$skill_name" in
    "seo-shared-context")
      mkdir -p "$skill_dir/references"
      curl -fsSL "$base_url/references/seo-standards.md" -o "$skill_dir/references/seo-standards.md" 2>/dev/null
      curl -fsSL "$base_url/references/report-conventions.md" -o "$skill_dir/references/report-conventions.md" 2>/dev/null
      ;;
    "seo-geo-audit")
      curl -fsSL "$base_url/ai-writing-detection.md" -o "$skill_dir/ai-writing-detection.md" 2>/dev/null
      ;;
  esac

  echo -e "  ${GREEN}✓${NC} $skill_name installed → $skill_dir"
}

ensure_shared_context() {
  local skill_name="$1"
  # If installing a dependent skill, auto-install shared context
  for dep in "${DEPENDENT_SKILLS[@]}"; do
    if [ "$skill_name" = "$dep" ]; then
      if [ ! -f "$SKILL_DIR/seo-shared-context/SKILL.md" ]; then
        echo -e "  ${YELLOW}ℹ${NC}  Auto-installing seo-shared-context (required dependency)..."
        install_skill "seo-shared-context"
      fi
      break
    fi
  done
}

# ─── Main ───

print_header

# Parse arguments
MODE="all"
SKILL_TARGET=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --skill)
      MODE="single"
      SKILL_TARGET="$2"
      shift 2
      ;;
    --list)
      MODE="list"
      shift
      ;;
    --audit-only)
      MODE="audit-only"
      shift
      ;;
    --help|-h)
      print_usage
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      print_usage
      exit 1
      ;;
  esac
done

case "$MODE" in
  "list")
    echo "Available skills:"
    for s in "${ALL_SKILLS[@]}"; do
      if [ -f "$SKILL_DIR/$s/SKILL.md" ]; then
        echo -e "  ${GREEN}✓${NC} $s (installed)"
      else
        echo -e "  ○ $s"
      fi
    done
    ;;

  "single")
    # Validate skill name
    valid=false
    for s in "${ALL_SKILLS[@]}"; do
      if [ "$SKILL_TARGET" = "$s" ]; then valid=true; break; fi
    done
    if [ "$valid" = false ]; then
      echo -e "${RED}Unknown skill: $SKILL_TARGET${NC}"
      echo "Available: ${ALL_SKILLS[*]}"
      exit 1
    fi

    ensure_shared_context "$SKILL_TARGET"
    install_skill "$SKILL_TARGET"
    echo ""
    echo -e "${GREEN}Done!${NC} Restart Claude to pick up the new skill."
    ;;

  "audit-only")
    echo "Installing standalone audit skill (v1 mode)..."
    install_skill "seo-geo-audit"
    echo ""
    echo -e "${GREEN}Done!${NC} Standalone audit installed — no system dependencies."
    echo "For the full pipeline, run: install.sh (without --audit-only)"
    ;;

  "all")
    echo "Installing full SEO-GEO system (${#ALL_SKILLS[@]} skills)..."
    echo ""
    for s in "${ALL_SKILLS[@]}"; do
      install_skill "$s"
    done
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo -e "${GREEN}  All ${#ALL_SKILLS[@]} skills installed!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo ""
    echo "Restart Claude Code to pick up the skills."
    echo ""
    echo "Quick start:"
    echo "  \"Collecte les données SEO de https://example.com\""
    echo "  \"Lance l'audit SEO-GEO complet\""
    echo ""
    echo "Pipeline flow:"
    echo "  Collector → site-data.json → Audit → report → Implementer → fixes/"
    ;;
esac
