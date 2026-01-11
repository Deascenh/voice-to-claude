#!/bin/bash
# Voice to Claude - Lanceur en terminal détaché

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Voice to Claude - Conversation vocale          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Chemin vers le script Python
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PYTHON_SCRIPT="$PROJECT_DIR/src/voice_to_claude/voice_session.py"

# Vérifier que le script existe
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo -e "${RED}❌ Erreur: Script non trouvé: $PYTHON_SCRIPT${NC}"
    exit 1
fi

# Fonction pour détecter le terminal disponible
detect_terminal() {
    if command -v gnome-terminal &> /dev/null; then
        echo "gnome-terminal"
    elif command -v konsole &> /dev/null; then
        echo "konsole"
    elif command -v xfce4-terminal &> /dev/null; then
        echo "xfce4-terminal"
    elif command -v xterm &> /dev/null; then
        echo "xterm"
    elif command -v alacritty &> /dev/null; then
        echo "alacritty"
    elif command -v kitty &> /dev/null; then
        echo "kitty"
    elif command -v terminator &> /dev/null; then
        echo "terminator"
    else
        echo "none"
    fi
}

# Détecter le terminal
TERMINAL=$(detect_terminal)

if [ "$TERMINAL" = "none" ]; then
    echo -e "${RED}❌ Aucun émulateur de terminal détecté${NC}"
    echo "   Installez l'un des suivants: gnome-terminal, konsole, xterm, alacritty, kitty"
    exit 1
fi

echo -e "${GREEN}✅ Terminal détecté: $TERMINAL${NC}"
echo ""

# Lancer le script dans le terminal détecté
case "$TERMINAL" in
    gnome-terminal)
        gnome-terminal --title="Voice to Claude" -- bash -c "cd '$PROJECT_DIR' && python3 '$PYTHON_SCRIPT'; exec bash"
        ;;
    konsole)
        konsole --title "Voice to Claude" -e bash -c "cd '$PROJECT_DIR' && python3 '$PYTHON_SCRIPT'; exec bash" &
        ;;
    xfce4-terminal)
        xfce4-terminal --title="Voice to Claude" --command="bash -c 'cd \"$PROJECT_DIR\" && python3 \"$PYTHON_SCRIPT\"; exec bash'" &
        ;;
    xterm)
        xterm -title "Voice to Claude" -e bash -c "cd '$PROJECT_DIR' && python3 '$PYTHON_SCRIPT'; exec bash" &
        ;;
    alacritty)
        alacritty --title "Voice to Claude" -e bash -c "cd '$PROJECT_DIR' && python3 '$PYTHON_SCRIPT'; exec bash" &
        ;;
    kitty)
        kitty --title "Voice to Claude" bash -c "cd '$PROJECT_DIR' && python3 '$PYTHON_SCRIPT'; exec bash" &
        ;;
    terminator)
        terminator --title="Voice to Claude" -e "bash -c 'cd \"$PROJECT_DIR\" && python3 \"$PYTHON_SCRIPT\"; exec bash'" &
        ;;
esac

echo -e "${GREEN}✅ Voice to Claude lancé dans un terminal dédié${NC}"
echo ""
echo -e "${BLUE}💬 Comment l'utiliser :${NC}"
echo "   • Parlez naturellement pour composer votre message"
echo "   • Dites 'stop' pour envoyer votre message à Claude"
echo "   • Dites 'terminé' pour quitter la session"
echo "   • Le clavier reste actif pour les réponses interactives"
echo ""
