PROJECT_NAME = EmojiKit

all:
	make clean
	make install
	make build
	make generate
	make test
	make all-example
all-example:
	cd "$(PWD)/Example" \
	&& make all

install:
	make install-emojilib
install-emojilib:
	pip3 install emojilib --extra-index-url https://repo.fury.io/emoji-gen/

build:
	swift build
generate:
	swift package generate-xcodeproj

open:
	open ${PROJECT_NAME}.xcodeproj

test:
	swift test

clean:
	swift package clean