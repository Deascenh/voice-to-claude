# 🎤 Voice to Claude

<div align="center">

**Dictez à Claude Code comme si vous parliez à un collègue**

*100% offline • 100% gratuit • 100% français*

<br>

[![CI](https://github.com/Deascenh/voice-to-claude/workflows/CI/badge.svg)](https://github.com/Deascenh/voice-to-claude/actions)
[![Python](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

[Quick Start](#-quick-start-2-minutes) • [Démo](#-démo) • [Modes](#-4-modes-dutilisation) • [Docs](#-documentation)

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

Travaillez avec Claude Code **à la voix**, sans jamais lâcher votre café ☕

- 🎙️ **Session continue** - Une vraie conversation, pas du copier-coller
- 🔒 **Offline** - Votre voix reste sur votre machine
- ⚡ **Temps réel** - Vos mots s'affichent instantanément
- 🇫🇷 **Français** - Reconnaissance vocale optimisée

<details>
<summary><b>🎬 Voir une démo rapide (30 secondes)</b></summary>

```bash
$ make run-session

🎤 Reconnaissance vocale activée
   Dites "stop" pour envoyer
   Dites "terminé" pour quitter

💭 lis le fichier main point py
📝 lis le fichier main.py

💭 et explique ce qu'il fait stop
📝 et explique ce qu'il fait

📤 Envoi à Claude...
────────────────────────────────────

🤖 Claude: [Analyse et explique le fichier]

💭 maintenant ajoute des commentaires stop
📤 Envoi à Claude...

🤖 Claude: [Ajoute les commentaires]

💭 terminé
👋 Session terminée
```

</details>

---

## ⚡ Quick Start (2 minutes)

```bash
# 1. Clone
git clone https://github.com/Deascenh/voice-to-claude.git
cd voice-to-claude

# 2. Install (auto-détecte macOS/Linux)
make install-system

# 3. Go!
make run-session
```

**C'est parti !** Parlez, dites **"stop"** pour envoyer, **"terminé"** pour quitter.

> 💡 **Astuce** : Testez avec `make verify` si vous avez un doute

---

## 🎨 4 modes d'utilisation

<table>
<tr>
<td width="50%">

### 🚀 Session Interactive
**La conversation ultime**

```bash
make run-session
```

✨ Micro toujours actif
✨ Conversation fluide
✨ Mots magiques : "stop" / "terminé"

*Parfait pour : brainstorming, refactoring, sessions longues*

</td>
<td width="50%">

### ⚡ Temps Réel
**Simple et direct**

```bash
make run-realtime
```

✨ Injection directe dans le terminal
✨ Dites "stop" pour terminer
✨ Pas de config

*Parfait pour : prompts rapides, dictée simple*

</td>
</tr>
<tr>
<td width="50%">

### 🎮 Daemon (Push-to-Talk)
**Contrôle total**

```bash
make run-daemon
```

✨ **Ctrl+Space** pour dicter
✨ Background mode
✨ Multitâche friendly

*Parfait pour : dictées fréquentes, workflow fluide*

</td>
<td width="50%">

### 📋 Copier-Coller
**Sécurité d'abord**

```bash
make run-clipboard
```

✨ Vérification avant envoi
✨ Dites "envoyer" pour valider
✨ Presse-papiers auto

*Parfait pour : commandes critiques, révision*

</td>
</tr>
</table>

<details>
<summary><b>📊 Comparaison détaillée des modes</b></summary>

| Mode | Session continue | Mots magiques | Complexité | Idéal pour |
|------|------------------|---------------|------------|------------|
| **Session Interactive** | ✅ | stop/terminé | ⭐⭐⭐⭐ | Conversations longues |
| **Temps Réel** | ❌ | stop | ⭐⭐⭐⭐⭐ | Usage quotidien |
| **Daemon** | ❌ | Ctrl+Space | ⭐⭐⭐ | Multitâche |
| **Copier-Coller** | ❌ | envoyer | ⭐⭐⭐⭐ | Révision |

</details>

---

## 🛠️ Pour les devs

> 💡 **Contributeurs** : Consultez [.github/CI_CD.md](.github/CI_CD.md) pour la doc complète des workflows CI/CD

<details open>
<summary><b>🧪 Tests & Qualité</b></summary>

```bash
make test         # Tests avec coverage
make lint         # Code quality
make format       # Auto-format (black)
make quality      # All checks
make ci           # Simuler CI local
```

- ✅ **Pytest** avec fixtures
- ✅ **Coverage** 80%+
- ✅ **CI/CD** multi-OS (Ubuntu/macOS) × Python 3.9-3.12
- ✅ **Pre-commit hooks** (black, flake8, mypy, bandit)

</details>

<details>
<summary><b>🔀 GitFlow Workflow</b></summary>

```bash
# Nouvelle feature
git checkout develop
git checkout -b feature/ma-super-idee

# Coder, tester
make test && make lint

# PR vers develop
git push origin feature/ma-super-idee
```

**Branches :** `main` (prod) • `develop` (dev) • `feature/*` • `hotfix/*`

[Guide complet →](GITFLOW.md)

</details>

<details>
<summary><b>⚙️ Configuration avancée</b></summary>

**Changer les mots magiques :**
```python
# src/voice_to_claude/__init__.py
DEFAULT_SEND_WORD = "envoyer"  # au lieu de "stop"
DEFAULT_QUIT_WORD = "stop"     # au lieu de "terminé"
```

**Modèle Vosk complet (~1.5GB) :**
```bash
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

</details>

---

## 📦 Installation

### Prérequis

<table>
<tr>
<td>🐍 <b>Python 3.9+</b></td>
<td>🍎 <b>macOS 10.14+</b> ou 🐧 <b>Linux</b></td>
</tr>
<tr>
<td>🎤 <b>Microphone</b></td>
<td>🤖 <b><a href="https://github.com/anthropics/claude-code">Claude Code</a></b></td>
</tr>
</table>

### Auto (recommandé)

```bash
make install-system
```

Le Makefile détecte votre OS et installe tout automatiquement.

### Manuel

<details>
<summary>Voir les étapes manuelles</summary>

```bash
# macOS
brew install portaudio
pip install -r requirements.txt

# Linux (Ubuntu/Debian)
sudo apt-get install portaudio19-dev python3-pyaudio
pip install -r requirements.txt

# Modèle Vosk
wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
unzip vosk-model-small-fr-0.22.zip
```

</details>

---

## 📚 Documentation

<table>
<tr>
<td>📖 <a href="docs/QUICK_START_SESSION.md">Quick Start détaillé</a></td>
<td>Guide pas-à-pas pour débuter</td>
</tr>
<tr>
<td>🎯 <a href="docs/SESSION_MODE.md">Modes en détail</a></td>
<td>Documentation technique complète</td>
</tr>
<tr>
<td>🔀 <a href="GITFLOW.md">GitFlow</a></td>
<td>Workflow de contribution</td>
</tr>
<tr>
<td>🤝 <a href="docs/CONTRIBUTING.md">Contributing</a></td>
<td>Comment contribuer</td>
</tr>
<tr>
<td>⚙️ <a href=".github/CI_CD.md">CI/CD & GitHub</a></td>
<td>Configuration des workflows</td>
</tr>
<tr>
<td>📝 <a href="CHANGELOG.md">Changelog</a></td>
<td>Historique des versions</td>
</tr>
<tr>
<td>🚀 <a href="QUICKSTART_COLLAB.md">Publier sur GitHub</a></td>
<td>Guide rapide (5 min)</td>
</tr>
</table>

---

## 🎁 Makefile magique

```bash
make help          # 📖 Toutes les commandes
make test          # 🧪 Tests
make lint          # ✨ Qualité
make format        # 🎨 Format
make clean         # 🧹 Nettoyage
make quality       # ⭐ Tous les checks
make ci            # 🤖 CI local
```

20+ commandes pour tout automatiser. `make help` pour la liste complète.

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Voici comment :

```bash
# 1. Fork & clone
git clone https://github.com/Deascenh/voice-to-claude.git
cd voice-to-claude

# 2. Setup environnement (détection auto du venv!)
make setup-venv
make install-dev

# 3. Branche feature
git checkout -b feature/awesome-stuff

# 4. Code + test
make quality

# 5. PR!
```

**Standards :**
- ✅ Tests passent (`make test`)
- ✅ Code formaté (`make format`)
- ✅ Lint OK (`make lint`)
- ✅ Coverage maintenu

**Guides développeurs :**
- [Démarrage rapide (débutants Python) →](docs/QUICKSTART_DEV.md)
- [Guide complet de contribution →](docs/CONTRIBUTING.md)

---

## 🐛 Problèmes courants

<details>
<summary><b>Le micro ne fonctionne pas</b></summary>

```bash
# Tester
arecord -d 3 test.wav && aplay test.wav  # Linux
# Sur macOS : Préférences > Sécurité > Microphone

# Vérifier
make verify
```

</details>

<details>
<summary><b>Claude ne se lance pas</b></summary>

```bash
# Vérifier installation
claude --version

# Réinstaller si besoin
# https://github.com/anthropics/claude-code
```

</details>

<details>
<summary><b>Mots magiques non détectés</b></summary>

- Prononcez **"slou-bi"** (articulez bien)
- Prononcez **"wake-u-teu"** (séparez les syllabes)
- Ajoutez une petite pause avant/après

</details>

<details>
<summary><b>Les tests échouent</b></summary>

```bash
# Installer les dépendances dev
make install-dev

# Vérifier
make verify

# Relancer
make test
```

</details>

---

## 🏗️ Structure du projet

```
voice-to-claude/
├── 🎯 src/voice_to_claude/    # Code source
├── 🧪 tests/                  # Tests (pytest)
├── 📚 docs/                   # Documentation
├── 🛠️ scripts/                # Installation
├── ⚙️ .github/                # CI/CD
├── 📦 pyproject.toml          # Config Python
├── 🎨 Makefile                # Commandes
└── 📖 README.md               # Vous êtes ici!
```

---

## 💬 Support & Communauté

- 🐛 **Bug ?** → [Ouvrir une issue](https://github.com/Deascenh/voice-to-claude/issues/new?template=bug_report.md)
- 💡 **Idée ?** → [Feature request](https://github.com/Deascenh/voice-to-claude/issues/new?template=feature_request.md)
- 💬 **Question ?** → [Discussions](https://github.com/Deascenh/voice-to-claude/discussions)
- ⭐ **Vous aimez ?** → Star le projet!

---

## 📄 Licence

MIT License - Faites-en ce que vous voulez !

---

## 🙏 Merci à

- [Vosk](https://alphacephei.com/vosk/) - Reconnaissance vocale offline
- [Claude Code](https://github.com/anthropics/claude-code) - CLI d'Anthropic
- [PyAudio](https://people.csail.mit.edu/hubert/pyaudio/) - Interface audio
- **Vous** - Pour utiliser ce projet ! 🎤

---

<div align="center">

**Fait avec ❤️ et beaucoup de ☕**

[⭐ Star](https://github.com/Deascenh/voice-to-claude) • [🔀 Fork](https://github.com/Deascenh/voice-to-claude/fork) • [🐛 Issues](https://github.com/Deascenh/voice-to-claude/issues)

<sub>Voice to Claude v1.0.0 • Développeurs heureux depuis 2026</sub>

</div>
