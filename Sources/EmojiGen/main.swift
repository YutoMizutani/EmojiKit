import ArgumentParser
import EmojiKit
import Foundation

extension TextAlignment: ExpressibleByArgument {}
extension ImageFormat: ExpressibleByArgument {}

struct EmojiGen: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "emojigen",
                                                    version: "1.2.0")

    @Argument(help: "Emoji text")
    var text: String

    @Option(default: 128,
            help: "Output image width")
    var width: Int

    @Option(default: 128,
            help: "Output image height")
    var height: Int

    @Argument(help: "Output image path")
    var output: String

    @Option(default: 0xFF000000,
            help: "Text color as 0xAARRGGBB")
    var color: UInt32

    @Option(default: 0x00FFFFFF,
            help: "Background color as 0xAARRGGBB")
    var background: UInt32

    @Option(default: .left,
            help: "EmojiKit Text alignment parameters")
    var alignment: TextAlignment

    @Flag(default: false,
          inversion: .prefixedEnableDisable,
          help: "Text size fixed")
    var fixed: Bool

    @Flag(default: true,
          inversion: .prefixedEnableDisable,
          help: "Text stretch")
    var stretch: Bool

    @Option(default: "/System/Library/AssetsV2/com_apple_MobileAsset_Font6/16410f7b0c96b4bb08d952fa04d67cd65a42f1b7.asset/AssetData/YuGothic-Bold.otf",
            help: "Font file path")
    var font: String

    @Option(default: .png,
            help: "Image format")
    var format: ImageFormat

    @Option(default: 100,
            help: "Image quality")
    var quality: Int

    func run() throws {
        EmojiKit().generate(
            text,
            width: width,
            height: height,
            imagePath: output,
            textColor: color,
            backgroundColor: background,
            textAlignment: alignment,
            isSizeFixed: fixed,
            isEnabledStretch: stretch,
            fontPath: font,
            format: format,
            quality: quality
        )
    }
}

EmojiGen.main()
