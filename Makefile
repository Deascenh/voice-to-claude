.PHONY: help install install-dev test test-watch lint format clean run-session run-realtime run-daemon run-clipboard verify pre-commit setup-venv

# Détection automatique du venv
VENV_DIR := venv
VENV_ACTIVATE := $(VENV_DIR)/bin/activate

# Si le venv existe, on l'utilise automatiquement
ifneq (,$(wildcard $(VENV_ACTIVATE)))
    VENV_BIN := $(VENV_DIR)/bin
    PYTHON := $(VENV_BIN)/python3
    PIP := $(VENV_BIN)/pip
else
    PYTHON := python3
    PIP := $(PYTHON) -m pip
endif

PYTEST := $(PYTHON) -m pytest
BLACK := $(PYTHON) -m black
FLAKE8 := $(PYTHON) -m flake8
MYPY := $(PYTHON) -m mypy

help: ## Afficher ce message d'aide
	@echo "Voice to Claude - Commandes disponibles:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Installer les dépendances de production
	$(PIP) install -r requirements.txt
	@echo "✓ Dépendances installées"

install-dev: ## Installer les dépendances de développement
	$(PIP) install -r requirements-dev.txt
	@echo "✓ Dépendances de dev installées"

install-system: ## Installer les dépendances système (Linux/macOS)
	./scripts/setup.sh

setup-venv: ## Créer l'environnement virtuel Python
	@if [ -d "$(VENV_DIR)" ]; then \
		echo "✓ L'environnement virtuel existe déjà"; \
	else \
		echo "→ Création de l'environnement virtuel..."; \
		python3 -m venv $(VENV_DIR); \
		echo "→ Mise à jour de pip..."; \
		$(VENV_BIN)/pip install --upgrade pip; \
		echo "✓ Environnement virtuel créé dans $(VENV_DIR)/"; \
		echo ""; \
		echo "Pour l'activer manuellement : source $(VENV_ACTIVATE)"; \
		echo "Ou utilisez directement les commandes make (détection automatique)"; \
	fi

test: ## Lancer tous les tests
	$(PYTEST) tests/ --verbose --cov=src/voice_to_claude --cov-report=term-missing

test-fast: ## Lancer les tests rapidement (sans coverage)
	$(PYTEST) tests/ --verbose

test-watch: ## Lancer les tests en mode watch
	$(PYTEST) tests/ --verbose --looponfail

test-one: ## Lancer un test spécifique (usage: make test-one TEST=test_imports)
	$(PYTEST) tests/test_$(TEST).py -v

coverage: ## Générer un rapport de couverture HTML
	$(PYTEST) tests/ --cov=src/voice_to_claude --cov-report=html
	@echo "✓ Rapport de couverture généré dans htmlcov/index.html"

lint: ## Vérifier la qualité du code
	@echo "→ Vérification avec flake8..."
	$(FLAKE8) src/ tests/ --max-line-length=100 --extend-ignore=E203,W503
	@echo "→ Vérification avec mypy..."
	-$(MYPY) src/ --ignore-missing-imports
	@echo "✓ Lint terminé"

format: ## Formater le code avec Black
	$(BLACK) src/ tests/ --line-length=100
	@echo "✓ Code formaté"

format-check: ## Vérifier le formatage sans modifier
	$(BLACK) src/ tests/ --line-length=100 --check

clean: ## Nettoyer les fichiers temporaires
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.coverage" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "htmlcov" -exec rm -rf {} + 2>/dev/null || true
	rm -f coverage.xml
	@echo "✓ Nettoyage terminé"

verify: ## Vérifier que le système est prêt
	./scripts/verify.sh

run-session: ## Lancer le mode session interactive
	./scripts/start_session.sh

run-realtime: ## Lancer le mode temps réel
	$(PYTHON) src/voice_to_claude/voice_realtime.py

run-daemon: ## Lancer le mode daemon
	$(PYTHON) src/voice_to_claude/voice_daemon.py

run-clipboard: ## Lancer le mode copier-coller
	$(PYTHON) src/voice_to_claude/voice_to_claude.py

pre-commit: ## Installer les hooks pre-commit
	$(PIP) install pre-commit
	pre-commit install
	@echo "✓ Pre-commit hooks installés"

pre-commit-run: ## Lancer pre-commit sur tous les fichiers
	pre-commit run --all-files

build: ## Construire le package
	$(PYTHON) -m build
	@echo "✓ Package construit dans dist/"

check-package: ## Vérifier le package construit
	$(PYTHON) -m twine check dist/*

quality: format lint test ## Lancer tous les checks de qualité

ci: install-dev quality ## Simuler le CI en local

all: clean install-dev quality ## Tout installer et vérifier

# Raccourcis
t: test ## Alias pour test
f: format ## Alias pour format
l: lint ## Alias pour lint
c: clean ## Alias pour clean

# Docker (pour le futur)
docker-build: ## Construire l'image Docker (à venir)
	@echo "Docker support coming soon!"

docker-run: ## Lancer dans Docker (à venir)
	@echo "Docker support coming soon!"
