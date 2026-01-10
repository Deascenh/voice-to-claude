#!/bin/bash

# Script de lancement rapide pour Voice to Claude

echo "╔════════════════════════════════════════╗"
echo "║      Voice to Claude - Launcher        ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "Choisissez votre mode de dictée :"
echo ""
echo "  1) 🎯 Temps Réel (recommandé)"
echo "     Lance la dictée, tape en direct dans Claude Code"
echo ""
echo "  2) 🎮 Daemon Push-to-Talk"
echo "     Maintenir Ctrl+Space pour dicter"
echo ""
echo "  3) 📋 Copier-Coller Classique"
echo "     Copie dans le presse-papiers"
echo ""
echo -n "Votre choix [1-3] : "
read choice

case $choice in
    1)
        echo ""
        echo "🚀 Lancement du mode Temps Réel..."
        echo "   Parlez dès maintenant - le texte sera tapé dans Claude Code"
        echo ""
        ./voice_realtime.py
        ;;
    2)
        echo ""
        echo "🚀 Lancement du Daemon..."
        echo "   Maintenez Ctrl+Space pour dicter"
        echo ""
        ./voice_daemon.py
        ;;
    3)
        echo ""
        echo "🚀 Lancement du mode Copier-Coller..."
        echo "   Dites 'envoyer' pour terminer"
        echo ""
        ./voice_to_claude.py
        ;;
    *)
        echo ""
        echo "❌ Choix invalide"
        exit 1
        ;;
esac
