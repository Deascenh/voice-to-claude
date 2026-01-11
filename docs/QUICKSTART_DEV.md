# Guide de démarrage rapide - Développement

Guide ultra-rapide pour configurer votre environnement de développement Voice to Claude.

## Pour les développeurs débutants en Python

### Installation en 4 commandes

```bash
# 1. Créer l'environnement virtuel
make setup-venv

# 2. Installer les dépendances de développement
make install-dev

# 3. Installer les dépendances système
make install-system

# 4. Vérifier que tout fonctionne
make verify
```

## Commandes quotidiennes

**Important :** Le Makefile détecte automatiquement le venv. Vous n'avez **pas besoin** de faire `source venv/bin/activate` !

```bash
# Lancer les tests
make test

# Formater le code
make format

# Vérifier la qualité du code
make lint

# Tout vérifier d'un coup (format + lint + tests)
make quality
```

## FAQ Développeurs

### Dois-je activer le venv manuellement ?

**Non !** Les commandes `make` détectent et utilisent automatiquement le venv s'il existe.

Si vous travaillez sans make, alors oui :
```bash
source venv/bin/activate
# ... votre travail ...
deactivate
```

### Comment sortir du venv ?

```bash
deactivate
```

### J'ai une erreur "No module named pytest"

Vous n'êtes probablement pas dans le venv. Deux solutions :

1. **Utilisez make (recommandé) :**
   ```bash
   make test
   ```

2. **Activez le venv manuellement :**
   ```bash
   source venv/bin/activate
   pytest tests/
   ```

### Comment savoir si je suis dans le venv ?

Votre prompt commence par `(venv)` :
```
(venv) utilisateur@machine:~/voice_to_claude$
```

### Le venv est-il commité dans git ?

Non ! Le dossier `venv/` est dans le `.gitignore`. Chaque développeur crée son propre venv local.

## Workflow de développement recommandé

```bash
# 1. Créer une branche
git checkout -b feature/ma-fonctionnalite

# 2. Coder votre fonctionnalité
# ... éditer les fichiers ...

# 3. Formater automatiquement
make format

# 4. Vérifier la qualité
make quality

# 5. Commit et push
git add .
git commit -m "Add: ma super fonctionnalité"
git push origin feature/ma-fonctionnalite
```

## Commandes make disponibles

```bash
make help           # Afficher toutes les commandes
make setup-venv     # Créer le venv
make install        # Installer dépendances de production
make install-dev    # Installer dépendances de développement
make test           # Lancer les tests
make test-fast      # Tests sans couverture (plus rapide)
make lint           # Vérifier la qualité du code
make format         # Formater le code avec Black
make clean          # Nettoyer les fichiers temporaires
make quality        # format + lint + test
```

## Besoin d'aide ?

- Documentation complète : [CONTRIBUTING.md](CONTRIBUTING.md)
- Questions : Ouvrez une issue sur GitHub

---

Bon développement ! 🚀
