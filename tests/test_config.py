"""Test configuration and constants."""

from voice_to_claude import DEFAULT_MODEL_PATH, SAMPLE_RATE
from voice_to_claude import DEFAULT_SEND_WORD, DEFAULT_QUIT_WORD


class TestConfig:
    """Test configuration values."""

    def test_model_path_is_string(self):
        """Test that model path is a string."""
        assert isinstance(DEFAULT_MODEL_PATH, str)
        assert len(DEFAULT_MODEL_PATH) > 0

    def test_sample_rate_is_valid(self):
        """Test that sample rate is a valid audio rate."""
        assert isinstance(SAMPLE_RATE, int)
        assert SAMPLE_RATE in [8000, 16000, 22050, 44100, 48000]

    def test_magic_words_are_strings(self):
        """Test that magic words are non-empty strings."""
        assert isinstance(DEFAULT_SEND_WORD, str)
        assert isinstance(DEFAULT_QUIT_WORD, str)
        assert len(DEFAULT_SEND_WORD) > 0
        assert len(DEFAULT_QUIT_WORD) > 0

    def test_magic_words_are_different(self):
        """Test that send and quit words are different."""
        assert DEFAULT_SEND_WORD != DEFAULT_QUIT_WORD
