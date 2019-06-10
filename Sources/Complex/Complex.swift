import Foundation

/// Structure that represents a complex number of the form `a + bi`.
public struct Complex: Equatable, Hashable, Codable {
    // MARK: Stored Properties
    /// The real part (`a`) of the complex number in `a + bi` form.
    public var real: Double
    
    /// The imaginary part (`b`) of the complex number in `a + bi` form.
    public var imag: Double
    
    // MARK: Computed Properties
    /// The magnitude of the complex number when represented as a vector in the complex plane.
    public var magnitude: Double {
        get { sqrt(real * real + imag * imag) }
        set {
            // Set the new real and imaginary components based on the current angle.
            let angle = self.angle
            real = newValue * cos(angle)
            imag = newValue * sin(angle)
        }
    }
    
    /// The angle the complex number, represented as a vector, would make with the x-axis in the complex plane.
    public var angle: Double {
        get {
            switch (real, imag) {
            case (0, 0):
                return 0
            case let (x, _) where imag == 0:
                // Vector lies on the x-axis.
                return x < 0 ? Double.pi : 0
            case let (_, y) where real == 0:
                // Vector lies on the y-axis.
                return y < 0 ? -Double.pi / 2 : Double.pi / 2
            default:
                // Correct for tangent's ambiguity as necessary.
                let angle = atan(imag / real)
                if real < 0 {
                    return imag > 0 ? angle + Double.pi : angle - Double.pi
                } else {
                    return angle
                }
            }
        }
        set {
            // Set the new real and imaginary components based on the current magnitude.
            let magnitude = self.magnitude
            real = magnitude * cos(newValue)
            imag = magnitude * sin(newValue)
        }
    }
    
    // MARK: Constructors
    /// Creates a complex number of the form `a + bi` with the provided real and imaginary parts.
    /// - Parameter real: The real part (`a`) of the complex number. Defaults to 0.
    /// - Parameter imag`: The imaginary part (`b`) of the complex number. Defaults to 0.
    public init(real: Double = 0, imag: Double = 0) {
        self.real = real
        self.imag = imag
    }
    
    /// Creates a complex number of the form `r * e^(iθ)` with the provided magnitude and angle (in radians).
    /// - Parameter magnitude: The magnitude (`r`) of the complex number. Defaults to 0.
    /// - Parameter angle: The angle (`θ`) of the complex number (in radians). Defaults to 0.
    public init(magnitude: Double = 0, angle: Double = 0) {
        self.init(real: magnitude * cos(angle), imag: magnitude * sin(angle))
    }
    
    // MARK: Complex Arithmetic Operations
    /// Computes the complex conjugate of the complex number.
    /// - Returns: The complex conjugate.
    public func conjugate() -> Complex {
        return Complex(real: real, imag: -imag)
    }
    
    // TODO: Division by zero
    /// Computes the division of two complex numbers.
    /// - Parameter lhs: The dividend.
    /// - Parameter rhs: The divisor.
    /// - Returns: The quotient.
    public static func / (lhs: Complex, rhs: Complex) -> Complex {
        let magnitude = lhs.magnitude / rhs.magnitude
        let angle = lhs.angle - rhs.angle
        return Complex(magnitude: magnitude, angle: angle)
    }
    
    /// Divides the complex number by another number.
    /// - Parameter lhs: The dividend.
    /// - Parameter rhs: The divisor.
    /// - Returns: The quotient.
    public static func /= (lhs: inout Complex, rhs: Complex) {
        lhs.magnitude /= rhs.magnitude
        lhs.angle -= rhs.angle
    }
}

// MARK: CustomStringConvertible Conformance
/// Provide a custom debug string to show the real and imaginary parts of the complex number.
extension Complex: CustomStringConvertible {
    /// A `String` containing the complex number in `a + bi` form.
    public var description: String {
        return "\(real) \(imag >= 0 ? "+" : "-") \(imag.magnitude)j"
    }
}

// MARK: Codable Conformance
/// Implement creation of a complex number from its string description.
extension Complex: LosslessStringConvertible {
    /// Create a complex number from its corresponding `String`
    public init?(_ description: String) {
        // Split the string into the real, sign, and imaginary parts
        let parts = description.split(separator: " ")
        
        // Check for the proper number of parts in the array
        guard parts.count == 3 else {
            return nil
        }
        
        // Attempt to create the components
        if let real = Double(String(parts.first!)), let imag = Double(String(parts.last!.dropLast())) {
            // Assign the parts, determining the sign of the imaginary part
            self.real = real
            self.imag = parts[1] == "+" ? imag : -imag
        } else {
            // One of the components failed, failing the initializer
            return nil
        }
    }
}

// MARK: SignedNumeric Conformance
/// Implement all basic arithmetic operations to provide `SignedNumeric` conformance.
extension Complex: SignedNumeric {
    /// Defines `Double` as the type upon which this implementation is based.
    public typealias IntegerLiteralType = Double
    
    public init(integerLiteral value: Double) {
        real = value
        imag = 0
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        // Ensure the value can be converted to a double.
        guard let val = Double(exactly: source) else {
            return nil
        }
        
        // Assign the values.
        real = val
        imag = 0
    }
    
    public static func + (lhs: Complex, rhs: Complex) -> Complex {
        // (a + bi) + (c + di)
        let real = lhs.real + rhs.real
        let imag = lhs.imag + rhs.imag
        
        // Return the result.
        return Complex(real: real, imag: imag)
    }
    
    public static func += (lhs: inout Complex, rhs: Complex) {
        // (a + bi) + (c + di)
        lhs.real += rhs.real
        lhs.imag += rhs.imag
    }
    
    public static func - (lhs: Complex, rhs: Complex) -> Complex {
        // (a + bi) - (c + di)
        let real = lhs.real - rhs.real
        let imag = lhs.imag - rhs.imag
        
        // Return the result.
        return Complex(real: real, imag: imag)
    }
    
    public static func -= (lhs: inout Complex, rhs: Complex) {
        // (a + bi) - (c + di)
        lhs.real -= rhs.real
        lhs.imag -= rhs.imag
    }
    
    public static func * (lhs: Complex, rhs: Complex) -> Complex {
        // (a + bi) * (c + di)
        let real = lhs.real * rhs.real - lhs.imag * rhs.imag
        let imag = lhs.real * rhs.imag + lhs.imag * rhs.real
        
        // Return the result.
        return Complex(real: real, imag: imag)
    }
    
    public static func *= (lhs: inout Complex, rhs: Complex) {
        // (a + bi) * (c + di)
        let real = lhs.real * rhs.real - lhs.imag * rhs.imag
        let imag = lhs.real * rhs.imag + lhs.imag * rhs.real
        
        // Assign the result.
        lhs.real = real
        lhs.imag = imag
    }
}

// MARK: Float Constant Initialization
/// Implement floating-point constant initialization.
extension Complex: ExpressibleByFloatLiteral {
    /// Defines `Double` as the type upon which this implementation is based.
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        real = value
        imag = 0
    }
}

// MARK: Comparable Conformance
/// Implement the comparison operators using magnitude as basis.
extension Complex: Comparable {
    public static func < (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.magnitude < rhs.magnitude
    }
}

// MARK: Double Extension
/// Provide a variable, `j`, that facilitates converting `Double`s to complex numbers.
extension Double {
    /// A complex number with an imaginary part equivalent to the `Double`'s value.
    public var j: Complex {
        return Complex(real: 0, imag: self)
    }
}
