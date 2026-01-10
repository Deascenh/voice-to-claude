#!/bin/bash

# Script d'installation des dépendances pour voice_to_claude

echo "=== Installation des dépendances système ==="
sudo apt-get update
sudo apt-get install -y portaudio19-dev python3-pyaudio

echo ""
echo "=== Installation des packages Python ==="
pip install vosk pyaudio --break-system-packages

echo ""
echo "=== Téléchargement du modèle Vosk français (léger - 40MB) ==="
if [ ! -d "vosk-model-small-fr-0.22" ]; then
    wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
    unzip vosk-model-small-fr-0.22.zip
    rm vosk-model-small-fr-0.22.zip
    echo "✅ Modèle téléchargé et décompressé"
else
    echo "✅ Modèle déjà présent"
fi

echo ""
echo "=== Vérification de l'installation ==="
python3 -c "import vosk, pyaudio; print('✅ Tous les packages Python sont installés')" 2>/dev/null || echo "❌ Erreur d'installation des packages Python"

echo ""
echo "=== Installation terminée ==="
echo "Lancez le script avec: ./voice_to_claude.py"
