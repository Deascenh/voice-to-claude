"""Test that all modules can be imported successfully."""


def test_import_main_package():
    """Test that the main package can be imported."""
    import voice_to_claude

    assert voice_to_claude.__version__ == "1.0.0"


def test_import_constants():
    """Test that constants are available."""
    from voice_to_claude import DEFAULT_MODEL_PATH, SAMPLE_RATE
    from voice_to_claude import DEFAULT_SEND_WORD, DEFAULT_QUIT_WORD

    assert isinstance(DEFAULT_MODEL_PATH, str)
    assert SAMPLE_RATE == 16000
    assert DEFAULT_SEND_WORD == "stop"
    assert DEFAULT_QUIT_WORD == "terminé"


def test_scripts_exist():
    """Test that all main scripts exist."""
    from pathlib import Path

    src_path = Path(__file__).parent.parent / "src" / "voice_to_claude"

    assert (src_path / "voice_session.py").exists()
    assert (src_path / "voice_realtime.py").exists()
    assert (src_path / "voice_daemon.py").exists()
    assert (src_path / "voice_to_claude.py").exists()
