# 🎤 Voice to Claude

<div align="center">

**Dictée vocale en français pour Claude Code - 100% offline et gratuit**

[![Python Version](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](https://github.com)

[Installation](#-installation-rapide) • [Modes d'utilisation](#-modes-dutilisation) • [Documentation](#-documentation) • [Contribuer](#-contribuer)

</div>

---

## ✨ Fonctionnalités

- 🎯 **4 modes d'utilisation** adaptés à tous les workflows
- 🔒 **100% offline** - Aucune donnée envoyée sur Internet
- 🆓 **Gratuit et open source** - Pas de limite d'utilisation
- 🇫🇷 **Optimisé pour le français** - Reconnaissance vocale précise
- ⚡ **Temps réel** - Injection directe dans Claude Code
- 🎙️ **Session continue** - Conversations longues sans relancer
- ⌨️ **Clavier actif** - Répondez aux questions pendant la dictée

## 🚀 Installation rapide

### Installation en une commande

```bash
git clone https://github.com/votre-username/voice-to-claude.git
cd voice-to-claude
./setup.sh
```

Le script `setup.sh` :
- ✅ Détecte votre OS (macOS ou Linux)
- ✅ Installe toutes les dépendances
- ✅ Télécharge le modèle Vosk français (~40 MB)
- ✅ Configure les permissions

### Vérification

```bash
./verify.sh
```

## 🎯 Modes d'utilisation

### 🚀 Mode 1 : Session Interactive (RECOMMANDÉ)

**Conversation continue avec Claude - Le mode le plus avancé**

```bash
./start_session.sh
```

**Comment ça marche :**
1. Lance automatiquement Claude Code
2. Parlez librement - vos mots s'accumulent
3. Dites **"sloubi"** pour envoyer à Claude
4. Claude répond - vous pouvez taper au clavier si besoin
5. Continuez à parler pour la prochaine question
6. Dites **"wakeuteu"** pour terminer

**Parfait pour :** Sessions de travail longues, conversation naturelle avec Claude

📖 [Documentation complète du mode session](SESSION_MODE.md)

---

### ⚡ Mode 2 : Temps Réel

**Injection directe dans le terminal - Simple et rapide**

```bash
./voice_realtime.py
```

**Comment ça marche :**
1. Lancez Claude Code dans un terminal
2. Lancez ce script dans un autre terminal
3. Parlez - le texte est tapé en direct
4. Dites **"stop"** pour terminer
5. Appuyez sur Entrée dans Claude pour envoyer

**Parfait pour :** Prompts longs, dictée simple

---

### 🎮 Mode 3 : Daemon Push-to-Talk

**Activation par touche - Contrôle précis**

```bash
./voice_daemon.py
```

**Comment ça marche :**
1. Lancez le daemon en arrière-plan
2. **Maintenez Ctrl+Space** pour dicter
3. Le texte est injecté en temps réel
4. Relâchez pour arrêter

**Parfait pour :** Dictées courtes et fréquentes, multitâche

---

### 📋 Mode 4 : Copier-Coller

**Révision avant envoi - Sécurisé**

```bash
./voice_to_claude.py
```

**Comment ça marche :**
1. Dictez votre prompt
2. Dites **"envoyer"** pour terminer
3. Le texte est copié dans le presse-papiers
4. Collez avec Ctrl+Shift+V

**Parfait pour :** Vérification avant envoi, commandes critiques

---

## 📊 Comparaison des modes

| Mode | Simplicité | Session continue | Temps réel | Contrôle | Idéal pour |
|------|-----------|------------------|------------|----------|------------|
| **Session Interactive** | ⭐⭐⭐⭐ | ✅ | ✅ | ⭐⭐⭐⭐⭐ | Travail long, workflow fluide |
| **Temps Réel** | ⭐⭐⭐⭐⭐ | ❌ | ✅ | ⭐⭐⭐⭐ | Prompts simples, quotidien |
| **Daemon** | ⭐⭐⭐ | ❌ | ✅ | ⭐⭐⭐⭐⭐ | Dictées fréquentes |
| **Copier-Coller** | ⭐⭐⭐⭐ | ❌ | ❌ | ⭐⭐⭐⭐⭐ | Révision nécessaire |

## 📚 Documentation

- 📖 [Guide de démarrage rapide](QUICK_START_SESSION.md)
- 🎯 [Mode Session Interactive](SESSION_MODE.md)
- 🔧 [Guide de contribution](CONTRIBUTING.md)
- 📝 [Changelog](CHANGELOG.md)

## 🛠️ Prérequis

### Système
- **OS** : macOS 10.14+ ou Linux (Ubuntu 20.04+, Debian 10+, etc.)
- **Python** : 3.8 ou supérieur
- **Claude Code** : Installé et configuré ([Installation](https://github.com/anthropics/claude-code))

### Microphone
- Micro intégré ou externe fonctionnel
- Testé avec : `arecord -d 3 test.wav && aplay test.wav` (Linux)

## 🎨 Exemples d'utilisation

### Exemple 1 : Créer une fonction Python

```
🎤 Vous : "créer une fonction python qui calcule la factorielle d'un nombre sloubi"
📤 Envoi à Claude...
🤖 Claude : [Crée la fonction]

🎤 Vous : "maintenant ajoute des tests unitaires sloubi"
📤 Envoi à Claude...
🤖 Claude : [Ajoute les tests]

🎤 Vous : "wakeuteu"
👋 Fin de session
```

### Exemple 2 : Analyser un fichier

```
🎤 Vous : "lis le fichier main point py et explique ce qu'il fait sloubi"
📤 Envoi à Claude...
🤖 Claude : [Analyse le fichier]
```

## ⚙️ Configuration avancée

### Changer les mots magiques

Éditez `voice_session.py` :
```python
SEND_WORD = "sloubi"      # Mot pour envoyer
QUIT_WORD = "wakeuteu"    # Mot pour quitter
```

### Utiliser le modèle Vosk complet

Pour une meilleure précision (~1.5 GB) :
```bash
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

Puis dans les scripts, changez :
```python
MODEL_PATH = "vosk-model-fr-0.22"
```

### macOS : Installer cliclick

Pour le mode temps réel sur macOS :
```bash
brew install cliclick
```

## 🐛 Dépannage

### Le micro ne fonctionne pas

**Linux :**
```bash
# Lister les micros
arecord -l

# Tester le micro
arecord -d 3 test.wav && aplay test.wav
```

**macOS :**
```bash
# Autoriser l'accès au micro
# Préférences Système > Sécurité > Confidentialité > Microphone
```

### La reconnaissance est imprécise

- Parlez clairement et à rythme normal
- Réduisez le bruit ambiant
- Rapprochez-vous du microphone
- Utilisez le modèle Vosk complet

### Claude ne se lance pas

```bash
# Vérifier l'installation
claude --version

# Réinstaller si nécessaire
# https://github.com/anthropics/claude-code
```

### Les mots magiques ne marchent pas

- Prononcez clairement : **"slou-bi"** et **"wake-u-teu"**
- Ajoutez une petite pause avant/après
- Vérifiez qu'ils sont dans la même phrase que du texte

## 🤝 Contribuer

Les contributions sont les bienvenues ! Consultez [CONTRIBUTING.md](CONTRIBUTING.md) pour :
- 🐛 Signaler un bug
- 💡 Proposer une fonctionnalité
- 🔧 Soumettre une Pull Request

### Idées de contributions

- [ ] Support de la ponctuation vocale
- [ ] Commandes système vocales
- [ ] Interface graphique (GUI)
- [ ] Support multilingue (anglais, espagnol)
- [ ] Export de l'historique
- [ ] Intégration avec d'autres LLM

## 📄 Licence

Ce projet est sous licence MIT. Voir [LICENSE](LICENSE) pour plus de détails.

## 🙏 Remerciements

- [Vosk](https://alphacephei.com/vosk/) - Reconnaissance vocale offline
- [Claude Code](https://github.com/anthropics/claude-code) - CLI officiel d'Anthropic
- [PyAudio](https://people.csail.mit.edu/hubert/pyaudio/) - Interface audio Python

## 📬 Contact

Des questions ? Ouvrez une [issue](https://github.com/votre-username/voice-to-claude/issues) !

---

<div align="center">

**Fait avec ❤️ pour la communauté des développeurs**

[⭐ Star ce projet](https://github.com/votre-username/voice-to-claude) si vous le trouvez utile !

</div>
