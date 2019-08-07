import Foundation
import EmojiLib

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
    var skPaintParameter: String {
        switch self {
        case .left:
            return "kLeft_Align"
        case .center:
            return "kCenter_Align"
        case .right:
            return "kRight_Align"
        }
    }
}

/// EmojiKit Image format parameters
public enum ImageFormat: String {
    case bmp, gif, ico, jpg, png, wbmp, webp

    /// Translate to `SkImageDecoder` parameter
    var skImageDecoderParameter: String {
        switch self {
        case .bmp:
            return "kBMP_Format"
        case .gif:
            return "kGIF_Format"
        case .ico:
            return "kICO_Format"
        case .jpg:
            return "kJPEG_Format"
        case .png:
            return "kPNG_Format"
        case .wbmp:
            return "kWBMP_Format"
        case .webp:
            return "kWEBP_Format"
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
    ///   - align: Text align
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
        params.fText = text.toCString()

        params.fWidth = width
        params.fHeight = height
        params.fColor = textColor
        params.fBackgroundColor = backgroundColor
        params.fTextAlign = textAlignment.skPaintParameter
        params.fTextSizeFixed = isSizeFixed
        params.fDisableStretch = !isEnabledStretch
        params.fTypefaceFile = fontPath.toCString()
        params.fFormat = format.skImageDecoderParameter
        params.fQuality = quality

        var result = EgGenerateResult()
        let error = emoji_generate(UnsafePointer<EgGenerateParams>(&params),
                                   UnsafeMutablePointer<EgGenerateResult>(&result))
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
