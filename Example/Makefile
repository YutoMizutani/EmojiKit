all:
	make clean
	make build
	make generate
	make test

build:
	swift build -v
generate:
	swift package generate-xcodeproj

run:
	swift run

test:
	swift test -v

clean:
	swift package clean
