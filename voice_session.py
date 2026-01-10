#!/usr/bin/env python3
"""
Voice to Claude - Session Interactive Continue
Lance Claude Code et permet une conversation continue avec reconnaissance vocale.

Commandes vocales:
- "sloubi" : Envoie le buffer vocal à Claude
- "wakeuteu" : Termine la session

Le clavier reste actif pour répondre aux questions de Claude.
"""
import vosk
import pyaudio
import json
import sys
import os
import subprocess
import threading
import queue
import time
import select
import signal

# Configuration
MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000
SEND_WORD = "sloubi"      # Mot pour envoyer le prompt
QUIT_WORD = "wakeuteu"    # Mot pour quitter

class ClaudeSession:
    def __init__(self):
        self.claude_process = None
        self.voice_buffer = []
        self.running = False
        self.voice_lock = threading.Lock()

        # Queues pour la communication
        self.voice_queue = queue.Queue()

        # Threads
        self.voice_thread = None
        self.stdout_thread = None

    def start_claude(self):
        """Lance le processus Claude Code"""
        print("🚀 Lancement de Claude Code...")
        try:
            # Lancer claude en mode interactif
            self.claude_process = subprocess.Popen(
                ['claude'],
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                bufsize=0,  # Pas de buffering
                universal_newlines=True,
                text=True
            )
            print("✅ Claude Code démarré\n")
            return True
        except FileNotFoundError:
            print("❌ Erreur: 'claude' non trouvé. Installez Claude Code d'abord.")
            return False
        except Exception as e:
            print(f"❌ Erreur au lancement de Claude: {e}")
            return False

    def start_voice_recognition(self):
        """Démarre la reconnaissance vocale en arrière-plan"""
        # Vérifier l'existence du modèle
        if not os.path.exists(MODEL_PATH):
            print(f"❌ Erreur: Modèle non trouvé dans {MODEL_PATH}")
            return False

        self.voice_thread = threading.Thread(target=self._voice_recognition_loop, daemon=True)
        self.voice_thread.start()
        return True

    def _voice_recognition_loop(self):
        """Boucle de reconnaissance vocale (thread séparé)"""
        try:
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

            print("🎤 Reconnaissance vocale activée")
            print(f"   Dites '{SEND_WORD}' pour envoyer votre message à Claude")
            print(f"   Dites '{QUIT_WORD}' pour terminer la session\n")

            last_partial = ""

            while self.running:
                try:
                    data = stream.read(4096, exception_on_overflow=False)

                    if recognizer.AcceptWaveform(data):
                        result = json.loads(recognizer.Result())
                        text = result.get('text', '').strip()

                        if text:
                            # Vérifier les mots magiques
                            text_lower = text.lower()

                            if QUIT_WORD in text_lower:
                                print(f"\n🛑 Mot magique '{QUIT_WORD}' détecté - Fin de session")
                                self.running = False
                                break

                            if SEND_WORD in text_lower:
                                # Retirer le mot "sloubi" du texte
                                text_clean = text_lower.replace(SEND_WORD, '').strip()
                                if text_clean:
                                    with self.voice_lock:
                                        self.voice_buffer.append(text_clean)

                                # Envoyer le buffer à Claude
                                self._send_buffer_to_claude()

                                # Effacer l'affichage partiel
                                if last_partial:
                                    print("\r" + " " * (len(last_partial) + 5), end="\r")
                                    last_partial = ""
                                continue

                            # Ajouter au buffer
                            with self.voice_lock:
                                self.voice_buffer.append(text)

                            print(f"📝 {text}")

                            # Effacer le résultat partiel
                            if last_partial:
                                print("\r" + " " * (len(last_partial) + 5), end="\r")
                                last_partial = ""
                    else:
                        # Résultat partiel
                        partial = json.loads(recognizer.PartialResult())
                        partial_text = partial.get('partial', '')

                        if partial_text != last_partial:
                            print(f"\r💭 {partial_text}", end='', flush=True)
                            last_partial = partial_text

                except Exception as e:
                    if self.running:
                        print(f"\n⚠️  Erreur vocale: {e}")
                    continue

            # Nettoyage
            stream.stop_stream()
            stream.close()
            mic.terminate()

        except Exception as e:
            print(f"❌ Erreur critique reconnaissance vocale: {e}")
            self.running = False

    def _send_buffer_to_claude(self):
        """Envoie le buffer vocal à Claude"""
        with self.voice_lock:
            if not self.voice_buffer:
                print("\n⚠️  Buffer vide - rien à envoyer")
                return

            # Assembler le texte
            full_text = ' '.join(self.voice_buffer).strip()
            self.voice_buffer.clear()

        if not full_text:
            return

        print(f"\n📤 Envoi à Claude: {full_text}")
        print("─" * 60)

        try:
            # Envoyer à Claude via stdin
            self.claude_process.stdin.write(full_text + '\n')
            self.claude_process.stdin.flush()
        except Exception as e:
            print(f"❌ Erreur lors de l'envoi: {e}")

    def start_stdout_reader(self):
        """Démarre le thread de lecture de stdout de Claude"""
        self.stdout_thread = threading.Thread(target=self._read_claude_output, daemon=True)
        self.stdout_thread.start()

    def _read_claude_output(self):
        """Lit et affiche la sortie de Claude (thread séparé)"""
        try:
            while self.running and self.claude_process:
                # Lire ligne par ligne
                line = self.claude_process.stdout.readline()
                if not line:
                    if self.claude_process.poll() is not None:
                        # Claude s'est terminé
                        print("\n⚠️  Claude Code s'est arrêté")
                        self.running = False
                        break
                    continue

                # Afficher la sortie de Claude
                print(line, end='', flush=True)

        except Exception as e:
            if self.running:
                print(f"\n⚠️  Erreur lecture stdout: {e}")

    def handle_keyboard_input(self):
        """Gère l'input clavier pour répondre aux questions de Claude"""
        print("⌨️  Clavier actif pour répondre aux questions de Claude\n")

        try:
            while self.running:
                # Utiliser select pour vérifier si stdin a des données
                # Timeout de 0.5s pour vérifier régulièrement self.running
                if sys.stdin in select.select([sys.stdin], [], [], 0.5)[0]:
                    line = sys.stdin.readline()
                    if line:
                        # Envoyer au processus Claude
                        try:
                            self.claude_process.stdin.write(line)
                            self.claude_process.stdin.flush()
                        except Exception as e:
                            print(f"⚠️  Erreur envoi clavier: {e}")

        except KeyboardInterrupt:
            print("\n\n⚠️  Interruption clavier détectée")
            self.running = False

    def run(self):
        """Lance la session interactive"""
        print("╔════════════════════════════════════════════════════════╗")
        print("║  Voice to Claude - Session Interactive Continue       ║")
        print("╚════════════════════════════════════════════════════════╝\n")

        # Lancer Claude
        if not self.start_claude():
            return

        # Marquer comme actif
        self.running = True

        # Lancer la reconnaissance vocale
        if not self.start_voice_recognition():
            self.cleanup()
            return

        # Lancer le lecteur de sortie Claude
        self.start_stdout_reader()

        # Petite pause pour laisser les threads démarrer
        time.sleep(1)

        try:
            # Boucle principale : gestion de l'input clavier
            self.handle_keyboard_input()
        except KeyboardInterrupt:
            print("\n\n👋 Interruption (Ctrl+C)")
        finally:
            self.cleanup()

    def cleanup(self):
        """Nettoyage et fermeture propre"""
        print("\n\n🧹 Nettoyage en cours...")
        self.running = False

        # Terminer le processus Claude
        if self.claude_process:
            try:
                self.claude_process.terminate()
                self.claude_process.wait(timeout=3)
            except:
                self.claude_process.kill()

        print("✅ Session terminée\n")

def signal_handler(sig, frame):
    """Gestion de Ctrl+C"""
    print("\n\n👋 Signal d'interruption reçu")
    sys.exit(0)

def main():
    # Gestion de Ctrl+C
    signal.signal(signal.SIGINT, signal_handler)

    # Créer et lancer la session
    session = ClaudeSession()
    session.run()

if __name__ == "__main__":
    main()
