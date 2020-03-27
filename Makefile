# tts2audio build file.
#
# All commands necessary to go from development to release candidate should be here.

CURRENT_DIR = $(shell pwd)
export PATH := $CURRENT_DIR:$(PATH)
export PYTHONPATH := $CURRENT_DIR/api:$(PYTHONPATH)

# -----------------------------------------------------------------------------
# BUILD
# -----------------------------------------------------------------------------
.PHONY: all
all: build

.PHONY: build
build:
	@docker build --file Dockerfile -t emazzotta/tts2audio .

.PHONY: push
push:
	@docker push emazzotta/tts2audio

.PHONY: run
run:
	@docker run --rm emazzotta/tts2audio

.PHONY: release
release:
	@kubectl rollout restart -n telegram-bot deployment.apps/telegram-bot-deployment

# -----------------------------------------------------------------------------
# DEVELOPMENT
# -----------------------------------------------------------------------------
.PHONY: clean
clean:
	@rm -rf .cache
	@rm -rf target
	@rm -f .coverage
	@find . -iname __pycache__ | xargs rm -rf
	@find . -iname "*.pyc" | xargs rm -f
