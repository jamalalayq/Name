import XCTest
@testable import Name

final class NameTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Name().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
