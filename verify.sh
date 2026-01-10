#!/bin/bash
# Voice to Claude - Script de Vérification

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║        Voice to Claude - Vérification du Système          ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

success() { echo -e "${GREEN}✓${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }
warning() { echo -e "${YELLOW}⚠${NC} $1"; }

ERRORS=0
WARNINGS=0

# 1. Python 3
echo "━━━ Python 3 ━━━"
if command -v python3 &> /dev/null; then
    VERSION=$(python3 --version)
    success "Python 3 installé: $VERSION"
else
    error "Python 3 non trouvé"
    ((ERRORS++))
fi
echo ""

# 2. Pip
echo "━━━ Pip ━━━"
if command -v pip3 &> /dev/null; then
    success "pip3 installé"
else
    error "pip3 non trouvé"
    ((ERRORS++))
fi
echo ""

# 3. Packages Python
echo "━━━ Packages Python ━━━"
python3 -c "import vosk" 2>/dev/null && success "vosk installé" || { error "vosk manquant"; ((ERRORS++)); }
python3 -c "import pyaudio" 2>/dev/null && success "pyaudio installé" || { error "pyaudio manquant"; ((ERRORS++)); }
python3 -c "import pynput" 2>/dev/null && success "pynput installé (mode daemon)" || warning "pynput manquant (mode daemon désactivé)"
echo ""

# 4. Modèle Vosk
echo "━━━ Modèle Vosk ━━━"
if [ -d "vosk-model-small-fr-0.22" ]; then
    success "Modèle Vosk présent"
else
    error "Modèle Vosk manquant (vosk-model-small-fr-0.22/)"
    ((ERRORS++))
fi
echo ""

# 5. Outils système
echo "━━━ Outils Système ━━━"
if [[ "$OSTYPE" == "darwin"* ]]; then
    command -v cliclick &> /dev/null && success "cliclick installé" || warning "cliclick manquant (optionnel)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    command -v xdotool &> /dev/null && success "xdotool installé" || warning "xdotool manquant (modes temps réel désactivés)"
fi
echo ""

# 6. Claude Code
echo "━━━ Claude Code ━━━"
if command -v claude &> /dev/null; then
    VERSION=$(claude --version 2>/dev/null || echo "version inconnue")
    success "Claude Code installé: $VERSION"
else
    warning "Claude Code non installé (requis pour le mode session)"
    ((WARNINGS++))
fi
echo ""

# 7. Microphone
echo "━━━ Microphone ━━━"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    python3 -c "import pyaudio; p=pyaudio.PyAudio(); print('Micro par défaut:', p.get_default_input_device_info()['name'])" 2>/dev/null && \
        success "Microphone détecté" || warning "Impossible de détecter le micro"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if command -v arecord &> /dev/null; then
        arecord -l &> /dev/null && success "Microphone détecté" || warning "Aucun microphone trouvé"
    else
        warning "arecord non installé (impossible de tester le micro)"
    fi
fi
echo ""

# 8. Scripts exécutables
echo "━━━ Scripts ━━━"
[ -x "voice_session.py" ] && success "voice_session.py exécutable" || warning "voice_session.py non exécutable"
[ -x "voice_realtime.py" ] && success "voice_realtime.py exécutable" || warning "voice_realtime.py non exécutable"
[ -x "voice_daemon.py" ] && success "voice_daemon.py exécutable" || warning "voice_daemon.py non exécutable"
[ -x "voice_to_claude.py" ] && success "voice_to_claude.py exécutable" || warning "voice_to_claude.py non exécutable"
[ -x "start_session.sh" ] && success "start_session.sh exécutable" || warning "start_session.sh non exécutable"
echo ""

# Résumé
echo "╔═══════════════════════════════════════════════════════════╗"
if [ $ERRORS -eq 0 ]; then
    success "Tout est prêt ! Voice to Claude peut être utilisé."
    echo ""
    echo "Pour commencer:"
    echo "  ./start_session.sh"
else
    error "$ERRORS erreur(s) trouvée(s)"
    echo ""
    echo "Pour corriger, lancez:"
    echo "  ./setup.sh"
fi

if [ $WARNINGS -gt 0 ]; then
    warning "$WARNINGS avertissement(s) - certaines fonctionnalités peuvent être limitées"
fi
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

exit $ERRORS
