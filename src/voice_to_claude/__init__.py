"""
Voice to Claude - Conversation vocale avec Claude Code

Une application de reconnaissance vocale offline en français permettant
d'avoir des conversations fluides et naturelles avec Claude Code dans un
terminal dédié.

Dites 'stop' pour envoyer votre message, 'terminé' pour quitter.
"""

__version__ = "1.0.0"
__author__ = "Voice to Claude Contributors"
__license__ = "MIT"

# Chemin vers le modèle Vosk par défaut
DEFAULT_MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000

# Mots magiques pour le mode session
DEFAULT_SEND_WORD = "stop"
DEFAULT_QUIT_WORD = "terminé"
