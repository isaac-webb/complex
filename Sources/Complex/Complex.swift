//
//  Complex.swift
//
//  Created by Isaac Webb on 5/25/18.
//  Copyright © 2018 Isaac Webb. All rights reserved.
//

import Foundation

public struct Complex {
    // Stored properties
    public var real, imag: Double
    
    // Computed Properties
    var magnitude: Double {
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
    
    var angle: Double {
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
}
