.DEFAULT_GOAL := all

.PHONY: all
all: clean build generate test

.PHONY: build
build:
	swift build

.PHONY: generate
generate:
	swift package generate-xcodeproj

.PHONY: run
run:
	swift run

.PHONY: test
test:
	swift test

.PHONY: clean
clean:
	swift package clean
