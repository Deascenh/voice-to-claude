# GitFlow Workflow - Voice to Claude

Ce projet utilise **GitFlow** pour gérer les branches et les releases de manière professionnelle.

## 🌳 Structure des branches

### Branches permanentes

- **`main`** - Code en production (releases stables)
  - Code testé et validé
  - Tagged avec les versions (v1.0.0, v1.1.0, etc.)
  - Protégée contre les push directs

- **`develop`** - Branche de développement
  - Code en cours de développement
  - Base pour les nouvelles features
  - Intégration continue (CI) active

### Branches temporaires

- **`feature/*`** - Nouvelles fonctionnalités
  - Créées depuis `develop`
  - Mergées dans `develop` via PR
  - Exemple : `feature/voice-commands`, `feature/gui-interface`

- **`hotfix/*`** - Corrections urgentes
  - Créées depuis `main`
  - Mergées dans `main` ET `develop`
  - Exemple : `hotfix/critical-bug`, `hotfix/security-patch`

- **`release/*`** - Préparation de release
  - Créées depuis `develop`
  - Tests finaux et ajustements mineurs
  - Mergées dans `main` ET `develop`
  - Exemple : `release/v1.1.0`

## 🔄 Workflows

### 1. Développer une nouvelle feature

```bash
# 1. Se placer sur develop
git checkout develop
git pull origin develop

# 2. Créer une branche feature
git checkout -b feature/ma-super-feature

# 3. Développer
# - Faire vos changements
# - Committer régulièrement
git add .
git commit -m "Add: nouvelle fonctionnalité X"

# 4. Tester localement
make test
make lint

# 5. Pousser la branche
git push origin feature/ma-super-feature

# 6. Créer une Pull Request vers develop sur GitHub
# - Remplir le template de PR
# - Demander une review
# - Attendre les checks CI

# 7. Après merge, supprimer la branche
git checkout develop
git pull origin develop
git branch -d feature/ma-super-feature
```

### 2. Corriger un bug critique (hotfix)

```bash
# 1. Se placer sur main
git checkout main
git pull origin main

# 2. Créer une branche hotfix
git checkout -b hotfix/critical-bug

# 3. Corriger le bug
git add .
git commit -m "Fix: correction du bug critique X"

# 4. Tester
make test

# 5. Pousser
git push origin hotfix/critical-bug

# 6. Créer 2 PRs :
#    - Une vers main (merge direct)
#    - Une vers develop (pour sync)

# 7. Après merge dans main, créer un tag
git checkout main
git pull origin main
git tag -a v1.0.1 -m "Hotfix: correction bug critique"
git push origin v1.0.1
```

### 3. Préparer une release

```bash
# 1. Créer la branche release depuis develop
git checkout develop
git pull origin develop
git checkout -b release/v1.1.0

# 2. Mettre à jour les fichiers de version
# - pyproject.toml (version = "1.1.0")
# - src/voice_to_claude/__init__.py (__version__ = "1.1.0")
# - CHANGELOG.md (ajouter les changements)

# 3. Committer
git add .
git commit -m "Bump version to 1.1.0"

# 4. Tests finaux
make ci

# 5. Pousser
git push origin release/v1.1.0

# 6. Créer une PR vers main
# Après review et merge :

# 7. Merger aussi dans develop
git checkout develop
git merge release/v1.1.0
git push origin develop

# 8. Créer le tag sur main
git checkout main
git pull origin main
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0

# 9. Supprimer la branche release
git branch -d release/v1.1.0
git push origin --delete release/v1.1.0
```

## 📝 Conventions de commit

Utiliser les **Conventional Commits** :

```
<type>: <description courte>

[body optionnel]

[footer optionnel]
```

### Types

- `Add:` - Nouvelle fonctionnalité
- `Fix:` - Correction de bug
- `Update:` - Modification d'une fonctionnalité existante
- `Refactor:` - Restructuration du code
- `Docs:` - Documentation uniquement
- `Test:` - Ajout/modification de tests
- `Chore:` - Tâches de maintenance (deps, config, etc.)
- `Perf:` - Amélioration de performance
- `Style:` - Formatage, lint

