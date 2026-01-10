# Voice to Claude

Système de dictée vocale en français pour Claude Code utilisant Vosk (reconnaissance vocale offline).

## Avantages

- Fonctionne **entièrement hors ligne**
- Gratuit et open source
- Bonne précision pour le français
- **Injection directe en temps réel** dans Claude Code
- Léger et rapide
- Aucune limite d'utilisation

## Installation

### Installation automatique (recommandé)

```bash
./install.sh
```

Ce script installe automatiquement :
- Les dépendances système (portaudio19-dev)
- Les packages Python (vosk, pyaudio)
- Le modèle Vosk français léger (~40MB)

### Installation manuelle

```bash
# 1. Dépendances système
sudo apt-get update
sudo apt-get install portaudio19-dev python3-pyaudio xdotool

# 2. Packages Python
pip install vosk pyaudio --break-system-packages

# 3. Modèle Vosk
wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
unzip vosk-model-small-fr-0.22.zip
```

### Installation du mode daemon (optionnel)

Pour utiliser le mode push-to-talk :

```bash
./install_daemon.sh
```

Cela installe `pynput` pour la détection des touches clavier.

## Modes d'utilisation

### 🚀 Mode 1 : Session Interactive Continue (NOUVEAU - RECOMMANDÉ)

**Le mode le plus avancé : conversation continue avec Claude Code**

```bash
./start_session.sh
```

**Fonctionnement :**
1. Lance automatiquement Claude Code en session interactive
2. La reconnaissance vocale écoute en permanence en arrière-plan
3. Parlez librement - vos paroles s'accumulent dans un buffer
4. Dites **"sloubi"** pour envoyer le buffer à Claude
5. Claude répond - vous pouvez répondre au clavier si nécessaire
6. Continuez à parler pour la prochaine requête
7. Dites **"wakeuteu"** pour terminer la session

**Avantages :**
- Session continue sans relancer
- Conversation naturelle avec Claude
- Micro actif en permanence
- Clavier disponible pour les réponses (Yes/No, choix)
- Véritable interaction en temps réel
- Mots magiques pour le contrôle

**Documentation complète :** Voir [SESSION_MODE.md](SESSION_MODE.md)

---

### 🎯 Mode 2 : Temps Réel Simplifié

**Le plus simple et le plus efficace pour une utilisation quotidienne**

```bash
./voice_realtime.py
```

**Fonctionnement :**
1. Lancez Claude Code dans votre terminal
2. Dans un autre terminal, lancez `./voice_realtime.py`
3. Commencez à parler immédiatement
4. Chaque mot est transcrit et tapé en direct dans Claude Code
5. Dites "**stop**" pour terminer (ou Ctrl+C)

**Avantages :**
- Pas de manipulation complexe
- Feedback visuel immédiat (vous voyez ce qui est tapé)
- Correction possible avant envoi
- Simple à utiliser

**Exemple d'utilisation :**
```
$ ./voice_realtime.py
🎤 Dictée en temps réel activée
   Parlez maintenant - le texte sera tapé en direct dans Claude Code
   Dites 'stop' pour terminer

🔴 ENREGISTREMENT EN COURS...

📝 créer une fonction python
📝 qui calcule la factorielle
📝 d'un nombre
📝 stop

✅ Dictée terminée
```

Le texte "créer une fonction python qui calcule la factorielle d'un nombre" est maintenant dans votre terminal Claude Code, prêt à être envoyé avec Entrée.

---

### 🎮 Mode 3 : Daemon Push-to-Talk (AVANCÉ)

**Pour une utilisation "mains libres" avec activation par touche**

```bash
./voice_daemon.py
```

**Fonctionnement :**
1. Lancez le daemon en arrière-plan
2. Lancez Claude Code
3. **Maintenez Ctrl+Space** pour commencer à dicter
4. Parlez pendant que vous maintenez la touche
5. Relâchez pour arrêter l'injection

**Avantages :**
- Contrôle précis du moment de dictée
- Pas de mot d'arrêt à prononcer
- Idéal pour des dictées courtes et fréquentes
- Daemon reste actif (pas besoin de relancer)

**Configuration :**
Vous pouvez changer la combinaison de touches dans `voice_daemon.py` :
```python
ACTIVATION_KEY = Key.space     # Touche principale
MODIFIER_KEY = Key.ctrl_l      # Modificateur (Ctrl, Alt, etc.)
```

---

### 📋 Mode 4 : Copier-Coller Classique

**Pour vérifier le texte avant de l'envoyer**

```bash
./voice_to_claude.py
```

**Fonctionnement :**
1. Lancez le script
2. Dictez votre prompt
3. Dites "**envoyer**" pour terminer
4. Le texte est copié dans le presse-papiers
5. Collez avec Ctrl+Shift+V dans Claude Code

