# ⚙️ CI/CD & GitHub Configuration

Ce fichier documente toute la configuration GitHub Actions, workflows et templates pour Voice to Claude.

## Workflows CI/CD

### `workflows/ci.yml` - Continuous Integration

**Déclenchement :**
- Push vers `main` ou `develop`
- Pull Request vers `main` ou `develop`

**Jobs :**

1. **Test** (Matrix: Ubuntu/macOS × Python 3.8-3.11)
   - Installation des dépendances
   - Exécution des tests pytest
   - Upload coverage vers Codecov

2. **Lint** (Code Quality)
   - Black (formatage)
   - Flake8 (linting)
   - Mypy (type checking)
   - Pylint (qualité)

3. **Security** (Sécurité)
   - Bandit (vulnérabilités code)
   - Safety (vulnérabilités dépendances)

**Badge :**
```markdown
[![CI](https://github.com/VOTRE-USERNAME/voice-to-claude/workflows/CI/badge.svg)](https://github.com/VOTRE-USERNAME/voice-to-claude/actions)
```

### `workflows/release.yml` - Automated Release

**Déclenchement :**
- Push d'un tag `v*` (ex: v1.0.0)

**Actions :**
- Build du package Python
- Vérification avec twine
- Création de GitHub Release
- Upload des artifacts

**Utilisation :**
```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## Templates

### `pull_request_template.md`

Template automatique pour toutes les PR.

**Sections :**
- Type de changement
- Motivation et contexte
- Tests effectués
- Checklist complète

### `ISSUE_TEMPLATE/`

Templates pour les issues GitHub.

**bug_report.md** - Signaler un bug
- Description
- Étapes de reproduction
- Environnement
- Logs d'erreur

**feature_request.md** - Proposer une feature
- Description
- Problème résolu
- Solution proposée
- Exemples d'utilisation

## Code Owners

`CODEOWNERS` définit les propriétaires par défaut pour les reviews.

**Configuration actuelle :**
- Tout le code : @votre-username

**À mettre à jour** avec votre vrai username GitHub !

## Protection des Branches

### Recommandations pour `main`

Settings > Branches > Add rule :

- ✅ Branch name pattern: `main`
- ✅ Require a pull request before merging
  - ✅ Require approvals: 1
  - ✅ Dismiss stale pull request approvals
- ✅ Require status checks to pass
  - ✅ Test
  - ✅ Lint
  - ✅ Security (optionnel)
- ✅ Require conversation resolution
- ✅ Include administrators

### Recommandations pour `develop`

- ✅ Branch name pattern: `develop`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass
  - ✅ Test
  - ✅ Lint

## Badges disponibles

Pour le README.md :

```markdown
[![CI](https://github.com/VOTRE-USERNAME/voice-to-claude/workflows/CI/badge.svg)](https://github.com/VOTRE-USERNAME/voice-to-claude/actions)
[![Python Version](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![codecov](https://codecov.io/gh/VOTRE-USERNAME/voice-to-claude/branch/main/graph/badge.svg)](https://codecov.io/gh/VOTRE-USERNAME/voice-to-claude)
```

## Configuration Codecov (optionnel)

Pour activer le coverage tracking :

1. Allez sur https://codecov.io
2. Connectez votre repo GitHub
3. Copiez le token
4. Ajoutez-le dans Settings > Secrets : `CODECOV_TOKEN`

## Utilisation

### Vérifier le statut CI

```bash
# Voir les runs récents
gh run list

# Voir les détails d'un run
gh run view <run-id>

# Relancer un run
gh run rerun <run-id>
```

### Créer une release

```bash
# Créer un tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0

# Le workflow release se déclenche automatiquement
```

### Tester localement avant le CI

```bash
# Simuler le CI en local
make ci

# Ou individuellement
make test
make lint
make format-check
```

## Maintenance

### Mettre à jour les GitHub Actions

Les versions des actions sont fixées pour la stabilité.

Pour mettre à jour :

```yaml
# Avant
- uses: actions/checkout@v3

# Après
- uses: actions/checkout@v4
```

Testez d'abord dans une branche feature.

### Ajouter de nouveaux checks

Éditez `.github/workflows/ci.yml` :

```yaml
- name: Nouveau check
  run: |
    mon-nouveau-check
```

## Troubleshooting

### Le CI échoue mais les tests passent en local

1. Vérifiez les versions Python
2. Vérifiez les dépendances OS-spécifiques
3. Consultez les logs GitHub Actions

### La release ne se déclenche pas

1. Vérifiez le format du tag (doit être `v*`)
2. Vérifiez que vous avez pushé le tag : `git push origin v1.0.0`
3. Consultez l'onglet Actions

### Les badges ne s'affichent pas

1. Remplacez `VOTRE-USERNAME` par votre vrai username
2. Attendez que le CI ait run au moins une fois
3. Vérifiez la visibilité du repo (public)

---

**Plus d'infos :** [GitHub Actions Documentation](https://docs.github.com/en/actions)
