//
//  ErrorHandling.swift
//
//  Created by Mayank Bhaskar on 24/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func errorHandlingMain() {
    var vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        
    }
    // Prints "Insufficient funds. Please insert an additional 2 coins."
    
    
    
    // Converting errors to optional values
    func someThrowingFunction() throws -> Int {
        // ...
        return 78
    }
    
    let x = try? someThrowingFunction()
    
    let y: Int?
    do {
        y = try someThrowingFunction()
    } catch {
        
        y = nil
    }
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {     // Throwing initializers can propagate errors the same way
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}


class ErrorHandling {
    func canThrowError() throws {
        
    }
    
    func main() {
        do {
            try canThrowError()
            // no error was thrown
        } catch {
            // an error was thrown
        }
    }
    
    
}
