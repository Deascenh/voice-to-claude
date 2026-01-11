"""
Voice to Claude - Dictée vocale pour Claude Code

Un système de reconnaissance vocale offline en français pour interagir
avec Claude Code de manière fluide et naturelle.
"""

__version__ = "1.0.0"
__author__ = "Voice to Claude Contributors"
__license__ = "MIT"

from pathlib import Path

# Chemin vers le modèle Vosk par défaut
DEFAULT_MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000

# Mots magiques pour le mode session
DEFAULT_SEND_WORD = "stop"
DEFAULT_QUIT_WORD = "terminé"
