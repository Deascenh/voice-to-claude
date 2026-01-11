"""Pytest configuration and fixtures for voice-to-claude tests."""
import pytest
import sys
from pathlib import Path

# Add src to path for imports
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))


@pytest.fixture
def mock_vosk_model(mocker):
    """Mock Vosk model to avoid loading real model in tests."""
    mock_model = mocker.Mock()
    mocker.patch("vosk.Model", return_value=mock_model)
    return mock_model


@pytest.fixture
def mock_pyaudio(mocker):
    """Mock PyAudio to avoid requiring audio hardware in tests."""
    mock_audio = mocker.Mock()
    mock_stream = mocker.Mock()
    mock_audio.open.return_value = mock_stream
    mocker.patch("pyaudio.PyAudio", return_value=mock_audio)
    return mock_audio


@pytest.fixture
def mock_kaldi_recognizer(mocker):
    """Mock Vosk KaldiRecognizer."""
    mock_recognizer = mocker.Mock()
    mocker.patch("vosk.KaldiRecognizer", return_value=mock_recognizer)
    return mock_recognizer
