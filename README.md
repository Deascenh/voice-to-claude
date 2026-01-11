# 🎤 Voice to Claude

<div align="center">

**Parlez à Claude Code comme à un collègue**

*100% offline • 100% gratuit • 100% français*

<br>

[![CI](https://github.com/Deascenh/voice-to-claude/workflows/CI/badge.svg)](https://github.com/Deascenh/voice-to-claude/actions)
[![Python](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

[Quick Start](#-quick-start-2-minutes) • [Démo](#-démo) • [Installation](#-installation) • [Docs](#-documentation)

<br>

```
┌─────────────────────────────────────────────────────────────┐
│  Vous  🗣️  "créer une fonction python qui calcule fibonacci" │
│             ⬇️  stop                                       │
│  Claude 🤖  [Crée la fonction avec tests et documentation]   │
│             ⬇️  continuez à parler...                        │
│  Vous  🗣️  "maintenant optimise-la avec memoization stop" │
│  Claude 🤖  [Optimise et explique]                           │
│             ⬇️  terminé pour terminer                       │
└─────────────────────────────────────────────────────────────┘
```

</div>

---

## 🎯 En deux mots

Conversez avec Claude Code **à la voix**, dans un terminal dédié, sans jamais lâcher votre café ☕

- 💬 **Conversation naturelle** - Parlez, Claude répond, vous répondez... comme un binôme
- 🔒 **100% offline** - Votre voix reste sur votre machine, seul le texte va à Claude
- 🇫🇷 **Français natif** - Reconnaissance vocale optimisée pour le français
- ⌨️ **Clavier actif** - Répondez aux questions interactives de Claude au clavier
- 🎙️ **Toujours à l'écoute** - Parlez naturellement, pas besoin de raccourcis clavier

---

## 🎬 Démo rapide

```bash
$ make run

╔════════════════════════════════════════════════════════╗
║         Voice to Claude - Conversation vocale          ║
╚════════════════════════════════════════════════════════╝

🚀 Lancement de Claude Code...
✅ Claude Code démarré

🎤 Reconnaissance vocale activée
   Dites 'stop' pour envoyer votre message à Claude
   Dites 'terminé' pour terminer la session

⌨️  Clavier actif pour répondre aux questions de Claude

💭 bonjour claude
💭 comment vas-tu stop

📤 Envoi à Claude: bonjour claude comment vas-tu
────────────────────────────────────────────────────────

🤖 Bonjour ! Je vais très bien, merci. Comment puis-je vous aider
   avec votre code aujourd'hui ?

💭 crée moi une fonction de tri rapide en python stop

📤 Envoi à Claude: crée moi une fonction de tri rapide en python
────────────────────────────────────────────────────────

🤖 [Claude crée la fonction...]

💭 terminé
👋 Session terminée
```

---

## ⚡ Quick Start (2 minutes)

```bash
# 1. Clone
git clone https://github.com/Deascenh/voice-to-claude.git
cd voice-to-claude

# 2. Installation automatique (détecte macOS/Linux)
make install-system

# 3. Lancement !
make run
```

**Vous êtes prêt !**
- 🗣️ Parlez naturellement
- ⏸️ Dites **"stop"** pour envoyer votre message
- 🛑 Dites **"terminé"** pour quitter
- ⌨️ Le clavier reste actif si Claude vous pose des questions

> 💡 **Astuce** : Testez votre installation avec `make verify`

---

## 💬 Comment l'utiliser

### Lancement

```bash
make run          # Lance dans un terminal détaché (recommandé)
make run-detached # Alias de make run
make run-direct   # Lance dans le terminal courant
```

### Workflow typique

1. **Lancez** l'application avec `make run`
2. **Parlez** naturellement pour composer votre message
3. **Dites "stop"** pour envoyer le message à Claude
4. **Claude répond** et traite votre demande
5. **Continuez** la conversation ou dites **"terminé"** pour quitter

### Astuces

- ✅ **Articulez "stop"** comme "slou-bi" si pas détecté
- ✅ **Articulez "terminé"** comme "tèr-mi-né"
- ✅ **Petite pause** avant et après les mots magiques
- ✅ **Clavier actif** pour les réponses aux questions de Claude (Oui/Non, choix multiples, etc.)

---

## 📦 Installation

### Prérequis

- 🐍 **Python 3.9+**
- 🍎 **macOS 10.14+** ou 🐧 **Linux**
- 🎤 **Microphone** fonctionnel
- 🤖 **[Claude Code](https://github.com/anthropics/claude-code)** installé

### Installation automatique (recommandée)

```bash
make install-system
```

Le script détecte automatiquement votre système d'exploitation et installe :
- Les dépendances système (PortAudio, etc.)
- Les packages Python
- Le modèle Vosk français

### Installation manuelle

<details>
<summary>Cliquez pour voir les étapes manuelles</summary>

**macOS**
```bash
brew install portaudio
pip install -r requirements.txt

# Télécharger le modèle Vosk
wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
unzip vosk-model-small-fr-0.22.zip
```

**Linux (Ubuntu/Debian)**
```bash
sudo apt-get update
sudo apt-get install portaudio19-dev python3-pyaudio
pip install -r requirements.txt

# Télécharger le modèle Vosk
wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
unzip vosk-model-small-fr-0.22.zip
```

</details>

### Vérification

```bash
make verify
```

---

## ⚙️ Configuration

### Changer les mots magiques

Éditez `src/voice_to_claude/__init__.py` :

```python
DEFAULT_SEND_WORD = "envoyer"  # au lieu de "stop"
DEFAULT_QUIT_WORD = "stop"     # au lieu de "terminé"
```

### Modèle Vosk complet (~1.5GB)

Pour une meilleure précision :

```bash
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

Puis mettez à jour `MODEL_PATH` dans `src/voice_to_claude/voice_session.py`.

---

## 🛠️ Développement

### Setup environnement

```bash
# Créer l'environnement virtuel
make setup-venv

# Installer les dépendances de développement
make install-dev
```

### Tests & Qualité

```bash
make test         # Tests avec coverage
make lint         # Vérification qualité (flake8, mypy)
make format       # Formatage automatique (black)
make quality      # Tous les checks
make ci           # Simuler le CI en local
```

### Standards de qualité

- ✅ **Pytest** avec fixtures et coverage 80%+
- ✅ **Black** pour le formatage
- ✅ **Flake8** pour le linting
- ✅ **Mypy** pour le type checking
- ✅ **CI/CD** multi-OS (Ubuntu/macOS) × Python 3.9-3.12

### Makefile complet

```bash
make help  # Voir toutes les commandes disponibles
```

**Commandes principales :**
- `make run` - Lancer l'application
- `make test` - Tests
- `make format` - Formatter le code
- `make lint` - Vérifier la qualité
- `make clean` - Nettoyer les fichiers temporaires

---

## 🤝 Contribution

Les contributions sont les bienvenues !

```bash
# 1. Fork & clone
git clone https://github.com/Deascenh/voice-to-claude.git
cd voice-to-claude

# 2. Setup environnement
make setup-venv
make install-dev

# 3. Branche feature
git checkout -b feature/ma-super-idee

# 4. Développer + tester
make quality

# 5. Pull Request !
```

**Critères pour une PR acceptée :**
- ✅ Tests passent (`make test`)
- ✅ Code formaté (`make format`)
- ✅ Lint OK (`make lint`)
- ✅ Coverage maintenu (80%+)

---

## 🐛 Dépannage

<details>
<summary><b>Le microphone ne fonctionne pas</b></summary>

**Linux**
```bash
# Tester le micro
arecord -d 3 test.wav && aplay test.wav

# Vérifier les permissions
make verify
```

**macOS**
```
Préférences Système > Sécurité et confidentialité > Microphone
→ Autoriser Terminal ou votre émulateur
```

</details>

<details>
<summary><b>Claude ne se lance pas</b></summary>

```bash
# Vérifier l'installation
claude --version

# Si non installé, suivre :
# https://github.com/anthropics/claude-code
```

</details>

<details>
<summary><b>"stop" ou "terminé" non détecté</b></summary>

- Articulez clairement : **"slou-bi"** ou **"wake-u-teu"**
- Ajoutez une petite pause avant et après
- Parlez à volume normal (pas besoin de crier)
- Vérifiez que le modèle Vosk est bien téléchargé

</details>

<details>
<summary><b>Les tests échouent</b></summary>

```bash
# Installer les dépendances dev
make install-dev

# Vérifier l'installation
make verify

# Relancer les tests
make test
```

</details>

---

## 📚 Documentation

- 📖 [Guide de contribution](docs/CONTRIBUTING.md)
- 🔀 [Workflow GitFlow](GITFLOW.md)
- ⚙️ [CI/CD & GitHub](.github/CI_CD.md)
- 📝 [Changelog](CHANGELOG.md)

---

## 🏗️ Architecture

```
voice-to-claude/
├── src/voice_to_claude/
│   ├── __init__.py          # Configuration globale
│   └── voice_session.py     # Application principale
├── tests/                   # Tests pytest
├── scripts/
│   ├── launch_detached.sh   # Lanceur terminal détaché
│   ├── setup.sh            # Installation système
│   └── verify.sh           # Vérification install
├── docs/                    # Documentation
├── .github/                 # CI/CD workflows
├── Makefile                # Commandes automatisées
├── pyproject.toml          # Configuration Python
└── requirements.txt        # Dépendances

```

**Architecture technique :**
- **PTY (Pseudo-Terminal)** pour interagir avec Claude Code
- **Vosk** pour la reconnaissance vocale offline
- **PyAudio** pour la capture audio
- **Threading** pour la gestion simultanée voix/clavier/sortie

---

## 💬 Support

- 🐛 **Bug ?** → [Ouvrir une issue](https://github.com/Deascenh/voice-to-claude/issues/new)
- 💡 **Idée ?** → [Feature request](https://github.com/Deascenh/voice-to-claude/issues/new)
- 💬 **Question ?** → [Discussions](https://github.com/Deascenh/voice-to-claude/discussions)
- ⭐ **Vous aimez ?** → Star le projet !

---

## 📄 Licence

MIT License - Faites-en ce que vous voulez !

---

## 🙏 Remerciements

- [Vosk](https://alphacephei.com/vosk/) - Reconnaissance vocale offline
- [Claude Code](https://github.com/anthropics/claude-code) - CLI d'Anthropic
- [PyAudio](https://people.csail.mit.edu/hubert/pyaudio/) - Interface audio
- **Vous** - Pour utiliser ce projet ! 🎤

---

<div align="center">

**Fait avec ❤️ et beaucoup de ☕**

[⭐ Star](https://github.com/Deascenh/voice-to-claude) • [🔀 Fork](https://github.com/Deascenh/voice-to-claude/fork) • [🐛 Issues](https://github.com/Deascenh/voice-to-claude/issues)

<sub>Voice to Claude v1.0.0 • Parlez, codez, répétez.</sub>

</div>
