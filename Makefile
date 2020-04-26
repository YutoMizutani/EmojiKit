.DEFAULT_GOAL := all

PROJECT_NAME=EmojiKit
LIBRARY_NAME=EmojiKit
EXECUTABLE_NAME=emojigen
PREFIX=/usr/local
INSTALL_PATH=$(PREFIX)/bin/$(EXECUTABLE_NAME)
DERIVED_DATA_PATH=/Users/$(USER)/Library/Developer/Xcode/DerivedData/*

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
.PHONY: release
release: deps
	swift build -c release

.PHONY: run
run: deps
	swift run $(EXECUTABLE_NAME)

.PHONY: install
install: release
	mkdir -p $(PREFIX)/bin
	cp -f .build/release/$(EXECUTABLE_NAME) $(INSTALL_PATH)
.PHONY: uninstall
uninstall:
	-rm -f $(INSTALL_PATH)

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
	-rm -rf .build
	-rm -rf Example/.build

.PHONY: remove
remove: clean remove-deriveddata
remove-deriveddata:
	-rm -rf $(DERIVED_DATA_PATH)
