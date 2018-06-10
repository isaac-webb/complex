import XCTest
@testable import Complex

final class ComplexTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Complex().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
