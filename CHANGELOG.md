# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [1.0.0] - 2026-01-11

### Ajouté
- **Conversation vocale avec Claude Code**
  - Reconnaissance vocale permanente en arrière-plan (Vosk offline)
  - Lancement automatique dans un terminal dédié
  - Mots magiques : "stop" (envoyer) et "terminé" (quitter)
  - Clavier actif pour répondre aux questions interactives de Claude
  - Architecture multi-thread (voix + clavier + sortie PTY simultanés)
  - Communication bidirectionnelle via pseudo-terminal (PTY)
  - Interface utilisateur épurée et intuitive

### Technique
- Interaction avec Claude Code via PTY (Pseudo-Terminal)
- Simulation de frappe clavier réaliste (caractère par caractère)
- Gestion correcte de l'envoi avec `\r\n` + `tcdrain()` pour la compatibilité
- Threading pour la gestion simultanée des flux voix/clavier/sortie

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
- Amélioration de la détection des mots magiques
- Support de la ponctuation vocale
- Commandes vocales pour contrôler la session
- Package PyPI pour installation simplifiée (`pip install voice-to-claude`)

### [1.2.0] - À venir
- Support multilingue (anglais, espagnol, allemand)
- Modèles Vosk alternatifs et sélection automatique
- Export de l'historique des conversations

---

## Légende

- **Ajouté** : Nouvelles fonctionnalités
- **Modifié** : Changements dans les fonctionnalités existantes
- **Déprécié** : Fonctionnalités bientôt supprimées
- **Supprimé** : Fonctionnalités supprimées
- **Corrigé** : Corrections de bugs
- **Sécurité** : Correctifs de sécurité
