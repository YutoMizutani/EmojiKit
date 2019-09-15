import Foundation
import CLibemoji

extension String {
    /// Translate to C String parameter
    func toCString() -> UnsafePointer<Int8>? {
        let utf8 = utf8CString
        let count = utf8.count

        var result: UnsafePointer<Int8>?
        return withCString {
            return $0.withMemoryRebound(to: Int8.self, capacity: count) {
                result = $0
                return result
            }
        }
    }
}

/// EmojiKit Text alignment parameters
public enum TextAlignment: String {
    case left, center, right

    /// Translate to `SkPaint` parameter
    var skPaintParameter: EgAlign {
        switch self {
        case .left:
            return kLeft_Align
        case .center:
            return kCenter_Align
        case .right:
            return kRight_Align
        }
    }
}

/// EmojiKit Image format parameters
public enum ImageFormat: String {
    case png, webp

    /// Translate to `SkImageDecoder` parameter
    var skImageDecoderParameter: EgFormat {
        switch self {
        case .png:
            return kPNG_Format
        case .webp:
            return kWEBP_Format
        }
    }
}

public struct EmojiKit {
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
    ///   - textAlignment: Text alignment
    ///   - isSizeFixed: Text size fixed
    ///   - isEnabledStretch: Text stretch
    ///   - fontPath: Font file path
    ///   - format: Image format
    ///   - quality: Image quality
    /// - Returns: Output image path as URL
    public func generate(_ text: String,
                         width: Int = 256,
                         height: Int = 256,
                         imagePath: String,
                         textColor: UInt32 = 0xFF000000,
                         backgroundColor: UInt32 = 0x00FFFFFF,
                         textAlignment: TextAlignment = .center,
                         isSizeFixed: Bool = false,
                         isEnabledStretch: Bool = true,
                         fontPath: String,
                         format: ImageFormat = .png,
                         quality: Int = 100) -> URL? {
        var params: EgGenerateParams = EgGenerateParams()
        print(MemoryLayout.size(ofValue: params))
        memset(UnsafeMutablePointer(&params), 0, MemoryLayout.size(ofValue: params));

        params.fText = text.toCString()
        params.fWidth = UInt32(width)
        params.fHeight = UInt32(height)
        params.fColor = textColor
        params.fBackgroundColor = backgroundColor
        params.fTextAlign = textAlignment.skPaintParameter
        params.fTextSizeFixed = isSizeFixed
        params.fDisableStretch = !isEnabledStretch
        params.fTypefaceFile = fontPath.toCString()
        params.fFormat = format.skImageDecoderParameter
        params.fQuality = Int32(quality)

        var result = EgGenerateResult()
        let error = emoji_generate(UnsafePointer(&params),
                                   UnsafeMutablePointer(&result))
        if error != EG_OK {
            assertionFailure("ERROR: \(error)")
            return nil
        }

        let filePointer: UnsafeMutablePointer<FILE>! = fopen(imagePath, "w")
        fwrite(result.fData, result.fSize, 1, filePointer)
        fclose(filePointer)

        emoji_free(&result)

        return URL(string: imagePath)
    }
}
