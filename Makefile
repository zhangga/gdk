# 当前目录
CUR_DIR=$(shell pwd)
OUT_DIR=$(CUR_DIR)/bin

# 命令
GO_BUILD = CGO_ENABLED=0 go build -trimpath

SERVER_VERSION	?= $(shell git describe --long --tags --dirty --always)
SERVER_VERSION	?= unkonwn
CUR_BRANCH		?= $(shell git branch --show-current)
BUILD_TIME      ?= $(shell date "+%F_%T_%Z")
COMMIT_SHA1     ?= $(shell git show -s --format=%h)
COMMIT_LOG      ?= $(shell git show -s --format=%s)
COMMIT_AUTHOR	?= $(shell git show -s --format=%an)
COMMIT_DATE		?= $(shell git show -s --format=%ad)
VERSION_MSG		?= $(COMMIT_AUTHOR)|$(COMMIT_DATE)|${COMMIT_LOG}
VERSION_PACKAGE	?= gihub.com/zhangga/gdk/version



VERSION_BUILD_LDFLAGS= \
-X "${VERSION_PACKAGE}.Version=${SERVER_VERSION}" \
-X "${VERSION_PACKAGE}.BuildTime=${BUILD_TIME}" \
-X "${VERSION_PACKAGE}.CommitHash=${COMMIT_SHA1}" \
-X "${VERSION_PACKAGE}.Message=${VERSION_MSG}"
.PHONY: build
# build
build:
	$(GO_BUILD) \
	-ldflags '$(VERSION_BUILD_LDFLAGS)' \
	-o $(OUT_DIR)/ \
	.

.PHONY: run
# run
run:
	go run .

.PHONY: test
# run all test
test:
	go mod tidy
	go test -race ./...

.PHONY: lint
# run all lint
lint:
	@echo "Current user is: $(shell whoami)"
	@echo "go env: $(shell go env)"
	go mod tidy
	golangci-lint run -c .golangci.yml ./...

# show help
help:
	@echo ''
	@echo 'Usage:'
	@echo ' make [target]'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
	helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
