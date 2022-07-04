check_version_provided:
ifndef VERSION
	$(error Provide VERSION as env var)
endif

.PHONY: build
## build: builds thumbor docker image
build: check_version_provided
	@docker build -t dffrntlab/thumbor7:${VERSION} ./thumbor

.PHONY: tag
## tag: tags current state
tag: check_version_provided
	@git tag -a "${VERSION}" -m "${VERSION}"
	 git push origin --tags

.PHONY: deploy
## deploy: deploys thumbor docker image to the Docker Hub
deploy: check_version_provided build tag
	@docker push dffrntlab/thumbor7:${VERSION}

.PHONY: help
## help: prints help message
help:
	@echo "docker-thumbor"
	@echo
	@echo "Usage:"
	@echo
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'
	@echo
