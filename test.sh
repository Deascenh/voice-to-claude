#!/bin/bash

# Script de test pour vérifier que tout est bien installé

echo "╔════════════════════════════════════════╗"
echo "║   Voice to Claude - Test Installation ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0

echo "1. Vérification des dépendances système..."

# xdotool
if command -v xdotool &> /dev/null; then
    echo -e "   ${GREEN}✓${NC} xdotool installé"
else
    echo -e "   ${RED}✗${NC} xdotool manquant"
    ((errors++))
fi

# xclip
if command -v xclip &> /dev/null; then
    echo -e "   ${GREEN}✓${NC} xclip installé"
else
    echo -e "   ${YELLOW}⚠${NC} xclip manquant (optionnel)"
fi

echo ""
echo "2. Vérification des packages Python..."

# vosk
if python3 -c "import vosk" 2>/dev/null; then
    echo -e "   ${GREEN}✓${NC} vosk installé"
else
    echo -e "   ${RED}✗${NC} vosk manquant"
    ((errors++))
fi

# pyaudio
if python3 -c "import pyaudio" 2>/dev/null; then
    echo -e "   ${GREEN}✓${NC} pyaudio installé"
else
    echo -e "   ${RED}✗${NC} pyaudio manquant"
    ((errors++))
fi

# pynput (optionnel)
if python3 -c "import pynput" 2>/dev/null; then
    echo -e "   ${GREEN}✓${NC} pynput installé (pour daemon)"
else
    echo -e "   ${YELLOW}⚠${NC} pynput manquant (uniquement pour mode daemon)"
fi

echo ""
echo "3. Vérification du modèle Vosk..."

if [ -d "vosk-model-small-fr-0.22" ]; then
    echo -e "   ${GREEN}✓${NC} Modèle français léger présent"
elif [ -d "vosk-model-fr-0.22" ]; then
    echo -e "   ${GREEN}✓${NC} Modèle français complet présent"
else
    echo -e "   ${RED}✗${NC} Aucun modèle Vosk trouvé"
    ((errors++))
fi

echo ""
echo "4. Vérification des microphones..."

mic_count=$(python3 -c "import pyaudio; p=pyaudio.PyAudio(); count=sum(1 for i in range(p.get_device_count()) if p.get_device_info_by_index(i)['maxInputChannels']>0); p.terminate(); print(count)" 2>/dev/null)

if [ "$mic_count" -gt 0 ]; then
    echo -e "   ${GREEN}✓${NC} $mic_count microphone(s) détecté(s)"
else
    echo -e "   ${RED}✗${NC} Aucun microphone détecté"
    ((errors++))
fi

echo ""
echo "5. Vérification des scripts..."

scripts=("voice_realtime.py" "voice_daemon.py" "voice_to_claude.py")
for script in "${scripts[@]}"; do
    if [ -x "$script" ]; then
        echo -e "   ${GREEN}✓${NC} $script (exécutable)"
    elif [ -f "$script" ]; then
        echo -e "   ${YELLOW}⚠${NC} $script (non exécutable)"
        chmod +x "$script"
        echo -e "      → Rendu exécutable"
    else
        echo -e "   ${RED}✗${NC} $script manquant"
        ((errors++))
    fi
done

echo ""
echo "════════════════════════════════════════"

if [ $errors -eq 0 ]; then
    echo -e "${GREEN}✓ Installation complète et fonctionnelle !${NC}"
    echo ""
    echo "Vous pouvez maintenant :"
    echo "  • Lancer ./start.sh pour choisir un mode"
    echo "  • Ou directement ./voice_realtime.py (recommandé)"
    echo ""
else
    echo -e "${RED}✗ $errors erreur(s) détectée(s)${NC}"
    echo ""
    echo "Pour corriger :"
    echo "  • Lancez ./install.sh pour les dépendances de base"
    echo "  • Lancez ./install_daemon.sh pour le mode daemon"
    echo ""
fi

exit $errors
