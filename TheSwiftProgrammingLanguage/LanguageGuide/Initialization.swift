//
//  Initialization.swift
//
//  Created by Mayank Bhaskar on 03/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func initializationMain() {
    
/**  Automatic Initializer Inheritance
     
     Rule 1
     If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
     
     Rule 2
     If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
 **/
    let doesNotInheritSuperclassInitializers = NonInheritor(a: 12, b: 23, c: 34)
    let inheritor4SuperclassInitializers = Inheritor(a: 26, b: 678)
    
    var pizzaRecipe = RecipeIngredient()
    var shoppingListItem = ShoppingListItem(name: "carrot")
    
    var breakfastList = [
        ShoppingListItem(),
        ShoppingListItem(name: "Bacon"),
        ShoppingListItem(name: "Eggs", quantity: 6),
        ]
    breakfastList[0].name = "Orange juice"
    breakfastList[0].purchased = true
    for item in breakfastList {
        print(item.description)
    }
    
    
    // FAILABLE INITIALIZERS
    failableInitializers()
    
    
}



class Base {
    let a: Int
    let b: Int
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    convenience init() {
        self.init(a: 0, b: 0)
    }
    
    convenience init(a: Int) {
        self.init(a: a, b: 0)
    }
    
    convenience init(b: Int) {
        self.init(a: 0, b: b)
    }
}

class NonInheritor: Base {
    let c: Int
    
    init(a: Int, b: Int, c: Int) {
        self.c = c
        super.init(a: a, b: b)
    }
}

class Inheritor: Base {
    let c: Int
    
    init(a: Int, b: Int, c: Int) {
        self.c = c
        super.init(a: a, b: b)
    }
    
    // Note: A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
    convenience override init(a: Int, b: Int) {
        self.init(a: a, b: b, c: 0)
    }
}

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

func failableInitializers() {
    
    let wholeNumber: Double = 12345.0
    let pi = 3.14159
    
    if let valueMaintained = Int(exactly: wholeNumber) {
        print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
    }    // Prints "12345.0 conversion to Int maintains value of 12345"
    
    // valueChanged is of type Int?, not Int
    
    if let valueChanged = Int(exactly: pi) { // do nothing
        
    } else  {
        print("\(pi) conversion to Int does not maintain value")    // Prints "3.14159 conversion to Int does not maintain value"
    }
    
    
    struct Animal {
        let species: String
        init?(species: String) {
            if species.isEmpty { return nil }
            self.species = species
        }
    }
    
    let someCreature = Animal(species: "Giraffe")
    // someCreature is of type Animal?, not Animal
    
    if let giraffe = someCreature {
        print("An animal was initialized with a species of \(giraffe.species)")
    }
    // Prints "An animal was initialized with a species of Giraffe"
    
    
    // Failable Initializers for Enumerations
    enum TemperatureUnit {
        case kelvin, celsius, fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .kelvin
            case "C":
                self = .celsius
            case "F":
                self = .fahrenheit
            default:
                return nil
            }
        }
    }
    
    let fahrenheitUnit = TemperatureUnit(symbol: "F")
    if fahrenheitUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."
    
    let unknownUnit = TemperatureUnit(symbol: "X")
    if unknownUnit == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
    // Prints "This is not a defined temperature unit, so initialization failed."

    
    // Failable Initializers for Enumerations with Raw Values
    enum TemperatureUnit2: Character {
        case kelvin = "K", celsius = "C", fahrenheit = "F"
    }
    
    let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
    if fahrenheitUnit2 != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."
    
    let unknownUnit2 = TemperatureUnit2(rawValue: "X")
    if unknownUnit2 == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
    // Prints "This is not a defined temperature unit, so initialization failed."

    
    class Product {
        let name: String
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }
    class CartItem: Product {
        let quantity: Int
        init?(name: String, quantity: Int) {
            if quantity < 1 { return nil }
            self.quantity = quantity
            super.init(name: name)
        }
    }
    
    if let twoSocks = CartItem(name: "sock", quantity: 2) {
        print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
    }
    
    if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
        print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
    } else {
        print("Unable to initialize zero shirts")
    }
    
    if let oneUnnamed = CartItem(name: "", quantity: 1) {
        print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
    } else {
        print("Unable to initialize one unnamed product")
    }

    // Overriding a Failable Initializer
    class Document {
        var name: String?
        // this initializer creates a document with a nil name value
        init() {}
        // this initializer creates a document with a nonempty name value
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }
    
    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()
            self.name = "[Untitled]"
        }
        override init(name: String) {
            super.init()
            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }
    
    class UntitledDocument: Document {
        override init() {
            super.init(name: "[Untitled]")!
        }
    }
    
    // Setting a Default Property Value with a Closure or Function
    class SomeClass {
        let someProperty: Any = {
            // create a default value for someProperty inside this closure
            // someValue must be of the same type as SomeType
            return "someValue"
        }()
    }
    
    struct Chessboard {
        let boardColors: [Bool] = {
            var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        
        func squareIsBlackAt(row: Int, column: Int) -> Bool {
            return boardColors[(row * 8) + column]
        }
    }
    
    let board = Chessboard()
    print(board.squareIsBlackAt(row: 0, column: 1))
    // Prints "true"
    print(board.squareIsBlackAt(row: 7, column: 7))
    // Prints "false"
    
}
