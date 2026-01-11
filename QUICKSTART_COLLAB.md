# 🚀 Quick Start - Collaboration

Guide ultra-rapide pour passer du projet local à GitHub en 5 minutes.

## ⚡ En 5 étapes

### 1. Installer et tester localement

```bash
# Installer les dépendances de dev
make install-dev

# Lancer les tests
make test

# Vérifier la qualité
make quality
```

✅ **Attendu :** Tous les tests passent, pas d'erreurs de lint

### 2. Initialiser Git avec GitFlow

```bash
./init_repo.sh
```

✅ **Attendu :** Branches `main` et `develop` créées

### 3. Créer le repository GitHub

**Sur https://github.com/new :**

- Repository name: `voice-to-claude`
- Description: `🎤 Dictée vocale en français pour Claude Code - 100% offline`
- Public ✅
- **NE PAS** cocher : Add a README, Add .gitignore, Choose a license

Cliquez sur **"Create repository"**

### 4. Lier et pousser

```bash
# Remplacez VOTRE-USERNAME par votre vrai username GitHub
git remote add origin https://github.com/VOTRE-USERNAME/voice-to-claude.git

# Pousser main
git push -u origin main

# Pousser develop
git push -u origin develop
```

✅ **Attendu :** Code visible sur GitHub

### 5. Configurer GitHub

#### A. Activer les fonctionnalités

- ✅ Issues
- ✅ Discussions (optionnel mais recommandé)
- ✅ Wiki (optionnel)

#### B. Protéger les branches

**Settings > Branches > Add branch protection rule**

**Pour `main` :**
- Branch name pattern: `main`
- ✅ Require a pull request before merging
  - Require approvals: `1`
- ✅ Require status checks to pass before merging
  - ✅ Test
  - ✅ Lint
  - ✅ Code Quality Checks
- ✅ Require conversation resolution before merging
- ✅ Include administrators

**Pour `develop` :**
- Branch name pattern: `develop`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging

#### C. Ajouter des topics

Settings > About (roue dentée) > Topics :

```
voice-recognition
claude-code
vosk
python
speech-to-text
offline
french
developer-tools
```

### 6. Créer la release v1.0.0

```bash
git checkout main
git tag -a v1.0.0 -m "Initial release - Voice to Claude v1.0.0"
git push origin v1.0.0
```

✅ **Attendu :** Release automatiquement créée sur GitHub

---

## ✨ C'est fini !

Votre projet est maintenant :

- ✅ Sur GitHub
- ✅ Avec CI/CD actif
- ✅ Branches protégées
- ✅ Release v1.0.0 publiée
- ✅ Prêt pour les collaborations

---

## 🎯 Prochaines actions

### Pour vos collègues

**Message à envoyer :**

```
Salut ! 👋

J'ai publié Voice to Claude, un outil pour dicter vocalement à Claude Code :

🔗 https://github.com/VOTRE-USERNAME/voice-to-claude

🚀 Installation :
git clone https://github.com/VOTRE-USERNAME/voice-to-claude.git
cd voice-to-claude
./scripts/setup.sh
make run-session

Le projet est prêt pour la collaboration !
N'hésitez pas à contribuer ou donner votre feedback 😊
```

### Votre première feature

Testez le workflow GitFlow :

```bash
# Créer une branche feature
git checkout develop
git checkout -b feature/exemple

# Faire des changements
echo "# Nouvelle feature" >> docs/EXEMPLE.md
git add docs/EXEMPLE.md
git commit -m "Add: exemple de feature"

# Pousser et créer une PR
git push origin feature/exemple
```

Puis sur GitHub :
1. Cliquez sur "Compare & pull request"
2. Base: `develop` ← compare: `feature/exemple`
3. Remplissez le template de PR
4. Créez la PR
5. Attendez que le CI passe (vert)
6. Mergez !

### Installer pre-commit hooks

Sur votre machine locale :

```bash
make pre-commit
```

Maintenant, avant chaque commit :
- ✅ Code formaté automatiquement
- ✅ Lint vérifié
- ✅ Types vérifiés
- ✅ Security check

---

## 📊 Vérifier que tout fonctionne

### CI/CD

Allez sur : `https://github.com/VOTRE-USERNAME/voice-to-claude/actions`

Vous devriez voir :
- ✅ Workflow "CI" (vert)
- ✅ Workflow "Release" (vert, si vous avez créé le tag)

### Badges

Les badges dans le README devraient s'afficher :
- ✅ CI badge (vert)
- ✅ Python version
- ✅ License
- ✅ Code style

### Release

Allez sur : `https://github.com/VOTRE-USERNAME/voice-to-claude/releases`

Vous devriez voir :
- ✅ Release v1.0.0
- ✅ Notes de release
- ✅ Assets (dist files)

---

## 🆘 Problèmes courants

### "git push" échoue

```bash
# Si vous avez oublié de créer le repo sur GitHub
# Créez-le d'abord sur github.com/new

# Si l'URL est incorrecte
git remote -v                          # Voir l'URL actuelle
git remote set-url origin https://...  # Corriger l'URL
```

### Le CI ne se déclenche pas

1. Vérifiez que vous avez bien pushé vers `main` ou `develop`
2. Allez dans Actions > Enable workflows si demandé
3. Attendez quelques secondes et rafraîchissez

### Les badges ne s'affichent pas

1. Remplacez `VOTRE-USERNAME` dans README.md
2. Attendez que le CI ait run au moins une fois
3. Vérifiez que le repo est public

### Le workflow "Release" échoue

1. Vérifiez le format du tag : doit être `v1.0.0` (avec le "v")
2. Assurez-vous d'avoir pushé le tag : `git push origin v1.0.0`

---

## 📚 Ressources

- [README.md](README.md) - Documentation complète
- [GITFLOW.md](GITFLOW.md) - Workflow Git
- [UPGRADE_SUMMARY.md](UPGRADE_SUMMARY.md) - Ce qui a changé
- [Makefile](Makefile) - Toutes les commandes (`make help`)

---

## 🎉 Félicitations !

Votre projet est maintenant **production-ready** et prêt pour la collaboration professionnelle ! 🚀

**Prochaine étape :** Partagez-le avec vos collègues et itérez en fonction de leurs retours.

Bon développement collaboratif ! 🎤✨
