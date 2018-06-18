//
//  Complex.swift
//
//  Created by Isaac Webb on 5/25/18.
//  Copyright © 2018 Isaac Webb. All rights reserved.
//

import Foundation

public struct Complex: Equatable, Hashable, Codable {
    // Stored properties
    public var real, imag: Double
    
    // Computed Properties
    public var magnitude: Double {
        get {
            // Get the complex number's magnitude
            return sqrt(real * real + imag * imag)
        }
        set {
            // Capture the number's current polar angle and ensure no arithmetic errors will occur
            let angle = abs(self.angle) <= Double.pi ? self.angle : 0
            real = newValue * cos(angle)
            imag = newValue * sin(angle)
        }
    }
    
    public var angle: Double {
        get {
            let angle = atan(imag / real)
            return abs(angle) <= Double.pi ? angle : 0
        }
        set {
            let magnitude = self.magnitude
            real = magnitude * cos(newValue)
            imag = magnitude * sin(newValue)
        }
    }
    
    // Default constructor
    public init(real: Double = 0, imag: Double = 0) {
        self.real = real
        self.imag = imag
    }
    
    // Allow creation of complex numbers using polar coordinates
    public init(magnitude: Double, angle: Double) {
        self.init(real: magnitude * cos(angle), imag: magnitude * sin(angle))
    }
    
    // Returns the conjugate of the complex number
    public func conjugate() -> Complex {
        return Complex(real: real, imag: -imag)
    }
}

// Implement custom output string
extension Complex: CustomStringConvertible {
    public var description: String {
        return "\(real) \(imag >= 0 ? "+" : "-") \(imag.magnitude)j"
    }
}

// Implement creation from a string description
extension Complex: LosslessStringConvertible {
    public init?(_ description: String) {
        // Split the string into the real, sign, and imaginary parts
        let parts = description.split(separator: " ")
        
        // Attempt to create the components
        if let real = Double(parts[0]), let imag = Double(parts[2].dropLast()) {
            // Assign the parts, determining the sign of the imaginary part
            self.real = real
            self.imag = parts[1] == "+" ? imag : -imag
        } else {
            // One of the components failed, failing the initializer
            return nil
        }
    }
}

// Implement all basic arithmetic
extension Complex: SignedNumeric {
    public typealias IntegerLiteralType = Double
    
    public init(integerLiteral value: Double) {
        real = value
        imag = 0
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        // Ensure the value can be converted to a double
        guard let val = Double(exactly: source) else {
            return nil
        }
        
        // Assign the values
        real = val
        imag = 0
    }
    
    public static func + (lhs: Complex, rhs: Complex) -> Complex {
        // (a + bi) + (c + di)
        let real = lhs.real + rhs.real
        let imag = lhs.imag + rhs.imag
        
        // Return the result
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
        
        // Return the result
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
        
        // Return the result
        return Complex(real: real, imag: imag)
    }
    
    public static func *= (lhs: inout Complex, rhs: Complex) {
        // (a + bi) * (c + di)
        let real = lhs.real * rhs.real - lhs.imag * rhs.imag
        let imag = lhs.real * rhs.imag + lhs.imag * rhs.real
        
        // Assign the result
        lhs.real = real
        lhs.imag = imag
    }
}

// Implement float initialization
extension Complex: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        real = value
        imag = 0
    }
}

// Implement the comparison operators, using magnitude as the basis of comparison
extension Complex: Comparable {
    public static func < (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.magnitude < rhs.magnitude
    }
}

// Enable easier expression of complex numbers
extension Double {
    public var j: Complex {
        return Complex(real: 0, imag: self)
    }
}
