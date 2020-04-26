# EmojiKit

![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/YutoMizutani/OperantKit/blob/master/LICENSE)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

📚 Ultimate Emoji Generator library for Swift

<img src="Example/out/emoji.png" width="128" height="128" alt="EmojiKit"><br>

## Requirements

Swift 5.1
Python 3.7

### Make
```sh
$ git clone https://github.com/yonaskolb/EmojiKit.git
$ cd EmojiKit
$ make install
$ make build
```

### Swift Package Manager

**Use as dependency**

Add the following dependency to your Package.swift manifest:

```swift
.package(url: "https://github.com/YutoMizutani/EmojiKit.git", .branch("master")),
```

And then import wherever needed: `import EmojiKit`

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

More usages
- Slack Emoji generator: https://github.com/YutoMizutani/SlackPet#slack-emoji-%E4%BD%9C%E6%88%90

## Parameters

| Key | Description |
|:--|:--|
| text | Emoji text |
| width | Output image width |
| height | Output image height |
| imagePath | Output image path |
| textColor | Text color as 0xAARRGGBB |
| backgroundColor | Background color as 0xAARRGGBB |
| textAlignment | Text alignment |
| isSizeFixed | Text size fixed |
| isEnabledStretch | Text stretch |
| fontPath | Font file path |
| format | Image format |
| quality | Image quality |


More details and parameters are to see [emoji-gen/emojilib](https://github.com/emoji-gen/emojilib) and [emoji-gen/libemoji](https://github.com/emoji-gen/libemoji)

## License

EmojiKit is released under the [MIT License](https://github.com/YutoMizutani/EmojiKit/blob/master/LICENSE).
