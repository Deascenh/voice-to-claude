"""Test that all Python scripts have valid syntax."""
import pytest
import py_compile
from pathlib import Path


def get_python_files():
    """Get all Python files in the src directory."""
    src_path = Path(__file__).parent.parent / "src" / "voice_to_claude"
    return list(src_path.glob("*.py"))


@pytest.mark.parametrize("py_file", get_python_files())
def test_python_syntax(py_file):
    """Test that Python file has valid syntax."""
    try:
        py_compile.compile(str(py_file), doraise=True)
    except py_compile.PyCompileError as e:
        pytest.fail(f"Syntax error in {py_file}: {e}")


def test_all_scripts_are_executable():
    """Test that all main scripts have execute permissions (on Unix)."""
    import os
    import platform

    if platform.system() == "Windows":
        pytest.skip("Skipping execute permission check on Windows")

    src_path = Path(__file__).parent.parent / "src" / "voice_to_claude"
    scripts = [
        "voice_session.py",
        "voice_realtime.py",
        "voice_daemon.py",
        "voice_to_claude.py",
    ]

    for script in scripts:
        script_path = src_path / script
        if script_path.exists():
            assert os.access(script_path, os.X_OK), f"{script} is not executable"
