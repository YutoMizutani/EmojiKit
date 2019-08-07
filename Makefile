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
	git submodule update --init --recursive \
	&& cd externals/libemoji \
	&& cmake . \
	&& make
	cp modulemap_template externals/libemoji/include/module.modulemap

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
