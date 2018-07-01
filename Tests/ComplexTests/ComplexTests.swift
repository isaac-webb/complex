import XCTest
@testable import Complex

final class ComplexTests: XCTestCase {
    // Tolerance for comparing floating point values, fixing inaccuracy of trig
    // functions.
    let tolerance = 1e-10
    
    // Test the default constructor for a complex number.
    func testRealImagConstructor() {
        let z = Complex(real: 1, imag: 2)
        XCTAssertEqual(z.real, 1)
        XCTAssertEqual(z.imag, 2)
    }
    
    // Test the polar constructor for a complex number.
    func testPolarConstructor() {
        let z = Complex(magnitude: 1, angle: Double.pi / 3)
        XCTAssertEqual(z.real, 0.5, accuracy: tolerance)
        XCTAssertEqual(z.imag, sqrt(3) / 2, accuracy: tolerance)
    }
    
    // Test the computed magnitude property getter.
    func testMagnitudePropertyGetter() {
        var z = Complex(real: 0, imag: 0)
        XCTAssertEqual(z.magnitude, 0, accuracy: tolerance)
        z.real = 1
        XCTAssertEqual(z.magnitude, 1, accuracy: tolerance)
        z.imag = 1
        XCTAssertEqual(z.magnitude, sqrt(2), accuracy: tolerance)
    }
    
    // Test the computed magnitude property setter.
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
    
    // Test the computed angle property getter.
    func testAnglePropertyGetter() {
        var z = Complex(real: 0, imag: 0)
        XCTAssertEqual(z.angle, 0, accuracy: tolerance)
        z.real = 1
        XCTAssertEqual(z.angle, 0, accuracy: tolerance)
        z.real = -1
        XCTAssertEqual(z.angle, Double.pi, accuracy: tolerance)
        z.real = 0
        z.imag = 1
        XCTAssertEqual(z.angle, Double.pi / 2, accuracy: tolerance)
        z.imag = -1
        XCTAssertEqual(z.angle, -Double.pi / 2, accuracy: tolerance)
        z.real = 1
        z.imag = 1
        XCTAssertEqual(z.angle, Double.pi / 4, accuracy: tolerance)
        z.real = -1
        XCTAssertEqual(z.angle, 3 * Double.pi / 4, accuracy: tolerance)
        z.imag = -1
        XCTAssertEqual(z.angle, -3 * Double.pi / 4, accuracy: tolerance)
        z.real = 1
        XCTAssertEqual(z.angle, -Double.pi / 4, accuracy: tolerance)
    }
    
    // Test the computed magnitude property setter.
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
    
    // Test complex number conjugation.
    func testConjugate() {
        let z = Complex(real: 1, imag: 1)
        let conj = z.conjugate()
        XCTAssertEqual(conj.real, 1)
        XCTAssertEqual(conj.imag, -1)
    }
    
    // Test the custom string representation.
    func testDescription() {
        var z = Complex(real: 1, imag: 0)
        XCTAssertEqual(String(describing: z), "1.0 + 0.0j")
        z.imag = 1
        z.real = -1
        XCTAssertEqual(String(describing: z), "-1.0 + 1.0j")
        z.imag = -1
        XCTAssertEqual(String(describing: z), "-1.0 - 1.0j")
    }
    
    // Test the custom string constructor.
    func testStringConstructor() {
        let z1 = Complex("1.0 + 0.0j")
        XCTAssertNotNil(z1)
        XCTAssertEqual(z1!.real, 1)
        XCTAssertEqual(z1!.imag, 0)
        let z2 = Complex("-1.0 + 1.0j")
        XCTAssertNotNil(z2)
        XCTAssertEqual(z2!.real, -1)
        XCTAssertEqual(z2!.imag, 1)
        let z3 = Complex("-1.0 - 1.0j")
        XCTAssertNotNil(z3)
        XCTAssertEqual(z3!.real, -1)
        XCTAssertEqual(z3!.imag, -1)
        let z4 = Complex("abc")
        XCTAssertNil(z4)
        let z5 = Complex("1.0 + abcj")
        XCTAssertNil(z5)
    }
    
    // Test the equality operator.
    func testEquality() {
        let z1 = Complex(real: 1, imag: 1)
        var z2 = Complex(real: 1, imag: -1)
        XCTAssert(z1 != z2)
        z2.imag = 1
        XCTAssert(z1 == z2)
    }
    
    // Test the comparison operators.
    func testComparison() {
        let z1 = Complex(real: 1, imag: 1)
        var z2 = Complex(real: 1, imag: -1)
        XCTAssert(!(z1 > z2))
        XCTAssert(z1 >= z2)
        z2.imag = 2
        XCTAssert(z1 < z2)
    }
    
