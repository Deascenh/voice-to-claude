#!/bin/bash
# Script pour initialiser le repository Git et préparer pour GitHub

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║    Voice to Claude - Initialisation Git Repository       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Vérifier si git est installé
if ! command -v git &> /dev/null; then
    echo "❌ Git n'est pas installé"
    echo "   Installez-le avec: sudo apt install git (Linux) ou brew install git (macOS)"
    exit 1
fi

# Vérifier si c'est déjà un repo git
if [ -d ".git" ]; then
    echo "⚠️  Ce dossier est déjà un repository Git"
    read -p "Voulez-vous réinitialiser ? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Annulé"
        exit 0
    fi
    rm -rf .git
fi

# Initialiser le repo
echo "📦 Initialisation du repository Git..."
git init

# Créer le .gitignore s'il n'existe pas
if [ ! -f ".gitignore" ]; then
    echo "⚠️  .gitignore manquant - création automatique"
    cat > .gitignore << 'EOF'
# Vosk Models
vosk-model-*/
*.zip

# Python
__pycache__/
*.py[cod]
*.so
.Python

# IDE
.idea/
.vscode/
*.swp

# OS
.DS_Store

# Audio test
*.wav

# Old files
*_OLD.md
EOF
fi

# Ajouter tous les fichiers
echo "➕ Ajout des fichiers..."
git add .

# Créer le premier commit
echo "💾 Création du commit initial..."
git commit -m "Initial commit: Voice to Claude v1.0.0

- Mode Session Interactive avec mots magiques (sloubi/wakeuteu)
- Mode Temps Réel pour injection directe
- Mode Daemon avec push-to-talk
- Mode Copier-Coller classique
- Installation universelle Mac/Linux
- Documentation complète
- Scripts de vérification

🎤 Ready to share with the world!"

echo ""
echo "✅ Repository Git initialisé !"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 Prochaines étapes pour publier sur GitHub:"
echo ""
echo "1. Créez un nouveau repository sur GitHub:"
echo "   https://github.com/new"
echo "   Nom suggéré: voice-to-claude"
echo "   Description: 🎤 Dictée vocale en français pour Claude Code - 100% offline"
echo ""
echo "2. Liez votre repo local au repo GitHub:"
echo "   git remote add origin https://github.com/VOTRE-USERNAME/voice-to-claude.git"
echo ""
echo "3. Poussez votre code:"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "4. (Optionnel) Ajoutez des topics sur GitHub:"
echo "   - voice-recognition"
echo "   - claude-code"
echo "   - vosk"
echo "   - python"
echo "   - speech-to-text"
echo "   - offline"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
