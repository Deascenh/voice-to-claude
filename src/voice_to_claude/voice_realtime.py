#!/usr/bin/env python3
"""
Voice to Claude - Mode Temps Réel Simplifié
Version simple : lancez le script, dictez, le texte s'injecte en direct
"""
import vosk
import pyaudio
import json
import sys
import os
import subprocess
import signal

# Configuration
MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000
STOP_WORD = "stop"  # Mot pour arrêter la dictée

def type_text(text):
    """Injecte du texte dans le terminal actif"""
    try:
        # Ajoute un espace avant si ce n'est pas le début
        subprocess.run(
            ['xdotool', 'type', '--', text],
            check=True,
            stderr=subprocess.DEVNULL
        )
    except subprocess.CalledProcessError:
        pass

def signal_handler(sig, frame):
    """Gestion propre de Ctrl+C"""
    print("\n\n👋 Dictée interrompue")
    sys.exit(0)

def main():
    # Gestion de Ctrl+C
    signal.signal(signal.SIGINT, signal_handler)

    # Vérifier l'existence du modèle
    if not os.path.exists(MODEL_PATH):
        print(f"❌ Erreur: Modèle non trouvé dans {MODEL_PATH}")
        sys.exit(1)

    # Initialiser Vosk
    model = vosk.Model(MODEL_PATH)
    recognizer = vosk.KaldiRecognizer(model, SAMPLE_RATE)

    # Initialiser PyAudio
    mic = pyaudio.PyAudio()
    stream = mic.open(
        format=pyaudio.paInt16,
        channels=1,
        rate=SAMPLE_RATE,
        input=True,
        frames_per_buffer=8192
    )
    stream.start_stream()

    print("🎤 Dictée en temps réel activée")
    print("   Parlez maintenant - le texte sera tapé en direct dans Claude Code")
    print(f"   Dites '{STOP_WORD}' pour terminer")
    print("   Ctrl+C pour annuler\n")
    print("🔴 ENREGISTREMENT EN COURS...\n")

    first_word = True
    last_partial = ""

    try:
        while True:
            data = stream.read(4096, exception_on_overflow=False)

            if recognizer.AcceptWaveform(data):
                result = json.loads(recognizer.Result())
                text = result.get('text', '').strip()

                if text:
                    # Vérifier le mot d'arrêt
                    if STOP_WORD in text.lower():
                        # Retirer le mot stop et traiter le reste
                        text_clean = text.lower().replace(STOP_WORD, '').strip()
                        if text_clean:
                            if not first_word:
                                type_text(' ')
                            type_text(text_clean)
                            print(f"📝 {text_clean}")
                        print(f"\n⏸️  Mot d'arrêt détecté - Dictée terminée")
                        break

                    # Injecter le texte mot par mot
                    if not first_word:
                        type_text(' ')
                    type_text(text)
                    first_word = False

                    # Afficher dans la console
                    print(f"📝 {text}")

                    # Effacer le résultat partiel
                    if last_partial:
                        print("\r" + " " * (len(last_partial) + 5), end="\r")
                        last_partial = ""
            else:
                # Résultat partiel pour feedback visuel
                partial = json.loads(recognizer.PartialResult())
                partial_text = partial.get('partial', '')

                if partial_text != last_partial:
                    print(f"\r💭 {partial_text}", end='', flush=True)
                    last_partial = partial_text

    finally:
        stream.stop_stream()
        stream.close()
        mic.terminate()

        if last_partial:
            print()  # Nouvelle ligne finale

        print("\n✅ Dictée terminée")
        print("💡 Vous pouvez maintenant interagir avec Claude Code\n")

if __name__ == "__main__":
    main()
