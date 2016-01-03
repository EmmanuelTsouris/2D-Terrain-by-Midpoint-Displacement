//
//  TerrainGenerator.swift
//  2D Terrain by Midpoint Displacement
//
//  Based on Simple 2d Terrain With Midpoint Displacement by Loktar
//  http://www.somethinghitme.com/2013/11/11/simple-2d-terrain-with-midpoint-displacement/
//
//  Swift Conversion Created by Emmanuel Tsouris on 1/3/16.
//
//  The createTerrain function below is a SWIFT representation of Loktar's JavaScript code
//
//  Other portions of this software are released under The MIT License (MIT)
//
//  Copyright (c) 2016 Emmanuel Tsouris
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import Cocoa


// Extends CGFloat to return a random floating point 0.0 to 1.0
public extension CGFloat {
    public static var random:CGFloat {
        get {
            return CGFloat(arc4random()) / 0xFFFFFFFF
        }
    }
}

class TerrainGenerator {
        
    func createTerrain(size: CGSize, var displace: CGFloat, roughness: CGFloat) -> [CGFloat] {
        
        // Power of 2 based on width
        let power = Int(pow(2, ceil(log(size.width) / (log(2)))))
        
        var points = [CGFloat](count: power+1, repeatedValue: 0.0)
        
        // Initial left point
        points[0] = size.height/2 + (CGFloat.random*displace*2) - displace
        
        // Initial right point
        points[power] = size.height/2 + (CGFloat.random*displace*2) - displace

        displace *= roughness
        
        // Split the segments
        for var i = 1; i < power; i*=2 {
            for var j = (power/i)/2; j < power; j+=(power/i) {
                points[j] = ((points[j - (power / i) / 2] + points[j + (power / i) / 2]) / 2);
                points[j] += (CGFloat.random*displace*2) - displace
            }
            
            // Apply rougness to the random range
            displace *= roughness
        }
        
        return points
    }
    
}



