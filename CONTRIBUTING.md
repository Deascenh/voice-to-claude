# Contributing to Voice to Claude

Merci de votre intérêt pour contribuer à Voice to Claude ! Ce guide vous aidera à démarrer.

## Comment contribuer

### Signaler un bug

Si vous trouvez un bug, ouvrez une issue avec :
- Une description claire du problème
- Les étapes pour reproduire le bug
- Votre environnement (OS, version Python, etc.)
- Les messages d'erreur complets si disponibles

### Proposer une nouvelle fonctionnalité

Avant de coder une nouvelle fonctionnalité :
1. Ouvrez une issue pour discuter de l'idée
2. Attendez les retours de la communauté
3. Une fois validée, créez votre PR

### Soumettre une Pull Request

1. **Forkez** le repository
2. **Créez une branche** pour votre fonctionnalité :
   ```bash
   git checkout -b feature/ma-super-feature
   ```
3. **Committez** vos changements :
   ```bash
   git commit -m "Add: description de la fonctionnalité"
   ```
4. **Poussez** sur votre fork :
   ```bash
   git push origin feature/ma-super-feature
   ```
5. **Ouvrez une Pull Request** sur le repository principal

### Standards de code

- **Python** : Suivre PEP 8
- **Commentaires** : En français ou anglais, au choix
- **Documentation** : Mettre à jour le README si nécessaire
- **Tests** : Vérifier que `./verify.sh` passe

### Messages de commit

Utilisez des messages clairs :
- `Add: nouvelle fonctionnalité`
- `Fix: correction de bug`
- `Update: mise à jour de documentation`
- `Refactor: restructuration de code`

## Structure du projet

```
voice_to_claude/
├── voice_session.py        # Mode session interactive
├── voice_realtime.py       # Mode temps réel
├── voice_daemon.py         # Mode daemon
├── voice_to_claude.py      # Mode copier-coller
├── setup.sh                # Installation universelle
├── verify.sh               # Vérification système
└── docs/                   # Documentation
```

## Tests

Avant de soumettre :

```bash
# Vérifier la syntaxe Python
python3 -m py_compile *.py

# Tester l'installation
./verify.sh

# Tester manuellement chaque mode
./voice_realtime.py
```

## Idées de contribution

### Fonctionnalités recherchées

- [ ] Support de la ponctuation vocale
- [ ] Commandes vocales avancées (annuler, répéter, etc.)
- [ ] Interface graphique (GUI optionnelle)
- [ ] Support d'autres langues (anglais, espagnol, etc.)
- [ ] Mode "dictée continue" sans mots magiques
- [ ] Intégration avec d'autres LLM (ChatGPT, etc.)
- [ ] Export de l'historique des sessions
- [ ] Commandes système vocales (ouvrir fichier, etc.)

### Améliorations techniques

- [ ] Tests unitaires automatisés
- [ ] CI/CD avec GitHub Actions
- [ ] Package PyPI
- [ ] Support Windows (WSL)
- [ ] Détection automatique du meilleur modèle Vosk
- [ ] Configuration via fichier YAML

### Documentation

- [ ] Tutoriels vidéo
- [ ] GIFs de démonstration
- [ ] Traduction de la doc en anglais
- [ ] FAQ détaillée

## Développement local

### Configuration de l'environnement

```bash
# Cloner le repo
git clone https://github.com/votre-username/voice-to-claude.git
cd voice-to-claude

# Installer les dépendances
./setup.sh

# Vérifier que tout fonctionne
./verify.sh
```

### Debug

Pour activer les logs de debug, ajoutez en haut des scripts Python :

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Tester les modifications

```bash
# Mode développement - lancer directement
python3 voice_session.py

# Vérifier la syntaxe
python3 -m py_compile voice_session.py
```

## Questions ?

N'hésitez pas à :
- Ouvrir une issue pour poser vos questions
- Rejoindre les discussions existantes
- Proposer vos idées

## Code de conduite

Soyez respectueux et constructif dans vos échanges. Ce projet est ouvert à tous.

## Licence

En contribuant, vous acceptez que vos contributions soient sous licence MIT.

---

Merci de contribuer à Voice to Claude ! 🎤
