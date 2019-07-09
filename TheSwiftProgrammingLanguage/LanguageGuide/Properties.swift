//
//  Properties.swift
//
//  Created by Mayank Bhaskar on 01/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

struct FixedLengthRange {
    var firstValue: Int = 0
    let length: Int = 2
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let vga = Resolution(width: 640, height: 480)

// Memberwise Initializers for Structure Types: only initialized one member as the other one is a constant
var rangeOfThreeItems = FixedLengthRange(firstValue: 1)

// the range represents integer values 0, 1, and 2

func propertiesMain() {
    var sdf = FixedLengthRange()
    
    
    rangeOfThreeItems.firstValue = 6
    // the range now represents integer values 6, 7, and 8
    
    computedProperties()
    
    propertyObservers()
}

func computedProperties() {
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set(newCenter) {
                origin.x = newCenter.x - (size.width / 2)
                origin.y = newCenter.y - (size.height / 2)
            }
        }
    }
    var square = Rect(origin: Point(x: 0.0, y: 0.0),
                      size: Size(width: 10.0, height: 10.0))
    
    let initialSquareCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    // Prints "square.origin is now at (10.0, 10.0)"
    
    // READ-ONLY COMPUTED PROPERTIES
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
    
    
    // Using computed properties as getters and setters
    var stepObj = Step()
    print(stepObj.stepOf)
    stepObj.stepOf = "alien"
    print(stepObj.stepOf)
}

class Step {
    var step = "dog"
    
    var stepOf: String {
        get {
            switch(step) {
            case "human":
                return "Seems like step of human"
            case "dog", "cat":
                return "Seems like paws"
            default:
                return "Cannot find the type of steps"
            }
        }
        set {
            step = newValue
        }
    }
}

func propertyObservers() {
    
    class StepCounter {
        
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    
    
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps
}

func typeProperties() {
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 6
        }
    }
    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27
        }
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
    
    
    // Example of type properties
    struct AudioChannel {
        static let thresholdLevel = 10
        static var maxInputLevelForAllChannels = 0
        var currentLevel: Int = 0 {
            didSet {
                if currentLevel > AudioChannel.thresholdLevel {
                    // cap the new audio level to the threshold level
                    currentLevel = AudioChannel.thresholdLevel
                }
                if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                    // store this as the new overall maximum input level
                    AudioChannel.maxInputLevelForAllChannels = currentLevel
                }
            }
        }
    }
    
    var leftChannel = AudioChannel()
    var rightChannel = AudioChannel()
    
    leftChannel.currentLevel = 7
    print(leftChannel.currentLevel)
    // Prints "7"
    print(AudioChannel.maxInputLevelForAllChannels)
    
    rightChannel.currentLevel = 11
    print(rightChannel.currentLevel)
    // Prints "10"
    print(AudioChannel.maxInputLevelForAllChannels)
}
