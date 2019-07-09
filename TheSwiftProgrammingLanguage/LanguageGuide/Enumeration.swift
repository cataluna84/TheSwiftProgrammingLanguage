//
//  Enumeration.swift
//
//  Created by Mayank Bhaskar on 31/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west

func enumerationMain() {
    directionToHead = .east
    
    directionToHead = .south
    switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
    
    let somePlanet = Planet.earth
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
    
    associatedValues()
    rawValues()
    recursiveEnumeration()
}

func associatedValues() {
    enum Barcode {
        case upc(Int, Int, Int, Int)
        case qrCode(String)
    }
    
    var productBarcode = Barcode.upc(12, 5614, 2, 445)
    productBarcode = .qrCode("jhsdjkabdlsk")
    
    // can place a single var or let annotation before the case name, for brevity:
    switch productBarcode {
    case let .upc(numberSystem, manufacturer, product, check):
        print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .qrCode(productCode):
        print("QR code: \(productCode).")
    }
}

func rawValues() {
    enum ASCIIControlCharacter: Character {
        case tab = "\t"
        case lineFeed = "\n"
        case carriageReturn = "\r"
    }
    
    // Implicitly Assigned Raw Values
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    let _ = Planet.earth.rawValue
    
    enum CompassPoint: String {
        case north, south, east, west
    }
    let _ = CompassPoint.west.rawValue
    
    
    let possiblePlanet = Planet(rawValue: 7)    // Returns optional
    print(possiblePlanet!)
    
    
    // Using optional binding with enums
    let positionToFind = 11
    if let somePlanet = Planet(rawValue: positionToFind) {
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    } else {
        print("There isn't a planet at position \(positionToFind)")
    }
    
}

func recursiveEnumeration() {
    
    enum ArithmeticExpression {
        case number(Int)
        indirect case addition(ArithmeticExpression, ArithmeticExpression)
        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
    
    let five = ArithmeticExpression.number(5)
    let four = ArithmeticExpression.number(4)
    let sum = ArithmeticExpression.addition(five, four)
    let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
    
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
    
    print(evaluate(product))
}
