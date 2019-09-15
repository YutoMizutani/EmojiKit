PROJECT_NAME = EmojiKit

all:
	make clean
	make build
	make generate
	make test
	make all-example
all-example:
	cd "$(PWD)/Example" \
	&& make all
run:
	make all
	cd "$(PWD)/Example" \
		&& make run

build:
	make build-libemoji
	make build-emojikit
build-libemoji:
	# https://github.com/emoji-gen/libemoji#how-to-build
	git submodule update --init --recursive \
		&& cd externals/libemoji \
		&& cmake . \
		&& make
build-emojikit:
	swift build -v

generate:
	swift package generate-xcodeproj

open:
	open ${PROJECT_NAME}.xcodeproj

test:
	swift test -v

clean:
	swift package clean
