# Voice to Claude - Mode Session Interactive

## Vue d'ensemble

Le mode **Session Interactive** crée une véritable conversation continue avec Claude Code en combinant reconnaissance vocale et interaction clavier.

### Caractéristiques principales

- **Session continue** : Claude Code reste actif pendant toute la durée de la session
- **Reconnaissance vocale permanente** : Le microphone écoute en continu en arrière-plan
- **Buffer vocal** : Vos paroles s'accumulent jusqu'à ce que vous décidiez de les envoyer
- **Mots magiques** :
  - `stop` : Envoie votre message accumulé à Claude
  - `terminé` : Termine la session
- **Clavier actif** : Vous pouvez taper pour répondre aux questions de Claude (Yes/No, choix, etc.)
- **Multi-thread** : Tout fonctionne en parallèle sans blocage

## Installation

### Installation rapide (recommandée)

```bash
make install-system
```

Cette commande installe automatiquement toutes les dépendances système et Python.

### Installation manuelle

Si vous préférez installer manuellement :

1. **Python 3.9+** avec les dépendances :
   ```bash
   make install  # ou : pip install -r requirements.txt
   ```

2. **Modèle Vosk français** :
   ```bash
   wget https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip
   unzip vosk-model-small-fr-0.22.zip
   ```

3. **Claude Code** installé et configuré :
   ```bash
   # Vérifiez l'installation
   claude --version
   ```

## Utilisation

### Démarrage rapide

```bash
make run-session
```

### Flux de travail typique

1. **Lancez la session** :
   ```bash
   make run-session
   ```

2. **Parlez votre demande** :
   - Le texte s'accumule dans un buffer
   - Vous voyez la transcription en temps réel
   - Continuez à parler autant que nécessaire

3. **Envoyez à Claude** :
   - Dites **"stop"** pour envoyer le buffer à Claude
   - Le texte est transmis et le buffer est vidé

4. **Claude répond** :
   - La réponse s'affiche en temps réel
   - Si Claude pose une question, répondez au clavier
   - Le micro continue d'écouter en arrière-plan

5. **Continuez la conversation** :
   - Parlez une nouvelle demande
   - Dites à nouveau **"stop"** pour l'envoyer
   - Répétez autant que nécessaire

6. **Terminez la session** :
   - Dites **"terminé"** pour quitter proprement
   - Ou utilisez `Ctrl+C`

## Exemple de session

```
🚀 Lancement de Claude Code...
✅ Claude Code démarré

🎤 Reconnaissance vocale activée
   Dites 'stop' pour envoyer votre message à Claude
   Dites 'terminé' pour terminer la session

⌨️  Clavier actif pour répondre aux questions de Claude

💭 lis le fichier
📝 lis le fichier main point py
💭 et dis moi ce qu'il fait stop
📝 et dis moi ce qu'il fait

📤 Envoi à Claude: lis le fichier main.py et dis moi ce qu'il fait
────────────────────────────────────────────────────────────

[Claude répond avec l'analyse du fichier...]

💭 maintenant crée
📝 maintenant crée une fonction
📝 pour valider les emails
💭 stop

📤 Envoi à Claude: maintenant crée une fonction pour valider les emails
────────────────────────────────────────────────────────────

[Claude crée la fonction...]

💭 terminé
🛑 Mot magique 'terminé' détecté - Fin de session

🧹 Nettoyage en cours...
✅ Session terminée
```

## Architecture technique

### Threads

Le script utilise une architecture multi-thread :

1. **Thread principal** : Gestion du clavier et coordination
2. **Thread vocal** : Reconnaissance vocale continue (Vosk)
3. **Thread stdout** : Lecture et affichage des réponses de Claude

### Communication

```
┌─────────────────┐
│  Microphone     │
│  (Vosk)         │
└────────┬────────┘
         │
         v
┌─────────────────┐      stop      ┌──────────────┐
│  Buffer Vocal   │ ─────────────────>│   Claude     │
│                 │                   │   Process    │
└─────────────────┘                   │              │
                                      │  stdin/out   │
┌─────────────────┐                   │              │
│  Clavier        │ ─────────────────>│              │
│  (stdin)        │   Yes/No/choix   └──────┬───────┘
└─────────────────┘                          │
                                             v
                                    ┌────────────────┐
                                    │  Affichage     │
                                    │  Terminal      │
                                    └────────────────┘
```

## Dépannage

### Le micro n'enregistre pas

- Vérifiez que PyAudio fonctionne :
  ```bash
  python3 -c "import pyaudio; p=pyaudio.PyAudio(); print(p.get_default_input_device_info())"
  ```

- Testez le micro avec :
  ```bash
  arecord -d 3 test.wav && aplay test.wav
  ```

### Claude ne démarre pas

- Vérifiez l'installation :
  ```bash
  which claude
  claude --version
  ```

- Assurez-vous que Claude est dans le PATH

### Les mots magiques ne sont pas détectés

- Prononcez clairement : **"stop"** (pas "slou-bi" ou "slouby")
- Pour **"terminé"**, articulez bien chaque syllabe
- La détection est insensible à la casse

### Le clavier ne répond pas

- C'est normal pendant que vous parlez
- Le clavier est actif uniquement quand Claude attend une réponse
- Utilisez `Ctrl+C` en cas de blocage

## Limites connues

- Le buffer vocal ne s'affiche pas de façon structurée (améliorations futures)
- Pas de preview du buffer avant envoi (à venir)
- Les mots magiques doivent être prononcés dans la même phrase que le texte

## Améliorations futures

- [ ] Commande vocale pour voir le buffer actuel
- [ ] Commande vocale pour effacer le buffer
- [ ] Historique des échanges
- [ ] Mode debug avec logs détaillés
- [ ] Support de plusieurs modèles Vosk
- [ ] Configuration personnalisable des mots magiques

## Comparaison avec les autres modes

| Fonctionnalité | Session Interactive | Temps Réel | Daemon |
|----------------|---------------------|------------|--------|
| Lance Claude automatiquement | ✅ | ❌ | ❌ |
| Conversation continue | ✅ | ❌ | ❌ |
| Mots magiques | ✅ | ❌ | ❌ |
| Clavier actif pendant l'écoute | ✅ | ⚠️ | ⚠️ |
| Multi-requêtes dans une session | ✅ | ❌ | ❌ |

## Auteur et licence

Voice to Claude - Session Interactive Mode
Créé pour une interaction naturelle avec Claude Code

MIT License
