#!/bin/bash

# Installation des dépendances pour le daemon de dictée vocale

echo "=== Installation de pynput pour la détection des touches ==="
pip install pynput --break-system-packages

echo ""
echo "=== Vérification ==="
python3 -c "import pynput; print('✅ pynput installé')" 2>/dev/null || echo "❌ Erreur avec pynput"

echo ""
echo "✅ Installation terminée"
echo ""
echo "Lancez le daemon avec: ./voice_daemon.py"
echo "Puis maintenez Ctrl+Space pour dicter dans Claude Code"