### Exemples

```bash
# Feature
git commit -m "Add: support de la ponctuation vocale"

# Bug fix
git commit -m "Fix: correction de la détection du mot magique"

# Refactoring
git commit -m "Refactor: extraction de la logique vocale dans un module séparé"

# Documentation
git commit -m "Docs: ajout d'exemples d'utilisation dans le README"

# Breaking change
git commit -m "Update!: changement du format de configuration

BREAKING CHANGE: Le fichier de config utilise maintenant YAML au lieu de JSON"
```

## 🛡️ Protection des branches

### Configuration recommandée sur GitHub

#### Branch protection pour `main`
- ✅ Require a pull request before merging
- ✅ Require approvals (1 minimum)
- ✅ Dismiss stale pull request approvals when new commits are pushed
- ✅ Require status checks to pass before merging
  - CI (pytest)
  - Code Quality (lint)
- ✅ Require conversation resolution before merging
- ✅ Do not allow bypassing the above settings

#### Branch protection pour `develop`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging
- ⚠️ Approvals optionnelles (pour plus de flexibilité)

## 🏷️ Versioning

Le projet suit **Semantic Versioning** (SemVer) :

```
MAJOR.MINOR.PATCH

1.2.3
│ │ │
│ │ └─ PATCH: Bug fixes, hotfixes
│ └─── MINOR: New features (backward compatible)
└───── MAJOR: Breaking changes
```

### Exemples

- `1.0.0` → `1.0.1` : Correction de bugs
- `1.0.1` → `1.1.0` : Nouvelle fonctionnalité
- `1.1.0` → `2.0.0` : Changement non compatible

## 📋 Checklist avant merge

### Pour les features

- [ ] Code formaté (black, isort)
- [ ] Tests passent (`make test`)
- [ ] Lint OK (`make lint`)
- [ ] Documentation mise à jour
- [ ] PR template rempli
- [ ] Review obtenue
- [ ] CI passé (tous les checks verts)

### Pour les releases

- [ ] Version bumped dans tous les fichiers
- [ ] CHANGELOG.md mis à jour
- [ ] Tests complets passés (`make ci`)
- [ ] Documentation à jour
- [ ] Migration guide si breaking changes
- [ ] Tag créé après merge

## 🚀 Automatisation

### GitHub Actions

Les workflows suivants sont automatiques :

1. **CI** (sur push/PR vers main ou develop)
   - Tests Python 3.8, 3.9, 3.10, 3.11
   - Ubuntu et macOS
   - Coverage report
   - Code quality checks

2. **Release** (sur tag v*)
   - Build du package
   - Création de la GitHub Release
   - Upload des artifacts

### Pre-commit hooks

Installés automatiquement :

```bash
make pre-commit
```

Vérifications avant chaque commit :
- Formatage (black, isort)
- Lint (flake8)
- Trailing whitespace
- YAML/JSON validity

## 🆘 Problèmes courants

### J'ai commité sur la mauvaise branche

```bash
# Si pas encore pushé
git reset --soft HEAD~1  # Annule le dernier commit
git stash                # Sauvegarde les changements
git checkout correct-branch
git stash pop            # Réapplique les changements
```

### Conflit lors du merge

```bash
# Résoudre manuellement les conflits dans les fichiers
git add fichier-en-conflit
git commit -m "Resolve merge conflict"
```

### J'ai oublié de créer une branche feature

```bash
# Créer la branche à partir de develop
git checkout develop
git checkout -b feature/ma-feature

# Récupérer vos commits depuis develop
git cherry-pick <commit-hash>
```

## 📚 Ressources

- [GitFlow original](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

---

**Questions ?** Ouvrez une [issue](https://github.com/VOTRE-USERNAME/voice-to-claude/issues) ou une [discussion](https://github.com/VOTRE-USERNAME/voice-to-claude/discussions).
