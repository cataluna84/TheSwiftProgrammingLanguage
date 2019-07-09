//
//  CollectionTypes.swift
//
//  Created by Mayank Bhaskar on 28/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func collectionTypes() {
    
    // Empty array of mixed type
    var emptyArray = Array<Any>()
    var array = [Any]()
    
    array.append(26.26)
    array.append("otherStr")
    array.append(89)
    //array[3] = "Got String"
    
    for variableType in array {
        if variableType is Float {
            print(variableType)
        }
    }
    print(array)
    
    // Empty SET
    var emptySet = Set<Int>()   // Type must conform to hashable protocol
    
    // Empty dictonary
    // var emptyDictionary = [Any: Any]()
    // The key type of a dictionary must conform to the Hashable protocol.
    var emptyDictionary = [String: Float]()
    
    var cardsDictionary: Dictionary<String, Double> = [
        "Spades": 13,
        "Hearts": 13,
        "Diamonds": 13,
        "Clubs": 13
    ]
    for (key, value) in cardsDictionary {       // (k,v) is
        print("\(key): \(value)")
    }
    print("Black Cards in a deck: \(cardsDictionary["Spades"]! + cardsDictionary["Clubs"]!)")
    
}

func arrayType() {
    
    // Multidimentional array that is preinitialized with a fixed number of default values
    var arr = Array(repeating: Array(repeating: 0, count: 2), count: 3)
    
}

func setType() {
    let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
//    names.indices
    
    var shorterIndices: [SetIndex<String>] = []
    for (i, name) in zip(names.indices, names) {
        if name.count <= 5 {
            shorterIndices.append(i)
        }
    }
    
    for i in shorterIndices {
        print(names[i])
    }
}
