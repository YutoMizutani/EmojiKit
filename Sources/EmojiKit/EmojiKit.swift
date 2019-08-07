import Foundation
import PythonKit

/// EmojiKit Text alignment parameters
public enum TextAlignment: String {
    case left, center, right
}

/// EmojiKit Image format parameters
public enum ImageFormat: String {
    case png, webp
}

public struct EmojiKit {
    /// Translate to emojilib color argv
    func translateColor(_ argb: UInt32) -> String {
        let rgba = (argb >> (3 * 8)) | ((argb << 8) & 0xFFFFFF00)
        return "#\(String(format: "%08x", rgba).uppercased())"
    }

    /// - Warning: Use for testing
    func remove(_ path: String) {
        let os = Python.import("os")
        os.remove(path)
    }

    public init() {}

    /// Generate Emoji image
    ///
    /// - Parameters:
    ///   - text: Emoji text
    ///   - width: Output image width
    ///   - height: Output image height
    ///   - imagePath: Output image path
    ///   - textColor: Text color as 0xAARRGGBB
    ///   - backgroundColor: Background color as 0xAARRGGBB
    ///   - align: Text align
    ///   - isSizeFixed: Text size fixed
    ///   - isEnabledStretch: Text stretch
    ///   - fontPath: Font file path
    ///   - format: Image format
    ///   - quality: Image quality
    public func generate(_ text: String,
                         width: Int = 128,
                         height: Int = 128,
                         imagePath: String,
                         textColor: UInt32 = 0xFF000000,
                         backgroundColor: UInt32 = 0x00FFFFFF,
                         textAlignment: TextAlignment = .center,
                         isSizeFixed: Bool = false,
                         isEnabledStretch: Bool = true,
                         fontPath: String,
                         format: ImageFormat = .png,
                         quality: Int = 100) {
        let emojilib = Python.import("emojilib")
        let data = emojilib.generate(
            text: text,
            width: width,
            height: height,
            color: translateColor(textColor),
            background_color: translateColor(backgroundColor),
            align: textAlignment.rawValue,
            size_fixed: isSizeFixed,
            disable_stretch: !isEnabledStretch,
            typeface_file: fontPath,
            format: format.rawValue,
            quality: quality
        )
        let f = Python.open(imagePath, "wb")
        f.write(data)
    }
}
