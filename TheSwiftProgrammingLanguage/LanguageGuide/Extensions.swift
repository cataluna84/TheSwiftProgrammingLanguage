//
//  Extensions.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 25/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func extensionMain() {
    // Computed Properties
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")      // Prints "One inch is 0.0254 meters"
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")    // Prints "Three feet is 0.914399970739201 meters"
    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")     // Prints "A marathon is 42195.0 meters long"
    
    // Initializers
    let defaultRect = Rect()
    let memberwiseRect = Rect(origin: Point3(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))
    let centerRect = Rect(center: Point3(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
    
    
    // Methods
    3.repetitions {
        print("Hello!")
    }
    
    
    // Mutating Instance Methods
    var someInt = 3
    someInt.square()    // someInt is now 9
    
    
    // Subscripts
    746381295[0]    // returns 5
    746381295[1]    // returns 9
    746381295[2]    // returns 2
    746381295[8]    // returns 7
    746381295[9]    // returns 0, as if you had requested:
    0746381295[9]
    
    
    // Nested Types
    func printIntegerKinds(_ numbers: [Int]) {
        for number in numbers {
            switch number.kind {        // number.kind is already known to be of type Int.Kind. Because of this, all of the Int.Kind case values can be written in shorthand form inside the switch statement, such as .negative rather than Int.Kind.negative
            case .negative:
                print("- ", terminator: "")
            case .zero:
                print("0 ", terminator: "")
            case .positive:
                print("+ ", terminator: "")
            }
        }
        print("")
    }
    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])    // Prints "+ + - 0 - 0 + "
}

// Computed Properties
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

// Initializers
struct Size {
    var width = 0.0, height = 0.0
}
struct Point3 {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point3()
    var size = Size()
}
extension Rect {
    init(center: Point3, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point3(x: originX, y: originY), size: size)
    }
}

extension Int {
    // Methods
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    // Mutating Instance Methods
    mutating func square() {
        self = self * self
    }
    
    // Subscripts
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
    
    // Nested Types
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}


