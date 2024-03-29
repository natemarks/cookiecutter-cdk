.DEFAULT_GOAL := help

# Determine this makefile's path.
# Be sure to place this BEFORE `include` directives, if any.
SHELL := $(shell which bash)
DEFAULT_BRANCH := main
COMMIT := $(shell git rev-parse HEAD)

CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean-venv: ## re-create virtual env
	[[ -e .venv ]] && rm -rf .venv; \
	python3 -m venv .venv; \
	( \
       . .venv/bin/activate; \
       pip install --upgrade pip; \
       pip install -r requirements.txt; \
    )

pylint: ## run pylint on python files
	( \
       . .venv/bin/activate; \
       bash scripts/pylint.sh; \
    )

black: ## use black to format python files
	( \
       . .venv/bin/activate; \
       bash scripts/black.sh; \
    )

black-check: ## use black to format python files
	( \
       . .venv/bin/activate; \
       bash scripts/black-check.sh; \
    )

shellcheck: ## use black to format python files
	( \
       git ls-files '*.sh' |  xargs shellcheck --format=gcc; \
    )

unittest: ## run test that don't require deployed resources
	( \
       source .venv/bin/activate; \
       python3 -m pytest -v -m "unit" tests/; \
    )

update_golden: ## update test golden files using the current actual results
	( \
       source .venv/bin/activate; \
       python3 -m pytest -v -m "unit" tests/ --update_golden; \
    )

static: black shellcheck pylint unittest ## run all local static checks

clean-cache: ## clean python adn pytest cache data
	@find . -type f -name "*.py[co]" -delete -not -path "./.venv/*"
	@find . -type d -name __pycache__ -not -path "./.venv/*" -exec rm -rf {} \;
	@rm -rf .pytest_cache

git-status: ## require status is clean so we can use undo_edits to put things back
	@status=$$(git status --porcelain); \
	if [ ! -z "$${status}" ]; \
	then \
		echo "Error - working directory is dirty. Commit those changes!"; \
		exit 1; \
	fi


rebase: git-status ## rebase current feature branch on to the default branch
	git fetch && git rebase origin/$(DEFAULT_BRANCH)

.PHONY: build static test artifact	
