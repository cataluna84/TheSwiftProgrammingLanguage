//
//  Methods.swift
//
//  Created by Mayank Bhaskar on 02/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func methodsMain() {

    mutatingMethods()
    
    
}


func mutatingMethods() {
    // Modifying Value Types from Within Instance Methods
    struct Point2 {
        var x = 0.0, y = 0.0
        
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
    
    var somePoint = Point2(x: 1.0, y: 1.0)
    somePoint.moveBy(x: 2.0, y: 3.0)
    print("The point is now at (\(somePoint.x), \(somePoint.y))")
    // Prints "The point is now at (3.0, 4.0)"
    
    let fixedPoint = Point2(x: 3.0, y: 3.0)
    //fixedPoint.moveBy(x: 2.0, y: 3.0)     // this will report an error
    
    
    
    // Assigning to self within a Mutating Method
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            self = Point(x: x + deltaX, y: y + deltaY)
        }
    }
    
    enum TriStateSwitch {
        case off, low, high
        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }
    var ovenLight = TriStateSwitch.low
    ovenLight.next()
    // ovenLight is now equal to .high
    ovenLight.next()
}


func typeMethods() {
    
    // indicate type methods by writing the static keyword before the method’s func keyword. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.
    class SomeClass {
        class func someTypeMethod() {
            // type method implementation goes here
        }
    }
    SomeClass.someTypeMethod()
    
    // LevelTracker example
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        var currentLevel = 1
        
        static func unlock(_ level: Int) {
            if level > highestUnlockedLevel { highestUnlockedLevel = level }
        }
        
        static func isUnlocked(_ level: Int) -> Bool {
            return level <= highestUnlockedLevel
        }
        
        @discardableResult
        mutating func advance(to level: Int) -> Bool {
            if LevelTracker.isUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
        }
    }
    
    class Player {
        var tracker = LevelTracker()
        let playerName: String
        func complete(level: Int) {
            LevelTracker.unlock(level + 1)
            tracker.advance(to: level + 1)
        }
        init(name: String) {
            playerName = name
        }
    }
    
    var player = Player(name: "Argyrios")
    player.complete(level: 1)
    print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

    player = Player(name: "Beto")
    if player.tracker.advance(to: 6) {
        print("player is now on level 6")
    } else {
        print("level 6 has not yet been unlocked")
    }
}
