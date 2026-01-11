#!/bin/bash
# Lanceur pour Voice to Claude - Session Interactive

echo "╔════════════════════════════════════════════════════════╗"
echo "║  Voice to Claude - Session Interactive Continue       ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Vérifier que le modèle existe
if [ ! -d "vosk-model-small-fr-0.22" ]; then
    echo "❌ Modèle Vosk non trouvé !"
    echo "   Téléchargez-le depuis: https://alphacephei.com/vosk/models"
    echo "   Et extrayez-le dans ce dossier"
    exit 1
fi

# Vérifier les dépendances
python3 -c "import vosk, pyaudio" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "❌ Dépendances manquantes !"
    echo "   Installez-les avec: pip3 install vosk pyaudio"
    exit 1
fi

# Vérifier que Claude est installé
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code n'est pas installé !"
    echo "   Installez-le depuis: https://github.com/anthropics/claude-code"
    exit 1
fi

echo "✅ Tous les prérequis sont satisfaits"
echo ""
echo "📖 Guide rapide:"
echo "   • Parlez pour accumuler du texte dans le buffer"
echo "   • Dites 'stop' pour envoyer votre message à Claude"
echo "   • Dites 'terminé' pour terminer la session"
echo "   • Utilisez le clavier pour répondre aux questions de Claude"
echo ""
echo "Appuyez sur Entrée pour démarrer la session..."
read

# Lancer le script
python3 src/voice_to_claude/voice_session.py
