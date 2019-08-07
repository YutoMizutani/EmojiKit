all:
	make clean
	make build
	make generate
	make test

build:
	swift build
generate:
	swift package generate-xcodeproj

run:
	swift run

test:
	swift test

clean:
	swift package clean