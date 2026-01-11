#!/bin/bash
set -e

# Voice to Claude - Installation Universelle
# Compatible: macOS et Linux

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║        Voice to Claude - Installation Automatique        ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonctions d'affichage
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Détection de l'OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

if [ "$OS" == "unknown" ]; then
    error "Système d'exploitation non supporté: $OSTYPE"
    error "Voice to Claude supporte uniquement macOS et Linux"
    exit 1
fi

info "Système détecté: $OS"
echo ""

# 1. Vérifier Python 3
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Vérification de Python 3..."

if ! command -v python3 &> /dev/null; then
    error "Python 3 n'est pas installé"
    if [ "$OS" == "macos" ]; then
        info "Installez Python 3 avec: brew install python3"
    else
        info "Installez Python 3 avec: sudo apt-get install python3"
    fi
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
success "Python 3 trouvé: $PYTHON_VERSION"
echo ""

# 2. Installer les dépendances système
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Installation des dépendances système..."

if [ "$OS" == "macos" ]; then
    # macOS avec Homebrew
    if ! command -v brew &> /dev/null; then
        error "Homebrew n'est pas installé"
        info "Installez Homebrew depuis: https://brew.sh"
        exit 1
    fi

    info "Installation via Homebrew..."
    brew install portaudio 2>/dev/null || true

    # xdotool n'existe pas nativement sur macOS, on utilise cliclick
    if ! command -v cliclick &> /dev/null; then
        info "Installation de cliclick (équivalent de xdotool pour macOS)..."
        brew install cliclick 2>/dev/null || warning "cliclick n'a pas pu être installé (optionnel)"
    fi

    success "Dépendances système installées"

elif [ "$OS" == "linux" ]; then
    # Linux avec apt
    if ! command -v apt-get &> /dev/null; then
        warning "apt-get non trouvé. Vous devrez installer manuellement:"
        warning "  - portaudio19-dev"
        warning "  - python3-pyaudio"
        warning "  - xdotool (optionnel)"
    else
        info "Installation via apt-get..."
        sudo apt-get update -qq
        sudo apt-get install -y portaudio19-dev python3-pyaudio xdotool 2>/dev/null || {
            warning "Certains paquets n'ont pas pu être installés"
            warning "Continuez l'installation, certaines fonctionnalités pourraient ne pas marcher"
        }
        success "Dépendances système installées"
    fi
fi

echo ""

# 3. Installer les packages Python
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Installation des packages Python..."

# Vérifier si pip est disponible
if ! command -v pip3 &> /dev/null; then
    error "pip3 n'est pas installé"
    exit 1
fi

info "Installation de vosk..."
pip3 install vosk --quiet --break-system-packages 2>/dev/null || \
    pip3 install vosk --quiet --user 2>/dev/null || \
    pip3 install vosk --quiet

info "Installation de pyaudio..."
pip3 install pyaudio --quiet --break-system-packages 2>/dev/null || \
    pip3 install pyaudio --quiet --user 2>/dev/null || \
    pip3 install pyaudio --quiet

success "Packages Python installés"
echo ""

# 4. Télécharger le modèle Vosk (si absent)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Vérification du modèle Vosk..."

MODEL_DIR="vosk-model-small-fr-0.22"
MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip"

if [ -d "$MODEL_DIR" ]; then
    success "Modèle Vosk déjà présent"
else
    info "Téléchargement du modèle Vosk français (≈40 MB)..."
    info "Cela peut prendre quelques minutes..."

    if command -v wget &> /dev/null; then
        wget -q --show-progress "$MODEL_URL" -O vosk-model.zip || {
            error "Échec du téléchargement"
            exit 1
        }
    elif command -v curl &> /dev/null; then
        curl -L --progress-bar "$MODEL_URL" -o vosk-model.zip || {
            error "Échec du téléchargement"
            exit 1
        }
    else
        error "wget ou curl requis pour télécharger le modèle"
        exit 1
    fi

    info "Extraction du modèle..."
    unzip -q vosk-model.zip
    rm vosk-model.zip
    success "Modèle Vosk installé"
fi

echo ""

# 5. Rendre les scripts exécutables
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Configuration des permissions..."

# Scripts Python dans src/voice_to_claude/
chmod +x src/voice_to_claude/voice_to_claude.py 2>/dev/null || true
chmod +x src/voice_to_claude/voice_realtime.py 2>/dev/null || true
chmod +x src/voice_to_claude/voice_daemon.py 2>/dev/null || true
chmod +x src/voice_to_claude/voice_session.py 2>/dev/null || true

# Scripts shell dans scripts/
chmod +x scripts/start_session.sh 2>/dev/null || true
chmod +x scripts/verify.sh 2>/dev/null || true

# Script à la racine
chmod +x init_repo.sh 2>/dev/null || true

success "Permissions configurées"
echo ""

# 6. Installer les dépendances optionnelles pour le mode daemon
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Installation des dépendances optionnelles..."

pip3 install pynput --quiet --break-system-packages 2>/dev/null || \
    pip3 install pynput --quiet --user 2>/dev/null || \
    pip3 install pynput --quiet || \
    warning "pynput n'a pas pu être installé (mode daemon désactivé)"

success "Dépendances optionnelles installées"
echo ""

# 7. Vérifier Claude Code
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Vérification de Claude Code..."

if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "inconnue")
    success "Claude Code trouvé (version: $CLAUDE_VERSION)"
else
    warning "Claude Code n'est pas installé"
    info "Installez-le depuis: https://github.com/anthropics/claude-code"
    info "Voice to Claude fonctionnera une fois Claude installé"
fi

echo ""

# 8. Test rapide
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "Test de l'installation..."

python3 -c "import vosk, pyaudio" 2>/dev/null && {
    success "Imports Python OK"
} || {
    error "Erreur lors du test des imports Python"
    exit 1
}

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                  ✓ Installation terminée !                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
success "Voice to Claude est prêt à l'emploi !"
echo ""
info "Modes disponibles:"
echo "  • Session Interactive (recommandé) : make run-session"
echo "  • Temps Réel                       : make run-realtime"
echo "  • Daemon Push-to-Talk              : make run-daemon"
echo "  • Copier-Coller                    : python3 src/voice_to_claude/voice_to_claude.py"
echo ""
info "Documentation:"
echo "  • Guide rapide    : QUICK_START_SESSION.md"
echo "  • Documentation   : README.md"
echo "  • Mode Session    : SESSION_MODE.md"
echo ""
info "Pour tester:"
echo "  make run-session"
echo ""
