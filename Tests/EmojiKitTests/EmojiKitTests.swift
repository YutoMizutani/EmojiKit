import XCTest
@testable import EmojiKit

final class EmojiKitTests: XCTestCase {
    func testTranslateColor() {
        XCTAssertEqual(EmojiKit().translateColor(0xFF000000), "#000000FF")
    }

    func testE2E() {
        let emojiKit = EmojiKit()
        let imagePath = "./emoji.png"
        XCTAssertNoThrow(
            emojiKit.generate("絵文\n字。", imagePath: imagePath, fontPath: "foo.otf")
        )
        XCTAssertNoThrow(
            emojiKit.remove(imagePath)
        )
    }

    static var allTests = [
        ("testTranslateColor", testTranslateColor),
        ("testE2E", testE2E)
    ]
}

