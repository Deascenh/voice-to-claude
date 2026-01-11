#!/usr/bin/env python3
import vosk
import pyaudio
import json
import sys
import os

# Configuration
MODEL_PATH = "vosk-model-small-fr-0.22"  # ou vosk-model-fr-0.22
SAMPLE_RATE = 16000
STOP_WORD = "envoyer"  # Mot pour terminer la dictée


def main():
    # Vérifier l'existence du modèle
    if not os.path.exists(MODEL_PATH):
        print(f"Erreur: Modèle non trouvé dans {MODEL_PATH}")
        print("Téléchargez d'abord le modèle français de Vosk")
        sys.exit(1)

    # Initialiser Vosk
    model = vosk.Model(MODEL_PATH)
    recognizer = vosk.KaldiRecognizer(model, SAMPLE_RATE)

    # Initialiser PyAudio
    mic = pyaudio.PyAudio()
    stream = mic.open(
        format=pyaudio.paInt16, channels=1, rate=SAMPLE_RATE, input=True, frames_per_buffer=8192
    )
    stream.start_stream()

    print("🎤 Dictée activée. Parlez votre prompt...")
    print(f"   Dites '{STOP_WORD}' pour terminer et envoyer à Claude Code")
    print("   Ctrl+C pour annuler\n")

    transcription = []

    try:
        while True:
            data = stream.read(4096, exception_on_overflow=False)

            if recognizer.AcceptWaveform(data):
                result = json.loads(recognizer.Result())
                text = result.get("text", "").strip()

                if text:
                    # Vérifier si le mot de fin est prononcé
                    if STOP_WORD in text.lower():
                        # Retirer le mot "envoyer" de la transcription
                        text = text.lower().replace(STOP_WORD, "").strip()
                        if text:
                            transcription.append(text)
                        break

                    transcription.append(text)
                    print(f"📝 {text}")
            else:
                # Résultat partiel (optionnel, pour feedback temps réel)
                partial = json.loads(recognizer.PartialResult())
                partial_text = partial.get("partial", "")
                if partial_text:
                    print(f"\r💭 {partial_text}", end="", flush=True)

    except KeyboardInterrupt:
        print("\n\n❌ Dictée annulée")
        sys.exit(0)

    finally:
        stream.stop_stream()
        stream.close()
        mic.terminate()

    # Assembler et afficher le prompt final
    final_prompt = " ".join(transcription).strip()

    if final_prompt:
        print("\n\n✅ Prompt transcrit :")
        print("─────────────────────────────────────")
        print(final_prompt)
        print("─────────────────────────────────────\n")

        # Copier dans le clipboard (optionnel mais pratique)
        try:
            import subprocess

            subprocess.run(
                ["xclip", "-selection", "clipboard"], input=final_prompt.encode(), check=True
            )
            print("📋 Copié dans le presse-papiers (Ctrl+Shift+V pour coller)")
        except (ImportError, FileNotFoundError, subprocess.CalledProcessError):
            print("💡 Installez xclip pour copie automatique: sudo apt install xclip")

        # Afficher le texte prêt à être collé
        print("\n🚀 Collez maintenant dans Claude Code et appuyez sur Entrée")
    else:
        print("\n⚠️  Aucun texte transcrit")


if __name__ == "__main__":
    main()
