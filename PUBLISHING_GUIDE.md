# Guide de Publication sur GitHub

Ce guide vous accompagne pour publier Voice to Claude sur votre compte GitHub et le partager avec vos collègues.

## 📋 Checklist avant publication

- [x] Code testé et fonctionnel
- [x] Documentation complète
- [x] LICENSE ajoutée
- [x] .gitignore configuré
- [x] README professionnel
- [x] Scripts d'installation Mac/Linux
- [x] CONTRIBUTING.md
- [x] CHANGELOG.md

## 🚀 Étapes de publication

### 1. Initialiser le repository Git local

```bash
./init_git.sh
```

Ce script :
- ✅ Initialise git
- ✅ Crée le .gitignore
- ✅ Fait le commit initial
- ✅ Affiche les prochaines étapes

### 2. Créer le repository sur GitHub

1. Allez sur [github.com/new](https://github.com/new)

2. Remplissez les informations :
   - **Repository name** : `voice-to-claude`
   - **Description** : `🎤 Dictée vocale en français pour Claude Code - 100% offline et gratuit`
   - **Visibility** : Public
   - ⚠️ **N'initialisez PAS** avec README, .gitignore ou LICENSE (déjà créés localement)

3. Cliquez sur "Create repository"

### 3. Lier et pousser votre code

```bash
# Remplacez VOTRE-USERNAME par votre nom d'utilisateur GitHub
git remote add origin https://github.com/VOTRE-USERNAME/voice-to-claude.git

# Renommer la branche en main
git branch -M main

# Pousser le code
git push -u origin main
```

### 4. Configurer le repository sur GitHub

#### Ajouter des topics

Dans votre repo GitHub, cliquez sur la roue dentée à côté de "About" et ajoutez :
- `voice-recognition`
- `claude-code`
- `vosk`
- `python`
- `speech-to-text`
- `offline`
- `french`
- `developer-tools`

#### Activer les Issues

Settings > Features > Issues : ✅ Activé

#### Activer les Discussions (optionnel)

Settings > Features > Discussions : ✅ Activé

### 5. Créer une release v1.0.0

1. Allez dans "Releases" > "Create a new release"

2. Tag : `v1.0.0`

3. Release title : `🎤 Voice to Claude v1.0.0 - Initial Release`

4. Description :
```markdown
## 🎉 Première version stable de Voice to Claude !

### ✨ Fonctionnalités

- **Mode Session Interactive** : Conversation continue avec mots magiques (sloubi/wakeuteu)
- **Mode Temps Réel** : Injection directe dans le terminal
- **Mode Daemon** : Push-to-talk avec Ctrl+Space
- **Mode Copier-Coller** : Révision avant envoi

### 🛠️ Installation

```bash
git clone https://github.com/VOTRE-USERNAME/voice-to-claude.git
cd voice-to-claude
./setup.sh
```

### 📚 Documentation

- [Guide de démarrage rapide](QUICK_START_SESSION.md)
- [Mode Session Interactive](SESSION_MODE.md)
- [Guide complet](README.md)

### 🙏 Merci !

N'hésitez pas à ⭐ ce projet si vous le trouvez utile !
```

5. Cliquez sur "Publish release"

## 📢 Partager avec vos collègues

### Message pour Slack/Email

```
Salut à tous ! 👋

Je viens de publier un outil open source qui pourrait vous intéresser :

🎤 Voice to Claude - Dictée vocale pour Claude Code

🔥 Fonctionnalités :
• 4 modes d'utilisation (session continue, temps réel, push-to-talk, copier-coller)
• 100% offline - aucune donnée envoyée sur Internet
• Gratuit et sans limite
• Compatible macOS et Linux
• Installation en une commande

🚀 Installation :
git clone https://github.com/VOTRE-USERNAME/voice-to-claude.git
cd voice-to-claude
./setup.sh

📖 Documentation : https://github.com/VOTRE-USERNAME/voice-to-claude

N'hésitez pas à l'essayer et à me faire vos retours !
```

### Démo rapide (30 secondes)

Pour une démo efficace :

1. **Ouvrez un terminal** et lancez :
   ```bash
   ./start_session.sh
   ```

2. **Parlez** : "créer une fonction python qui calcule la factorielle d'un nombre"

3. **Dites** : "sloubi"

4. **Claude répond** et crée la fonction

5. **Continuez** : "maintenant ajoute des tests unitaires sloubi"

6. **Terminez** : "wakeuteu"

Vos collègues seront impressionnés ! 🤩

## 🎯 Maintenir le projet

### Gérer les issues

Quand quelqu'un ouvre une issue :
1. Remerciez-le pour sa contribution
2. Reproduisez le bug ou évaluez la feature
3. Labellisez : `bug`, `enhancement`, `question`, etc.
4. Répondez avec une solution ou un plan

### Accepter des Pull Requests

1. Vérifiez que le code suit les standards
2. Testez les changements localement
3. Demandez des modifications si nécessaire
4. Mergez et remerciez le contributeur

### Publier une nouvelle version

Quand vous ajoutez des fonctionnalités :

```bash
# Mettez à jour CHANGELOG.md
# Committez vos changements
git add .
git commit -m "Add: nouvelle fonctionnalité"
git push

# Créez un nouveau tag
git tag v1.1.0
git push origin v1.1.0

# Créez une release sur GitHub
```

## 📊 Métriques à surveiller

Sur GitHub, suivez :
- ⭐ **Stars** : Popularité du projet
- 👁️ **Watchers** : Personnes qui suivent les mises à jour
- 🔀 **Forks** : Personnes qui veulent contribuer
- 📈 **Traffic** : Visiteurs et clones
- 🐛 **Issues** : Bugs et demandes de fonctionnalités

## 🎓 Bonnes pratiques

### Communication

- Répondez rapidement aux issues (< 48h idéalement)
- Soyez accueillant avec les nouveaux contributeurs
- Documentez bien vos décisions

### Code

- Ne pushez jamais directement sur `main` pour des changements importants
- Utilisez des branches : `feature/nom-feature`
- Écrivez des messages de commit clairs

### Documentation

- Gardez le README à jour
- Documentez les nouvelles fonctionnalités
- Maintenez le CHANGELOG

## 🆘 Support

Si vous avez des questions sur la publication :
1. Consultez [GitHub Docs](https://docs.github.com)
2. Demandez de l'aide à vos collègues
3. Ouvrez une discussion dans le repo

## ✨ Félicitations !

Votre projet est maintenant public et prêt à être partagé avec le monde ! 🎉

N'oubliez pas :
- Partagez-le sur vos réseaux professionnels
- Demandez des retours à vos collègues
- Itérez en fonction des retours

Bonne chance ! 🚀
