//
//  Protocols.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank.Bhaskar on 1/24/18.
//  Copyright © 2018 Mayank Bhaskar. All rights reserved.
//

import Foundation

func protocolsMain() {
    let ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    debugPrint("Full name of starship: \(ncc1701.fullName)")
    
    // Method Requirements
    let generator = LinearCongruentialGenerator()
    debugPrint("Here's a random number: \(generator.random())")
    debugPrint("And another one: \(generator.random())")

    
    // Mutating Method Requirements
    var lightSwitch = OnOffSwitch.off
    lightSwitch.toggle()
    
    // Protocol as Types: existential types
    let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    for _ in 1...5 {
        debugPrint("Dice roll: \(d6.roll())")
    }
    
    // Delegation
    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
    
    // Protocol conformance with an extension
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
    print(d12.textualDescription)       // Prints "A 12-sided dice"
    
    // Conditionally conforming to a Protocol
    let myDice = [d6, d12]
    print(myDice.textualDescription)    // Prints "[A 6-sided dice, A 12-sided dice]"
    
    // Declaring Protocol Adoption with an Extension
    let simonTheHamster = Hamster(name: "Simon")
    let somethingTextRepresentable: TextRepresentable = simonTheHamster
    print(somethingTextRepresentable.textualDescription)    // Prints "A hamster named Simon"
    
    // MARK: Collections of Protocol Types
    let things: [TextRepresentable] = [game, d12, simonTheHamster]
    
    for thing in things {
        print(thing.textualDescription)
    }
    
    // Protocol Inheritance
    print(game.prettyTextualDescription)
    
    // Protocol Composition
    let birthdayPerson = Person2(name: "Ramu", age: 25)
    wishHappyBirthday(to: birthdayPerson)
    
    // any type that’s a subclass of Location and that conforms to the Named protocol
    let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
    beginConcert(in: seattle)                               // Prints "Hello, Seattle!"
    
    // Checking for Protocol Conformance
    // The objects array can now be iterated, and each object in the array can be checked to see if it conforms to the HasArea protocol:
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
    
    // Use an instance of ThreeSource as the data source for a new Counter instance:
    var counter = Counter()
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }
    
    // Adding Constraints to Protocol Extensions
    let equalNumbers = [100, 100, 100, 100, 100]
    let differentNumbers = [100, 100, 200, 100, 200]
    
    print(equalNumbers.allEqual())          // Prints "true"
    print(differentNumbers.allEqual())      // Prints "false"
}

// MARK: Property Requirements
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    static var someTypeProperty: Int { get set }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}


// MARK: Method Requirements
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}


// MARK: Mutating Method Requirements
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


// MARK: Initializer Requirements
protocol SomeProtocolForInit {
    init(someParameter: Int)
}

// MARK: Class implementations of Protocol initializer requirements
// must use the required modifier before the overridden init parameters
class SomeClass: SomeProtocolForInit {
    required init(someParameter: Int) {
        // initialization implementation goes here
    }
}

/*
 If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:
 */
protocol SomeProtocol2 {
    init()
}

class SomeSuperClass2 {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass2, SomeProtocol2 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}


// MARK: Protocols as Types
/*
 Using a protocol as a type is sometimes called an existential type, which comes from the phrase “there exists a type T such that T conforms to the protocol”.
 */
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


// MARK: Delegation
protocol DiceGame {
    var dice: Dice { get }
    
    func play()
}

// Protocol's limited adoption to a class type by adding AnyObject protocol to its inheritence list
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    weak var delegate: DiceGameDelegate?
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
    
}

// MARK: Adding Protocol Conformance with an extension
protocol TextRepresentable {
    var textualDescription: String { get }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

// MARK: Conditionally Conforming to a Protocol
/*
 Making 'Array' instances conform to the TextRepresentable protocol whenever they store elements of a type that conforms to TextRepresentable.
 */
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// MARK: Declaring Protocol Adoption with an Extension
/*
 If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:
 */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

// MARK: Protocol Inheritance
// Multiple inherited protocols, separated by commas:
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        
        return output
    }
}

// MARK: Class-Only Protocols
protocol SomeClassOnlyProtocol: AnyObject, AnotherProtocol {
    // class-only protocol definition goes here
}



// MARK: Protocol Composition: Combine multiple protocols into a single requirement
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

// Here’s an example that combines the Named protocol from the previous example with a Location class:
class Location {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

// MARK: Checking for Protocol Conformance
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = Double.pi
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

// Class conformance via AnyObject
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]


// MARK: Optional Protocol Requirements
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        // Note: An optional func increment which is called with a ? after its name and it always returns an optional value, even if it returns a non-optional value in its definition
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// NSObject class is inherited here since it acts as a bridge towards the Objective-C runtime
class ThreeSource: NSObject, CounterDataSource {
    // Inheriting fixedIncrement stored property
    let fixedIncrement = 3
}

class TowardsZeroSource: NSObject, CounterDataSource {
    // Inheriting increment func
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

// MARK: Protocol Extensions
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// MARK: Providing Default Implementations
extension PrettyTextRepresentable {
    
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// MARK: Adding Constraints to Protocol Extensions
extension Collection where Element: Equatable {
    
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
