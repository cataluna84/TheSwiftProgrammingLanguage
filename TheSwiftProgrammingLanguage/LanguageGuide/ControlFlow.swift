//
//  ControlFlow.swift
//
//  Created by Mayank Bhaskar on 27/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

class ControlFlow {
    
    func forInLoop() {
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        
        let minutes = 60
        for tickMark in 0..<minutes {
            // render the tick mark each minute (60 times)
        }
        
        let minuteInterval = 5
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
        }
        
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // render the tick mark every 3 hours (3, 6, 9, 12)
        }
    }
    
    func whileLoop() {
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        
        var square = 0
        var diceRoll = 0
        while square < finalSquare {
            // roll the dice
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // move by the rolled amount
            square += diceRoll
            if square < board.count {
                // if we're still on the board, move up or down for a snake or a ladder
                square += board[square]
            }
        }
        print("Game over!")
    }
    
    func repeatWhileLoop() {
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        
        repeat {
            // move up or down for a snake or ladder
            square += board[square]
            // roll the dice
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // move by the rolled amount
            square += diceRoll
        } while square < finalSquare
        print("Game over!")
    }
    
    func switchConditionalStatement() {
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        // Interval Matching
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")

        // Tuples Matching
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        
        // Value Bindings
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        // Where Bindings
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        // Compund Cases/Activities
        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
    }
        
    static func controlTransferStatement() {
            
        // Break in a switch statement
        let numberSymbol: Character = "三"  // Chinese symbol for the number 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        
        // Fallthrough
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        case 4, 6, 8, 10:
            description += " skipeed the even number, also "
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        
        // Labelled statements
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // diceRoll will move us to the final square, so the game is over
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                // diceRoll will move us beyond the final square, so roll again
                continue gameLoop
            default:
                // this is a valid move, so find out its effect
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")
    }
    
    func earlyExit() {
        
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }
            
            print("Hello \(name)!")
            
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                fatalError()
            }
            
            print("I hope the weather is nice in \(location).")
        }
        
        greet(person: ["name": "John"])
        
        greet(person: ["name": "Jane", "location": "Cupertino"])
    }
    
    func checkApiAvailability() {
        // Using with guard
        guard #available(iOS 11, *) else {      // iOS, macOS, watchOS, and tvOS
            fatalError("This application only works on iOS 11")
        }
        
        // Using with if
        if #available(iOS 11, macOS 10.12, *) {
            // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
        } else {
            // Fall back to earlier iOS and macOS APIs
        }
    }
    
    func experimentalCode() {
        var optionalString: String?
        var optionalInteger: Optional<Int>
        
        var optionalName: String? = "Optimus Prime"
        
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        } else {
            greeting = "Hello, nameless person"
        }
        print(greeting)
        
        // Use of switch
        switch optionalName {
        case "prime"?:
            print("on case prime")
        case let x where (x?.hasSuffix("Prime"))!:
            print("Autobots assemble, by \(x!)")
        default:
            print("get down")
        }
        
        // LOOPS
        let interestingNumbers = [
            "prime": [2,3],
            "ddf": [4,9,23]
        ]
        var scores = [1,2,3,4,5,6,7,8,9]
        var large: Int = 0
        
        for (_,b) in interestingNumbers {
            for num in b {
                if num>large {
                    large=num
                }
            }
        }
        print(large)
        
        large = 0
        for i in 0...5 {
            large += i
            print(large)
        }
        
        print("while loop: ")
        var m = 2
        while m < 5 {
            m += 1
            print(m)
        }
        
        print("do while loop")
        repeat {
            m += 2
            
        } while m<20
        print (m)
        
        // what are indices?
        print(scores.indices)
        for (index, value) in scores.enumerated() {
            scores[index] = value/2
        }
        print("Numbers Halfed: \(scores)")
    }
}
