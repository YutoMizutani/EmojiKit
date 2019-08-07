# EmojiKit

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/YutoMizutani/OperantKit/blob/master/LICENSE)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

📚 Ultimate Emoji Generator library for Swift

## Requirements

EmojiKit requires Swift 5 or higher.

## Swift Package Manager

Add the following dependency to your Package.swift manifest:

```swift
.package(url: "https://github.com/YutoMizutani/EmojiKit.git", .branch("master")),
```

## Example

```swift
import EmojiKit

EmojiKit().generate(
    "絵文\n字。",
    imagePath: "out/emoji.png",
    textAlignment: .left,
    fontPath: "static/NotoSansMonoCJKjp-Bold.otf"
)
```

## How to build

```
$ make install
$ make build
```

## Parameters

| Key | Description |
|:--|:--|
| text | Emoji text |
| width | Output image width |
| height | Output image height |
| imagePath | Output image path |
| textColor | Text color as 0xAARRGGBB |
| backgroundColor | Background color as 0xAARRGGBB |
| align | Text align |
| isSizeFixed | Text size fixed |
| isEnabledStretch | Text stretch |
| fontPath | Font file path |
| format | Image format |
| quality | Image quality |


More details and parameters are to see [emoji-gen/emojilib](https://github.com/emoji-gen/emojilib) and [emoji-gen/libemoji](https://github.com/emoji-gen/libemoji)

## License

EmojiKit is released under the [MIT License](https://github.com/YutoMizutani/EmojiKit/blob/master/LICENSE).