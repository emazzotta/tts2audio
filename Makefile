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
	@docker build --file Dockerfile -t emazzotta/tt2audio .

.PHONY: push
push:
	@docker push emazzotta/tt2audio

.PHONY: run
run:
	@docker run --rm emazzotta/tt2audio

.PHONY: release
release:
	@docker run cdrx/rancher-gitlab-deploy upgrade --rancher-url ${RANCHER_URL} --rancher-key ${RANCHER_ACCESS_KEY} --rancher-secret ${RANCHER_SECRET_KEY} --stack telegram-bot --service telegram-bot --sidekicks --wait-for-upgrade-to-finish --finish-upgrade

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
