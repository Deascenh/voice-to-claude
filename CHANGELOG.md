# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [1.0.0] - 2026-01-11

### Ajouté
- **Mode Session Interactive** : Conversation continue avec Claude Code
  - Reconnaissance vocale permanente en arrière-plan
  - Mots magiques : "stop" (envoyer) et "terminé" (quitter)
  - Clavier actif pour répondre aux questions de Claude
  - Architecture multi-thread pour une fluidité maximale
- **Mode Temps Réel** : Injection directe du texte dans le terminal
  - Transcription en temps réel
  - Mot d'arrêt configurable
- **Mode Daemon** : Push-to-talk avec Ctrl+Space
  - Activation par combinaison de touches
  - Idéal pour dictées courtes et fréquentes
- **Mode Copier-Coller** : Révision avant envoi
  - Transcription dans le presse-papiers
  - Contrôle complet avant envoi

### Installation et Configuration
- Script d'installation universel (`setup.sh`)
  - Support macOS et Linux
  - Détection automatique de l'OS
  - Installation des dépendances
  - Téléchargement du modèle Vosk
- Script de vérification (`verify.sh`)
  - Diagnostic complet du système
  - Vérification de toutes les dépendances
  - Test du microphone

### Documentation
- README complet avec comparaison des modes
- Guide de démarrage rapide (QUICK_START_SESSION.md)
- Documentation technique du mode session (SESSION_MODE.md)
- Guide de contribution (CONTRIBUTING.md)
- Licence MIT

### Infrastructure
- `.gitignore` optimisé pour Python
- Structure de projet propre et organisée
- Scripts de lancement pour chaque mode

## Versions futures

### [1.1.0] - À venir
- Support de la ponctuation vocale
- Commandes vocales système
- Export de l'historique des sessions

### [1.2.0] - À venir
- Interface graphique optionnelle
- Support multilingue (anglais, espagnol)
- Package PyPI pour installation simple

---

## Légende

- **Ajouté** : Nouvelles fonctionnalités
- **Modifié** : Changements dans les fonctionnalités existantes
- **Déprécié** : Fonctionnalités bientôt supprimées
- **Supprimé** : Fonctionnalités supprimées
- **Corrigé** : Corrections de bugs
- **Sécurité** : Correctifs de sécurité
