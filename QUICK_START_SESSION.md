# Guide de Démarrage Rapide - Session Interactive

## 🚀 En 3 étapes

### 1. Vérifier les prérequis

```bash
# Vérifier que tout est installé
python3 -c "import vosk, pyaudio" && echo "✅ Dépendances OK" || echo "❌ Installez les dépendances"
which claude && echo "✅ Claude OK" || echo "❌ Installez Claude Code"
ls vosk-model-small-fr-0.22 && echo "✅ Modèle OK" || echo "❌ Téléchargez le modèle"
```

### 2. Lancer la session

```bash
./start_session.sh
```

### 3. Utiliser la session

1. **Parlez** - vos mots s'accumulent dans le buffer
2. **Dites "sloubi"** - envoie le buffer à Claude
3. **Claude répond** - utilisez le clavier si nécessaire
4. **Continuez à parler** - pour la prochaine requête
5. **Dites "wakeuteu"** - pour terminer

---

## 📖 Exemple de session typique

### Scénario : Créer un script Python

```
🎤 [Vous commencez à parler]
💭 "créer un script python"
📝 créer un script python

💭 "qui liste tous les fichiers"
📝 qui liste tous les fichiers

💭 "dans un dossier sloubi"
📝 dans un dossier

📤 Envoi à Claude: créer un script python qui liste tous les fichiers dans un dossier
────────────────────────────────────────────────────────────

[Claude Code crée le script...]

💭 "maintenant ajoute"
📝 maintenant ajoute

💭 "un filtre par extension sloubi"
📝 un filtre par extension

📤 Envoi à Claude: maintenant ajoute un filtre par extension
────────────────────────────────────────────────────────────

[Claude modifie le script...]

[Vous êtes satisfait]
💭 "wakeuteu"
🛑 Mot magique 'wakeuteu' détecté - Fin de session
```

---

## 🎯 Conseils d'utilisation

### Prononciation des mots magiques

- **sloubi** : Prononcez "slou-bi" (comme "su-lou-bi" mais rapide)
- **wakeuteu** : Prononcez "wake-u-teu" (articulez bien chaque syllabe)

### Quand utiliser le clavier

Claude peut vous poser des questions avec des choix :

```
? Do you want to create a new file? (Yes/No)
```

À ce moment :
- Le micro continue d'écouter (en arrière-plan)
- Tapez votre réponse au clavier : `Yes` + Entrée
- La session continue normalement

### Gérer les erreurs de transcription

Si Vosk transcrit mal un mot :
- Continuez à parler, reformulez si nécessaire
- Ou dites "sloubi" pour envoyer ce que vous avez
- Puis corriger au prochain message vocal

### Organiser vos requêtes

**Bonne pratique** : Une idée = un message

```
✅ BIEN :
"créer une fonction de calcul sloubi"
[Claude répond]
"ajouter des tests unitaires sloubi"
[Claude répond]

❌ MOINS BIEN :
"créer une fonction de calcul et ajouter des tests unitaires sloubi"
[Message trop long, moins clair]
```

---

## ⚠️ Dépannage rapide

### Le micro ne capte rien

```bash
# Tester le micro
arecord -d 3 test.wav && aplay test.wav && rm test.wav
```

### Claude ne se lance pas

```bash
# Vérifier Claude
claude --version

# Lancer manuellement pour tester
claude
```

### Les mots magiques ne marchent pas

- Prononcez plus clairement
- Ajoutez une petite pause avant et après
- Vérifiez qu'ils sont bien dans la même phrase que du texte

### La session se bloque

- Utilisez `Ctrl+C` pour arrêter proprement
- Relancez avec `./start_session.sh`

---

## 🔧 Personnalisation

### Changer les mots magiques

Éditez `voice_session.py` :

```python
SEND_WORD = "sloubi"      # Changez en "envoyer", "ok", etc.
QUIT_WORD = "wakeuteu"    # Changez en "stop", "quitter", etc.
```

### Utiliser le modèle complet

Pour une meilleure précision :

```bash
# Télécharger le modèle complet (~1.5GB)
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

Puis dans `voice_session.py` :
```python
MODEL_PATH = "vosk-model-fr-0.22"
```

---

## 💡 Astuces avancées

### Sessions longues

Pour des sessions de travail de plusieurs heures :
- Faites des pauses régulières
- Testez que le micro fonctionne toujours de temps en temps
- Redémarrez si vous observez des ralentissements

### Dictées complexes

Pour du code ou des commandes techniques :
- Dictez lentement et clairement
- Utilisez des phrases courtes
- Envoyez régulièrement avec "sloubi"
- Profitez de la session continue pour affiner progressivement

### Workflow multi-terminal

Configuration optimale :

```
┌─────────────────────┬─────────────────────┐
│  Terminal 1         │  Terminal 2         │
│  (Session Voice)    │  (Code Editor)      │
│                     │                     │
│  🎤 Reconnaissance  │  📝 Votre code      │
│  💬 Claude répond   │                     │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

---

## 📚 Plus d'informations

- Documentation complète : [SESSION_MODE.md](SESSION_MODE.md)
- Guide général : [README.md](README.md)
- Code source : [voice_session.py](voice_session.py)

---

**Prêt à commencer ?**

```bash
./start_session.sh
```

Bonne session ! 🎤
