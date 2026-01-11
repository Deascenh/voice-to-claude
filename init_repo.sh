#!/bin/bash
# Script pour initialiser le repository Git avec GitFlow

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║   Voice to Claude - Initialisation Git + GitFlow         ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warning() { echo -e "${YELLOW}⚠${NC} $1"; }

# Vérifier si git est installé
if ! command -v git &> /dev/null; then
    echo "❌ Git n'est pas installé"
    echo "   Installez-le avec: sudo apt install git (Linux) ou brew install git (macOS)"
    exit 1
fi

# Vérifier si c'est déjà un repo git
if [ -d ".git" ]; then
    warning "Ce dossier est déjà un repository Git"
    read -p "Voulez-vous réinitialiser ? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Conservation du repo existant"
        info "Pour GitFlow, créez manuellement la branche develop:"
        echo "   git checkout -b develop"
        exit 0
    fi
    rm -rf .git
fi

# Initialiser le repo
info "Initialisation du repository Git..."
git init
git branch -M main
success "Repository Git initialisé"
echo ""

# Ajouter tous les fichiers
info "Ajout des fichiers..."
git add .
success "Fichiers ajoutés au staging"
echo ""

# Créer le commit initial
info "Création du commit initial..."
git commit -m "Initial commit: Voice to Claude v1.0.0

- Mode Session Interactive avec mots magiques (stop/terminé)
- Mode Temps Réel pour injection directe
- Mode Daemon avec push-to-talk
- Mode Copier-Coller classique
- Structure professionnelle avec tests
- CI/CD avec GitHub Actions
- GitFlow workflow
- Pre-commit hooks
- Makefile pour commandes simplifiées

🎤 Ready for collaboration!"

success "Commit initial créé"
echo ""

# Créer la branche develop
info "Création de la branche develop (GitFlow)..."
git checkout -b develop
git checkout main
success "Branche develop créée"
echo ""

# Résumé
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                 ✅ Repository initialisé !                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
success "Git repository configuré avec GitFlow"
echo ""
info "Branches créées:"
echo "  • main    - Production (code stable)"
echo "  • develop - Développement (prochaine version)"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 Prochaines étapes pour publier sur GitHub:"
echo ""
echo "1. Créez un nouveau repository sur GitHub:"
echo "   https://github.com/new"
echo ""
echo "   Nom: voice-to-claude"
echo "   Description: 🎤 Dictée vocale en français pour Claude Code"
echo "   Public ✓"
echo "   ⚠️  N'initialisez PAS avec README/LICENSE/.gitignore"
echo ""
echo "2. Liez votre repo local au repo GitHub:"
echo "   git remote add origin https://github.com/<votre-username>/voice-to-claude.git"
echo ""
echo "3. Poussez les branches:"
echo "   git push -u origin main"
echo "   git push -u origin develop"
echo ""
echo "4. Configurez les protections de branches sur GitHub:"
echo "   Settings > Branches > Add rule"
echo "   - main: Require PR + approvals + CI"
echo "   - develop: Require PR + CI"
echo ""
echo "5. Créez la première release:"
echo "   git tag -a v1.0.0 -m 'Initial release'"
echo "   git push origin v1.0.0"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Documentation GitFlow: GITFLOW.md"
info "Documentation complète: README.md"
echo ""
success "Prêt pour la collaboration ! 🚀"
echo ""
