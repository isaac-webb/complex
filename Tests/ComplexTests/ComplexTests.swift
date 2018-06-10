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
    
    static var allTests = [
        ("testRealImagConstructor", testRealImagConstructor),
        ("testPolarConstructor", testPolarConstructor),
        ("testMagnitudePropertyGetter", testMagnitudePropertyGetter),
        ("testMagnitudePropertySetter", testMagnitudePropertySetter),
        ("testAnglePropertyGetter", testAnglePropertyGetter),
        ("testAnglePropertySetter", testAnglePropertySetter)
    ]
}
