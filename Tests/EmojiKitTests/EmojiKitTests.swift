import XCTest
@testable import EmojiKit

final class EmojiKitTests: XCTestCase {
    func testE2E() {
        let emojiKit = EmojiKit()
        let imagePath = "./emoji.png"
        XCTAssertNoThrow(
            emojiKit.generate("絵文\n字。", imagePath: imagePath, fontPath: "foo.otf")
        )
    }

    static var allTests = [
        ("testE2E", testE2E),
    ]
}
