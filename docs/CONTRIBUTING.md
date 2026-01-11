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
- **Tests** : Vérifier que `make test` et `make lint` passent
- **Formatage** : Utiliser `make format` avant de commiter

### Messages de commit

Utilisez des messages clairs :
- `Add: nouvelle fonctionnalité`
- `Fix: correction de bug`
- `Update: mise à jour de documentation`
- `Refactor: restructuration de code`

## Structure du projet

```
voice-to-claude/
├── src/voice_to_claude/    # Code source
│   ├── voice_session.py    # Mode session interactive
│   ├── voice_realtime.py   # Mode temps réel
│   ├── voice_daemon.py     # Mode daemon
│   └── voice_to_claude.py  # Mode copier-coller
├── scripts/                # Scripts d'installation
│   ├── setup.sh            # Installation universelle
│   ├── verify.sh           # Vérification système
│   └── start_session.sh    # Lancement session
├── tests/                  # Tests automatisés
├── docs/                   # Documentation
└── Makefile                # Commandes make
```

## Tests

Avant de soumettre une Pull Request :

```bash
# Lancer tous les tests unitaires
make test

# Vérifier le formatage et la qualité du code
make quality

# Ou lancer chaque vérification séparément
make format      # Formater le code
make lint        # Vérifier la qualité
make test        # Lancer les tests
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

### Configuration de l'environnement (pour débutants en Python)

#### Étape 1 : Cloner le repository

```bash
git clone https://github.com/Deascenh/voice-to-claude.git
cd voice-to-claude
```

#### Étape 2 : Créer un environnement virtuel Python

**C'est quoi un environnement virtuel ?**
Un environnement virtuel (venv) isole les dépendances Python de ce projet sans affecter votre système. C'est une bonne pratique en Python.

```bash
# Créer l'environnement virtuel (à faire une seule fois)
make setup-venv

# OU manuellement :
python3 -m venv venv
```

**Note importante :** Le Makefile détecte automatiquement le venv ! Vous n'avez **pas besoin** de l'activer manuellement pour utiliser les commandes `make`.

#### Étape 3 : Installer les dépendances

```bash
# Installer les dépendances de développement (tests, linting, etc.)
make install-dev

# Installer les dépendances système (audio, etc.)
make install-system
```

#### Étape 4 : Vérifier l'installation

```bash
# Vérifier que tout fonctionne
make verify
```

### Utilisation quotidienne

**Avec make (recommandé) :**
```bash
# Le Makefile utilise automatiquement le venv, pas besoin de l'activer !
make test          # Lancer les tests
make lint          # Vérifier la qualité du code
make format        # Formater le code
make quality       # Tout vérifier (format + lint + test)
```

**Sans make (activation manuelle) :**
Si vous préférez travailler sans make, activez d'abord le venv :
```bash
source venv/bin/activate         # Activer le venv
pytest tests/                    # Utiliser les outils Python
deactivate                       # Sortir du venv quand vous avez fini
```

### Debug

Pour activer les logs de debug, ajoutez en haut des scripts Python :

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Tester les modifications

```bash
# Lancer tous les tests
make test

# Lancer un test spécifique
make test-one TEST=imports

# Vérifier la syntaxe et le formatage
make lint

# Formater automatiquement le code
make format
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