**Avantages :**
- Révision du texte avant envoi
- Pas d'injection automatique
- Plus sûr pour les commandes critiques

---

## Comparaison des modes

| Mode | Simplicité | Session continue | Temps réel | Contrôle | Cas d'usage |
|------|-----------|------------------|------------|----------|-------------|
| **Session Interactive** | ⭐⭐⭐⭐ | ✅ Oui | ✅ Oui | ⭐⭐⭐⭐⭐ | Conversations longues, workflow fluide |
| **Temps Réel** | ⭐⭐⭐⭐⭐ | ❌ Non | ✅ Oui | ⭐⭐⭐⭐ | Usage quotidien, prompts longs |
| **Daemon** | ⭐⭐⭐ | ❌ Non | ✅ Oui | ⭐⭐⭐⭐⭐ | Dictées fréquentes, multitâche |
| **Copier-Coller** | ⭐⭐⭐⭐ | ❌ Non | ❌ Non | ⭐⭐⭐⭐⭐ | Révision avant envoi |

## Workflow recommandé

### Pour une utilisation optimale avec Claude Code :

1. **Ouvrez deux terminaux côte à côte** :
   - Terminal 1 : Claude Code (`claude code`)
   - Terminal 2 : Script de dictée (`./voice_realtime.py`)

2. **Dictez votre prompt** dans le terminal 2

3. **Le texte s'affiche en temps réel** dans Claude Code (terminal 1)

4. **Appuyez sur Entrée** pour envoyer à Claude

5. **Relancez le script** quand vous voulez dicter à nouveau

## Configuration

### Changer le modèle Vosk

Pour plus de précision, téléchargez le modèle complet :

```bash
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

Puis modifiez dans les scripts :
```python
MODEL_PATH = "vosk-model-fr-0.22"  # au lieu de vosk-model-small-fr-0.22
```

### Personnaliser les mots de contrôle

Dans `voice_realtime.py` :
```python
STOP_WORD = "stop"  # Changez pour "terminé", "fini", etc.
```

Dans `voice_to_claude.py` :
```python
STOP_WORD = "envoyer"  # Changez pour "ok", "valider", etc.
```

## Dépannage

### Le texte ne s'injecte pas

1. Vérifiez que xdotool est installé : `which xdotool`
2. Assurez-vous que Claude Code est bien dans le terminal actif
3. Essayez de cliquer dans le terminal Claude Code avant de dicter

### Mauvaise reconnaissance

- Parlez clairement et à un rythme normal
- Réduisez le bruit ambiant
- Rapprochez-vous du microphone
- Utilisez le modèle complet pour plus de précision

### Erreur "Modèle non trouvé"

```bash
ls -la vosk-model-*  # Vérifier la présence du modèle
```

Le modèle doit être dans le même répertoire que les scripts.

### Problèmes audio

```bash
arecord -l  # Lister les microphones
```

Si plusieurs microphones, PyAudio utilisera le défaut du système.

## Astuces

### Dicter de la ponctuation

Le modèle Vosk ne gère pas bien la ponctuation vocale. Deux solutions :

1. **Ajoutez la ponctuation après** en mode texte
2. **Utilisez des raccourcis** : dictez "virgule", "point", etc. et remplacez ensuite

### Dictées longues

Pour des prompts très longs :
- Faites des pauses entre les phrases (le modèle transcrit mieux)
- Utilisez le mode temps réel pour voir ce qui est transcrit
- Corrigez au fur et à mesure si nécessaire

### Commandes vocales répétitives

Si vous dictez souvent les mêmes choses, créez des alias :
```bash
alias vcreate="./voice_realtime.py"
alias vdaemon="./voice_daemon.py"
```

## Architecture des scripts

```
voice_to_claude/
├── voice_session.py        # Mode session interactive continue ⭐⭐⭐
├── voice_realtime.py       # Mode temps réel simplifié ⭐
├── voice_daemon.py         # Mode daemon push-to-talk
├── voice_to_claude.py      # Mode copier-coller classique
├── start_session.sh        # Lanceur session interactive
├── install.sh              # Installation de base
├── install_daemon.sh       # Installation daemon
├── SESSION_MODE.md         # Documentation session interactive
└── vosk-model-small-fr-0.22/  # Modèle de reconnaissance
```

## Ressources

- [Site officiel Vosk](https://alphacephei.com/vosk/)
- [Modèles Vosk](https://alphacephei.com/vosk/models)
- [Documentation PyAudio](https://people.csail.mit.edu/hubert/pyaudio/docs/)
- [Documentation xdotool](https://github.com/jordansissel/xdotool)

## Contribution

Des idées d'amélioration :
- [ ] Support de la ponctuation vocale
- [ ] Détection automatique du terminal Claude Code
- [ ] Interface graphique simple
- [ ] Support de plusieurs langues
- [ ] Commandes vocales spéciales (annuler, recommencer, etc.)
