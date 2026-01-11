#!/usr/bin/env python3
"""
Voice to Claude - Session Interactive Continue
Lance Claude Code et permet une conversation continue avec reconnaissance vocale.

Commandes vocales:
- "stop" : Envoie le buffer vocal à Claude
- "terminé" : Termine la session

Le clavier reste actif pour répondre aux questions de Claude.
"""
from typing import Optional, List
import vosk
import pyaudio
import json
import sys
import os
import pty
import select
import threading
import queue
import time
import signal
import termios
import tty

# Configuration
MODEL_PATH = "vosk-model-small-fr-0.22"
SAMPLE_RATE = 16000
SEND_WORD = "stop"  # Mot pour envoyer le prompt
QUIT_WORD = "terminé"  # Mot pour quitter


class ClaudeSession:
    def __init__(self) -> None:
        self.claude_master_fd: Optional[int] = None
        self.claude_pid: Optional[int] = None
        self.voice_buffer: List[str] = []
        self.running: bool = False
        self.voice_lock: threading.Lock = threading.Lock()

        # Queues pour la communication
        self.voice_queue: queue.Queue[str] = queue.Queue()

        # Threads
        self.voice_thread: Optional[threading.Thread] = None
        self.pty_reader_thread: Optional[threading.Thread] = None

    def start_claude(self) -> bool:
        """Lance le processus Claude Code avec un PTY"""
        print("🚀 Lancement de Claude Code...")
        try:
            # Créer un pseudo-terminal
            self.claude_pid, self.claude_master_fd = pty.fork()

            if self.claude_pid == 0:
                # Processus enfant : exécuter claude
                os.execvp("claude", ["claude"])
            else:
                # Processus parent
                print("✅ Claude Code démarré\n")
                return True

        except FileNotFoundError:
            print("❌ Erreur: 'claude' non trouvé. Installez Claude Code d'abord.")
            return False
        except Exception as e:
            print(f"❌ Erreur au lancement de Claude: {e}")
            return False

    def start_voice_recognition(self) -> bool:
        """Démarre la reconnaissance vocale en arrière-plan"""
        # Vérifier l'existence du modèle
        if not os.path.exists(MODEL_PATH):
            print(f"❌ Erreur: Modèle non trouvé dans {MODEL_PATH}")
            return False

        self.voice_thread = threading.Thread(target=self._voice_recognition_loop, daemon=True)
        self.voice_thread.start()
        return True

    def _voice_recognition_loop(self) -> None:
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
                frames_per_buffer=8192,
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
                        text = result.get("text", "").strip()

                        if text:
                            # Vérifier les mots magiques
                            text_lower = text.lower()

                            if QUIT_WORD in text_lower:
                                print(f"\n🛑 Mot magique '{QUIT_WORD}' détecté - Fin de session")
                                self.running = False
                                break

                            if SEND_WORD in text_lower:
                                # Retirer le mot "stop" du texte
                                text_clean = text_lower.replace(SEND_WORD, "").strip()
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
                        partial_text = partial.get("partial", "")

                        if partial_text != last_partial:
                            print(f"\r💭 {partial_text}", end="", flush=True)
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

    def _send_buffer_to_claude(self) -> None:
        """Envoie le buffer vocal à Claude"""
        with self.voice_lock:
            if not self.voice_buffer:
                print("\n⚠️  Buffer vide - rien à envoyer")
                return

            # Assembler le texte
            full_text = " ".join(self.voice_buffer).strip()
            self.voice_buffer.clear()

        if not full_text:
            return

        print(f"\n📤 Envoi à Claude: {full_text}")
        print("─" * 60)

        try:
            if self.claude_master_fd is None:
                print("❌ Erreur: Connexion à Claude perdue")
                return

            # Envoyer à Claude via le PTY - simuler la frappe caractère par caractère
            for char in full_text:
                os.write(self.claude_master_fd, char.encode("utf-8"))
                time.sleep(0.01)  # Petit délai pour simuler la frappe humaine

            # Envoyer Enter (carriage return + line feed pour compatibilité maximale)
            os.write(self.claude_master_fd, b"\r")
            time.sleep(0.05)
            os.write(self.claude_master_fd, b"\n")

            # Forcer le flush du buffer PTY
            try:
                termios.tcdrain(self.claude_master_fd)
            except Exception:
                pass  # Ignorer les erreurs de tcdrain (non critique)

            # Petit délai pour laisser Claude traiter la commande
            time.sleep(0.2)

        except OSError as e:
            print(f"❌ Erreur d'envoi: {e}")
        except Exception as e:
            print(f"❌ Erreur lors de l'envoi: {e}")

    def start_pty_reader(self) -> None:
        """Démarre le thread de lecture du PTY de Claude"""
        self.pty_reader_thread = threading.Thread(target=self._read_pty_output, daemon=True)
        self.pty_reader_thread.start()

    def _read_pty_output(self) -> None:
        """Lit et affiche la sortie du PTY de Claude (thread séparé)"""
        if self.claude_master_fd is None:
            return

        try:
            while self.running:
                # Utiliser select pour vérifier si des données sont disponibles
                r, _, _ = select.select([self.claude_master_fd], [], [], 0.1)

                if r:
                    try:
                        data = os.read(self.claude_master_fd, 1024)
                        if data:
                            output = data.decode("utf-8", errors="replace")
                            print(output, end="", flush=True)
                        else:
                            # EOF - Claude s'est terminé
                            print("\n⚠️  Claude Code s'est arrêté")
                            self.running = False
                            break
                    except OSError as e:
                        print(f"\n⚠️  Erreur de lecture: {e}")
                        self.running = False
                        break

        except Exception as e:
            if self.running:
                print(f"\n⚠️  Erreur critique: {e}")

    def handle_keyboard_input(self) -> None:
        """Gère l'input clavier pour répondre aux questions de Claude"""
        print("⌨️  Clavier actif pour répondre aux questions de Claude\n")

        # Sauvegarder les paramètres du terminal
        old_settings = termios.tcgetattr(sys.stdin)

        try:
            # Mettre le terminal en mode raw pour capturer chaque caractère
            tty.setcbreak(sys.stdin.fileno())

            while self.running:
                # Utiliser select pour vérifier si stdin a des données
                # Timeout de 0.5s pour vérifier régulièrement self.running
                if sys.stdin in select.select([sys.stdin], [], [], 0.5)[0]:
                    char = sys.stdin.read(1)
                    if char:
                        # Envoyer au PTY de Claude
                        try:
                            if self.claude_master_fd is not None:
                                os.write(self.claude_master_fd, char.encode("utf-8"))
                        except Exception as e:
                            print(f"⚠️  Erreur envoi clavier: {e}")

        except KeyboardInterrupt:
            print("\n\n⚠️  Interruption clavier détectée")
            self.running = False
        finally:
            # Restaurer les paramètres du terminal
            termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_settings)

    def run(self) -> None:
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
        self.start_pty_reader()

        # Petite pause pour laisser les threads démarrer
        time.sleep(2)

        try:
            # Boucle principale : gestion de l'input clavier
            self.handle_keyboard_input()
        except KeyboardInterrupt:
            print("\n\n👋 Interruption (Ctrl+C)")
        finally:
            # Toujours cleanup Claude et le micro
            self.cleanup()

            # Attendre que l'utilisateur ferme le terminal manuellement
            print("\n" + "=" * 60)
            print("   Session terminée. Fermez ce terminal manuellement.")
            print("=" * 60)
            input("\nAppuyez sur Entrée pour fermer...")

    def cleanup(self) -> None:
        """Nettoyage et fermeture propre"""
        print("\n\n🧹 Nettoyage en cours...")
        self.running = False

        # Attendre un peu que les threads se terminent proprement
        time.sleep(0.5)

        # Terminer le processus Claude
        if self.claude_pid:
            try:
                os.kill(self.claude_pid, signal.SIGTERM)
                os.waitpid(self.claude_pid, 0)
            except Exception:
                try:
                    os.kill(self.claude_pid, signal.SIGKILL)
                except Exception:
                    pass

        # Fermer le PTY après avoir terminé le processus
        if self.claude_master_fd is not None:
            try:
                os.close(self.claude_master_fd)
            except Exception:
                pass

        print("✅ Session terminée\n")


def signal_handler(sig: int, frame: object) -> None:
    """Gestion de Ctrl+C"""
    print("\n\n👋 Signal d'interruption reçu")
    sys.exit(0)


def main() -> None:
    """Point d'entrée principal de l'application"""
    # Gestion de Ctrl+C
    signal.signal(signal.SIGINT, signal_handler)

    # Créer et lancer la session
    session = ClaudeSession()
    session.run()


if __name__ == "__main__":
    main()
