//
//  OpaqueTypes.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 7/9/19.
//  Copyright © 2019 Mayank Bhaskar. All rights reserved.
//

import Foundation

func opaqueTypesMain() {
    
    let smallTriangle = Triangle(size: 3)
    debugPrint(smallTriangle.draw())
//    *
//    **
//    ***
    
    // Flipping the shapes vertically
    let flippedTriangle = FlippedShape(shape: smallTriangle)
    debugPrint(flippedTriangle.draw())
//    ***
//    **
//    *
    
    let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
    print(joinedTriangles.draw())
//    *
//    **
//    ***
//    ***
//    **
//    *
    
    // The function makeTrapezoid() returns a trapezoid without exposing the underlying type of that shape
    let trapezoid = makeTrapezoid()
    print(trapezoid.draw())
//     *
//     **
//     **
//     **
//     **
//     *

    
}

// MARK: The problem that opaque types solve
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    
    func draw() -> String {
        var result = [String]()
        
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        
        return result.joined(separator: "\n")
    }
}

// MARK: Generics expose the exact generics types that were used to create that structure/class
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}


/**
 This approach to defining a JoinedShape<T: Shape, U: Shape> structure that joins two shapes together vertically, like the code below shows, results in types like JoinedShape<FlippedShape<Triangle>, Triangle> from joining a flipped triangle with another triangle.
 */
struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}


// MARK: Returning an Opaque Type
struct Square: Shape {
    var size: Int
    
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    
    let trapezoid = JoinedShape(top: top, bottom: JoinedShape(top: middle, bottom: bottom))
    
    return trapezoid
}
