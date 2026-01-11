#!/usr/bin/env python3
"""
Voice to Claude - Daemon Mode
Dicte directement dans Claude Code en temps réel avec push-to-talk
"""
import vosk
import pyaudio
import json
import sys
import os
import subprocess
import threading
from pynput import keyboard
from pynput.keyboard import Key, Controller

# Configuration
MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000
ACTIVATION_KEY = Key.space  # Maintenir la touche Space
MODIFIER_KEY = Key.ctrl_l  # Avec Ctrl

# État global
is_recording = False
recording_lock = threading.Lock()
last_typed_text = ""

# Contrôleur de clavier pour l'injection
kbd_controller = Controller()


def type_text(text):
    """Injecte du texte dans le terminal actif en utilisant xdotool"""
    try:
        # Utilise xdotool pour simuler la frappe
        # --clearmodifiers évite les problèmes avec Ctrl maintenu
        subprocess.run(
            ["xdotool", "type", "--clearmodifiers", "--", text],
            check=True,
            stderr=subprocess.DEVNULL,
        )
    except subprocess.CalledProcessError:
        pass  # Ignore les erreurs silencieusement


def voice_recording_thread():
    """Thread de transcription vocale"""
    global last_typed_text

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
        format=pyaudio.paInt16, channels=1, rate=SAMPLE_RATE, input=True, frames_per_buffer=8192
    )

    print("🎤 Daemon de dictée vocale démarré")
    print("   Maintenez Ctrl+Space pour dicter")
    print("   Le texte sera tapé en temps réel dans Claude Code")
    print("   Ctrl+C pour quitter\n")

    last_partial = ""

    try:
        while True:
            if is_recording:
                stream.start_stream()

                while is_recording:
                    try:
                        data = stream.read(4096, exception_on_overflow=False)

                        if recognizer.AcceptWaveform(data):
                            result = json.loads(recognizer.Result())
                            text = result.get("text", "").strip()

                            if text:
                                # Ajouter un espace avant si ce n'est pas le premier mot
                                if last_typed_text:
                                    type_text(" ")

                                # Injecter le texte mot par mot
                                type_text(text)
                                last_typed_text += " " + text if last_typed_text else text
                                print(f"📝 {text}", flush=True)
                        else:
                            # Résultat partiel pour feedback
                            partial = json.loads(recognizer.PartialResult())
                            partial_text = partial.get("partial", "")

                            if partial_text and partial_text != last_partial:
                                # Afficher le résultat partiel (sans l'injecter)
                                print(f"\r💭 {partial_text}", end="", flush=True)
                                last_partial = partial_text
                    except Exception:
                        continue

                # Arrêt de l'enregistrement
                stream.stop_stream()
                if last_partial:
                    print()  # Nouvelle ligne après le résultat partiel
                last_partial = ""

            else:
                # Petite pause quand on n'enregistre pas
                threading.Event().wait(0.1)

    except KeyboardInterrupt:
        pass
    finally:
        stream.close()
        mic.terminate()


def on_press(key):
    """Callback quand une touche est pressée"""
    global is_recording, last_typed_text

    # Vérifier si Ctrl+Space est pressé
    try:
        # Vérifier les modificateurs
        if keyboard.Controller().pressed(MODIFIER_KEY):
            if key == ACTIVATION_KEY:
                with recording_lock:
                    if not is_recording:
                        is_recording = True
                        last_typed_text = ""
                        print("\n🔴 Enregistrement activé - Parlez maintenant...", flush=True)
    except Exception:
        pass


def on_release(key):
    """Callback quand une touche est relâchée"""
    global is_recording

    # Arrêter l'enregistrement si Space ou Ctrl est relâché
    if key == ACTIVATION_KEY or key == MODIFIER_KEY:
        with recording_lock:
            if is_recording:
                is_recording = False
                print("⏸️  Enregistrement arrêté\n", flush=True)

    # Quitter avec Ctrl+C
    if key == Key.esc:
        print("\n👋 Arrêt du daemon...")
        return False


def main():
    # Démarrer le thread de transcription
    voice_thread = threading.Thread(target=voice_recording_thread, daemon=True)
    voice_thread.start()

    # Démarrer l'écoute des touches
    with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
        try:
            listener.join()
        except KeyboardInterrupt:
            print("\n👋 Arrêt du daemon...")


if __name__ == "__main__":
    main()