    // Test initialization by an integer.
    func testIntegerLiteral() {
        let z: Complex = 1
        XCTAssertEqual(z.real, 1)
        XCTAssertEqual(z.imag, 0)
    }
    
    // Test initialization by a double.
    func testFloatLiteral() {
        let z: Complex = 1.0
        XCTAssertEqual(z.real, 1)
        XCTAssertEqual(z.imag, 0)
    }
    
    // Test exactly initialization.
    // TODO: Fix fatal error here.
//    func testExactly() {
//        let z = Complex(exactly: 1) ?? 0
//        XCTAssertEqual(z.real, 1)
//        XCTAssertEqual(z.imag, 0)
//    }
    
    // Test negation operator.
    func testNegation() {
        let z1 = Complex(real: 1, imag: 2)
        XCTAssertEqual((-z1).real, -1)
        XCTAssertEqual((-z1).imag, -2)
    }
    
    // Test addition operator.
    func testAddition() {
        let z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: 3, imag: 4)
        let z3 = z1 + z2
        XCTAssertEqual(z3.real, 4)
        XCTAssertEqual(z3.imag, 6)
    }
    
    // Test mutating addition operator.
    func testMutatingAddition() {
        var z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: -2, imag: -1)
        z1 += z2
        XCTAssertEqual(z1.real, -1)
        XCTAssertEqual(z1.imag, 1)
    }
    
    // Test subtraction operator.
    func testSubtraction() {
        let z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: 3, imag: 4)
        let z3 = z1 - z2
        XCTAssertEqual(z3.real, -2)
        XCTAssertEqual(z3.imag, -2)
    }
    
    // Test mutating subtraction operator.
    func testMutatingSubtraction() {
        var z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: -2, imag: -1)
        z1 -= z2
        XCTAssertEqual(z1.real, 3)
        XCTAssertEqual(z1.imag, 3)
    }
    
    // Test multiplication operator.
    func testMultiplication() {
        let z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: 3, imag: 4)
        let z3 = z1 * z2
        XCTAssertEqual(z3.real, -5)
        XCTAssertEqual(z3.imag, 10)
    }
    
    // Test mutating multiplication operator.
    func testMutatingMultiplication() {
        var z1 = Complex(real: 1, imag: 2)
        let z2 = Complex(real: -2, imag: -1)
        z1 *= z2
        XCTAssertEqual(z1.real, 0)
        XCTAssertEqual(z1.imag, -5)
    }
    
    // Test division operator.
    func testDivision() {
        let z1 = Complex(real: 3, imag: 5)
        let z2 = Complex(real: 2, imag: 6)
        let z3 = z1 / z2
        XCTAssertEqual(z3.real, 0.9, accuracy: tolerance)
        XCTAssertEqual(z3.imag, -0.2, accuracy: tolerance)
    }
    
    // Test mutating division operator.
    func testMutatingDivision() {
        var z1 = Complex(real: 3, imag: -2)
        let z2 = Complex(real: -3, imag: 2)
        z1 /= z2
        XCTAssertEqual(z1.real, -1, accuracy: tolerance)
        XCTAssertEqual(z1.imag, 0, accuracy: tolerance)
    }
    
    // Test the easier imaginary number.
    func testDoubleImaginary() {
        let z = 1.j
        XCTAssertEqual(z.real, 0)
        XCTAssertEqual(z.imag, 1)
    }
    
    static var allTests = [
        ("testRealImagConstructor", testRealImagConstructor),
        ("testPolarConstructor", testPolarConstructor),
        ("testMagnitudePropertyGetter", testMagnitudePropertyGetter),
        ("testMagnitudePropertySetter", testMagnitudePropertySetter),
        ("testAnglePropertyGetter", testAnglePropertyGetter),
        ("testAnglePropertySetter", testAnglePropertySetter),
        ("testConjugate", testConjugate),
        ("testDescription", testDescription),
        ("testStringConstructor", testStringConstructor),
        ("testEquality", testEquality),
        ("testComparison", testComparison),
        ("testIntegerLiteral", testIntegerLiteral),
        ("testFloatLiteral", testFloatLiteral),
        ("testNegation", testNegation),
        ("testAddition", testAddition),
        ("testMutatingAddition", testMutatingAddition),
        ("testSubtraction", testSubtraction),
        ("testMutatingSubtraction", testMutatingSubtraction),
        ("testMultiplication", testMultiplication),
        ("testMutatingMultiplication", testMutatingMultiplication),
        ("testDivision", testDivision),
        ("testMutatingDivision", testMutatingDivision),
        ("testDoubleImaginary", testDoubleImaginary),
    ]
}
