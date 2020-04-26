.DEFAULT_GOAL := all

PROJECT_NAME=EmojiKit
LIBRARY_NAME=EmojiKit

.PHONY: all
all: clean build generate test all-example
all-example:
	cd "$(PWD)/Example" \
	&& make all

deps: deps-emojilib
deps-emojilib:
	pip install emojilib --extra-index-url https://repo.fury.io/emoji-gen/

.PHONY: build
build: deps
	swift build

.PHONY: generate
generate:
	swift package generate-xcodeproj

.PHONY: open
open: generate
	open $(PROJECT_NAME).xcodeproj

.PHONY: test
test:
	swift test -c debug

.PHONY: clean
clean:
	swift package clean
