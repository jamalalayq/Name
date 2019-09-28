import XCTest
@testable import Name

final class NameTests: XCTestCase {
   
    func testValidation() {
        let name: Name = "Jamal alayq"
        XCTAssertTrue(name.isValid)
    }
    
    /*static var allTests = [
        ("testExample", testExample),
    ]*/
}
