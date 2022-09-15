SHELL := /bin/bash
MAX_LINE_LENGTH := 100

all: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9 -]+:.*?## / {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-poetry:
	@if [[ "$(shell poetry --version 2>/dev/null)" == *"Poetry"* ]] ; \
	then \
		echo "Poetry found, ok." ; \
	else \
		echo 'Please install poetry first, with e.g.:' ; \
		echo 'make install-poetry' ; \
		exit 1 ; \
	fi

install-poetry:  ## install or update poetry
	pip3 install -U pip
	pip3 install -U "poetry!=1.2.0"

install: check-poetry  ## install project via poetry
	poetry install

update: install-poetry  ## update the sources and installation and generate "conf/requirements.txt"
	poetry update
	poetry export -f requirements.txt --output conf/requirements.txt

lint: ## Run code formatters and linter
	poetry run flynt --fail-on-change --line-length=${MAX_LINE_LENGTH} .
	poetry run isort --check-only .
	poetry run flake8 .

fix-code-style: ## Fix code formatting
	poetry run flynt --line-length=${MAX_LINE_LENGTH} .
	poetry run black --verbose --safe --line-length=${MAX_LINE_LENGTH} --skip-string-normalization .
	poetry run isort .

tox-listenvs: check-poetry ## List all tox test environments
	poetry run tox --listenvs

tox: check-poetry ## Run pytest via tox with all environments
	poetry run tox

pytest: install  ## Run pytest
	poetry run pytest

local-test: install  ## Run local_test.py to run the project locally
	poetry run python3 ./local_test.py

local-diff-settings:  ## Run "manage.py diffsettings" with local test
	poetry run python3 local_test/opt_yunohost/manage.py diffsettings


##############################################################################

.PHONY: help check-poetry install-poetry install update local-test