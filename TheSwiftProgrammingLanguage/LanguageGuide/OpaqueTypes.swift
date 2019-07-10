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

    let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
    print(opaqueJoinedTriangles.draw())
//    *
//    **
//    ***
//    ***
//    **
//    *
    

// Swift can infer associated types, which lets you use an opaque return value in places where a protocol type can’t be used as a return value.
// Using associatedType in ContainerOpaque protocol
    let opaqueContainer = makeOpaqueContainer(item: 12)
    let twelve = opaqueContainer[0]
    print(type(of: twelve))
    // prints: "Int"
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

// MARK: Combining opaque return types with generics
func flip<T: Shape>(_ shape: T) -> some Shape {
    FlippedShape(shape: shape)      // implicit return added in Swift 5.1
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

/*
 If a function with an opaque return type returns from multiple places, all of the possible return values must have the same type. For a generic function, that return type can use the function’s generic type parameters, but it must still be a single type.
 */
// MARK: Error with the following function
/*
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
    if shape is Square {
        return shape
    }
    
    return FlippedShape(shape: shape)
}
 */

/*
 The requirement to always return a single type doesn’t prevent you from using generics in an opaque return type. Here’s an example of a function that incorporates its type parameter into the underlying type of the value it returns:
 */
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}

// MARK: Differences Between Opaque Types and Protocol Types
/*
 protoFlip(_:) makes a much looser API contract with its caller than invalidFlip(_:) makes. It reserves the flexibility to return values of multiple types:
 */
func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }
    
    return FlippedShape(shape: shape)
}

// Opaque types preserve the identity of the underlying type
protocol ContainerOpaque {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension Array: ContainerOpaque { }

// MARK: Error: Protocol with associated types can't be used as a return type.
/*
func makeProtocolContainer<T>(item: T) -> ContainerOpaque {
    return [item]
}
// MARK: Error: Not enough information to infer C.
func makeProtocolContainer<T, C: ContainerOpaque>(item: T) -> C {
    return [item]
}
 */


func makeOpaqueContainer<T>(item: T) -> some ContainerOpaque {
    return [item]
}
