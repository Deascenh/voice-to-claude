# Démarrage Rapide

## Installation en 2 minutes

```bash
# 1. Installation (une seule fois)
./install.sh

# 2. Utilisation
./voice_realtime.py
```

C'est tout ! Parlez et voyez le texte apparaître dans Claude Code en temps réel.

## Workflow typique

### Première utilisation

1. **Installez** (une seule fois) :
   ```bash
   cd ~/dev/voice_to_claude
   ./install.sh
   ```
   ⏱️ Temps : ~2 minutes

2. **Testez** :
   ```bash
   ./voice_realtime.py
   ```
   Dites quelque chose, dites "stop", vérifiez que ça marche.

### Utilisation quotidienne

**Option A : Deux terminaux (recommandé)**

Terminal 1 :
```bash
claude code
```

Terminal 2 :
```bash
cd ~/dev/voice_to_claude
./voice_realtime.py
```
Parlez → Le texte apparaît dans Terminal 1 → Appuyez sur Entrée

**Option B : Script de lancement**

```bash
cd ~/dev/voice_to_claude
./start.sh
```
Choisissez votre mode préféré.

## Aide-mémoire

| Commande | Usage |
|----------|-------|
| `./voice_realtime.py` | Mode temps réel (le plus simple) |
| `./voice_daemon.py` | Mode push-to-talk (Ctrl+Space) |
| `./voice_to_claude.py` | Mode copier-coller |
| `./start.sh` | Menu de sélection |

| Mot-clé | Action |
|---------|--------|
| "stop" | Arrêter la dictée (mode temps réel) |
| "envoyer" | Envoyer le texte (mode copier-coller) |
| Ctrl+Space | Activer/désactiver (mode daemon) |
| Ctrl+C | Quitter |

## Résolution de problèmes

### "Modèle non trouvé"
```bash
ls vosk-model-*  # Doit afficher un dossier
```
Si vide → Relancez `./install.sh`

### Mauvaise reconnaissance
- Parlez plus lentement et clairement
- Réduisez le bruit ambiant
- Rapprochez-vous du micro

### Le texte ne s'injecte pas
- Vérifiez que Claude Code est bien dans le terminal actif
- Cliquez dans le terminal Claude Code avant de dicter
- Vérifiez : `which xdotool` (doit afficher un chemin)

## Questions fréquentes

**Q: Puis-je dicter de la ponctuation ?**
A: Le modèle ne gère pas bien la ponctuation vocale. Ajoutez-la manuellement après.

**Q: Ça fonctionne hors ligne ?**
A: Oui, complètement offline une fois installé.

**Q: C'est gratuit ?**
A: Oui, 100% gratuit et open source.

**Q: Quelle est la meilleure qualité audio ?**
A: Un micro proche (casque ou micro USB) donne les meilleurs résultats.

**Q: Puis-je utiliser plusieurs langues ?**
A: Oui, téléchargez d'autres modèles sur [alphacephei.com/vosk/models](https://alphacephei.com/vosk/models)

## Personnalisation

### Changer le mot d'arrêt

Éditez `voice_realtime.py` ligne 11 :
```python
STOP_WORD = "stop"  # Changez en "terminé", "ok", etc.
```

### Utiliser le modèle complet (meilleure précision)

```bash
wget https://alphacephei.com/vosk/models/vosk-model-fr-0.22.zip
unzip vosk-model-fr-0.22.zip
```

Puis dans les scripts, changez :
```python
MODEL_PATH = "vosk-model-fr-0.22"
```

### Créer des alias

Ajoutez dans `~/.bashrc` :
```bash
alias vt="cd ~/dev/voice_to_claude && ./voice_realtime.py"
alias vd="cd ~/dev/voice_to_claude && ./voice_daemon.py"
```

Puis : `source ~/.bashrc`

Maintenant tapez juste `vt` depuis n'importe où !

## Pour aller plus loin

Lisez le [README.md](README.md) complet pour :
- Comprendre les différents modes
- Configuration avancée
- Astuces d'utilisation
- Architecture technique
