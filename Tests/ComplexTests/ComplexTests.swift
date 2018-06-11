import XCTest
@testable import Complex

final class ComplexTests: XCTestCase {
    let tolerance = 1e-5
    
    // Test the default constructor for a complex number
    func testRealImagConstructor() {
        let z = Complex(real: 1, imag: 2)
        XCTAssertEqual(z.real, 1)
        XCTAssertEqual(z.imag, 2)
    }
    
    // Test the polar constructor for a complex number
    func testPolarConstructor() {
        let z = Complex(magnitude: 1, angle: Double.pi / 3)
        XCTAssertEqual(z.real, 0.5, accuracy: tolerance)
        XCTAssertEqual(z.imag, sqrt(3) / 2, accuracy: tolerance)
    }
    
    // Test the computed magnitude property getter
    func testMagnitudePropertyGetter() {
        var z = Complex(real: 0, imag: 0)
        XCTAssertEqual(z.magnitude, 0, accuracy: tolerance)
        z.real = 1
        XCTAssertEqual(z.magnitude, 1, accuracy: tolerance)
        z.imag = 1
        XCTAssertEqual(z.magnitude, sqrt(2), accuracy: tolerance)
    }
    
    // Test the computed magnitude property setter
    func testMagnitudePropertySetter() {
        var z = Complex(real: 0, imag: 0)
        XCTAssertEqual(z.magnitude, 0, accuracy: tolerance)
        z.magnitude = 1
        XCTAssertEqual(z.magnitude, 1, accuracy: tolerance)
        XCTAssertEqual(z.real, 1, accuracy: tolerance)
        XCTAssertEqual(z.imag, 0, accuracy: tolerance)
        z.imag = 1
        z.magnitude = 1
        XCTAssertEqual(z.real, sqrt(2) / 2, accuracy: tolerance)
        XCTAssertEqual(z.imag, sqrt(2) / 2, accuracy: tolerance)
    }
    
    // Test the computed angle property getter
    func testAnglePropertyGetter() {
        var z = Complex(real: 0, imag: 0)
        XCTAssertEqual(z.angle, 0, accuracy: tolerance)
        z.real = 1
        z.imag = 0
        XCTAssertEqual(z.angle, 0, accuracy: tolerance)
        z.imag = 1
        XCTAssertEqual(z.angle, Double.pi / 4, accuracy: tolerance)
    }
    
    // Test the computed magnitude property setter
    func testAnglePropertySetter() {
        var z = Complex(real: 1, imag: 0)
        XCTAssertEqual(z.real, 1, accuracy: tolerance)
        XCTAssertEqual(z.imag, 0, accuracy: tolerance)
        z.angle = Double.pi / 3
        XCTAssertEqual(z.magnitude, 1, accuracy: tolerance)
        XCTAssertEqual(z.real, 0.5, accuracy: tolerance)
        XCTAssertEqual(z.imag, sqrt(3) / 2, accuracy: tolerance)
        z.angle = Double.pi / 2
        XCTAssertEqual(z.real, 0, accuracy: tolerance)
        XCTAssertEqual(z.imag, 1, accuracy: tolerance)
    }
    
    // Test the custom debug string
    func testDebugString() {
        var z = Complex(real: 1, imag: 0)
        XCTAssertEqual(z.debugDescription, "1.0 + 0.0j")
        z.imag = 1
        z.real = -1
        XCTAssertEqual(z.debugDescription, "-1.0 + 1.0j")
        z.imag = -1
        XCTAssertEqual(z.debugDescription, "-1.0 - 1.0j")
    }
    
    // Test the equality operator
    func testEquality() {
        let z1 = Complex(real: 1, imag: 1)
        var z2 = Complex(real: 1, imag: -1)
        XCTAssert(z1 != z2)
        z2.imag = 1
        XCTAssert(z1 == z2)
    }
    
    // Test initialization by an integer
    func testIntegerLiteral() {
        let z: Complex = 1
        XCTAssertEqual(z.real, 1)
        XCTAssertEqual(z.imag, 0)
    }
    
    // Test exactly initialization
//    func testExactly() {
//        let z = Complex(exactly: 1) ?? 0
//        XCTAssertEqual(z.real, 1)
//        XCTAssertEqual(z.imag, 0)
//    }
    
    // Test addition operator
    func testAddition() {
        let z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: 3, imag: 4)
        let z3 = z1 + z2
        XCTAssertEqual(z3.real, 4)
        XCTAssertEqual(z3.imag, 6)
    }
    
    // Test mutating addition operator
    func testMutatingAddition() {
        var z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: -2, imag: -1)
        z1 += z2
        XCTAssertEqual(z1.real, -1)
        XCTAssertEqual(z1.imag, 1)
    }
    
    // Test subtraction operator
    func testSubtraction() {
        let z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: 3, imag: 4)
        let z3 = z1 - z2
        XCTAssertEqual(z3.real, -2)
        XCTAssertEqual(z3.imag, -2)
    }
    
    // Test mutating subtraction operator
    func testMutatingSubtraction() {
        var z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: -2, imag: -1)
        z1 -= z2
        XCTAssertEqual(z1.real, 3)
        XCTAssertEqual(z1.imag, 3)
    }
    
    static var allTests = [
        ("testRealImagConstructor", testRealImagConstructor),
        ("testPolarConstructor", testPolarConstructor),
        ("testMagnitudePropertyGetter", testMagnitudePropertyGetter),
        ("testMagnitudePropertySetter", testMagnitudePropertySetter),
        ("testAnglePropertyGetter", testAnglePropertyGetter),
        ("testAnglePropertySetter", testAnglePropertySetter),
        ("testDebugString", testDebugString),
        ("testEquality", testEquality),
        ("testIntegerLiteral", testIntegerLiteral),
        ("testAddition", testAddition),
        ("testMutatingAddition", testMutatingAddition),
        ("testSubtraction", testSubtraction),
        ("testMutatingSubtraction", testMutatingSubtraction)
    ]
}
