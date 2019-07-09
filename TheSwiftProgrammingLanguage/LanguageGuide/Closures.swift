//
//  Closures.swift
//
//  Created by Mayank Bhaskar on 28/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

// Note: functions and closures are reference types
func closuresMain() {
    
    let stat = [1, 2, 4, 3, 5, 6, 7, 8, 9]
    let onlyOddArray = stat.map({ (num: Int) -> Int in
        if(num % 2 != 0) {
            return num
        } else {
            return 0
        }
    })
    print(onlyOddArray)
    
    
    // Example of map function which accepts a closure and returns an array
    // Declaration: func map<T>(_ transform: (String) throws -> T) rethrows -> [T]
    let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    let lowercaseNames = cast.map { $0.lowercased() }    // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    print("lowercaseNames: \(lowercaseNames)")
    let letterCounts = cast.map { $0.count }    // 'letterCounts' == [6, 6, 3, 4]
    print("letterCounts: \(letterCounts)")
    
    
    // Trailing Closure
    // Declaration: func sorted(by areInIncreasingOrder: (Int, Int) throws -> Bool) rethrows -> [Int]
    let sortedStat = stat.sorted{ $0 < $1 }
    print("stat in increasing order: \(sortedStat)")
    print("stat in decreasing order: \(stat.sorted{ $0 > $1 }) ")
    
    
    // ESCAPING Closures
    let instance = SomeClass2()
    instance.doSomething()
    print(instance.x)

    closureVariable!()      // calling the escaping closure
    print(instance.x)
    print(instance.zss)
    
    autoClosure()
}


// Start: Capturing Values and passing as a reference type
func closureAsReferenceType() {
    let incrementByTen = makeIncrementer(forIncrement: 10)
    print(incrementByTen())
    print(incrementByTen())
    print(incrementByTen())
    
    let decrementBy5 = makeDecrementor(5)
    print(decrementBy5)
    print(decrementBy5)
    print(decrementBy5)
    print(decrementBy5)
}
func makeDecrementor(_ amt: Int) -> Int {
    var tot = 0
    tot -= amt
    return tot
}
func makeIncrementer(forIncrement amount: Int) -> () -> Int {   // Returning a function and we know that functions and closures are reference types
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
// End: Capturing Values



/**
 ESCAPING Closures:
 One way that a closure can escape is by being stored in a variable that is defined outside the function. As an example, many functions that start an asynchronous operation take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn’t called until the operation is completed—the closure needs to escape, to be called later.
 **/
var closureVariable: (() -> Void)? = nil

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    closureVariable = completionHandler     // Assigning closure to an external variable
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass2 {
    var x = 10, zss: String? = nil
    
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
            self.zss = "sdd"
        }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}



// AUTOCLOSURES
var customerProviders: [() -> String] = []

func autoClosure() {
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    print(customersInLine.count)
    // Prints "5"
    
    collectCustomerProviders(customer: customersInLine.remove(at: 0))
    collectCustomerProviders(customer: customersInLine.remove(at: 0))
    
    print("Collected \(customerProviders.count) closures.")
    // Prints "Collected 2 closures."
    for customerProvider in customerProviders {
        print("Now serving \(customerProvider())!")
    }
    
    // let customerProvider = { customersInLine.remove(at: 0) }
    // serve(customer: customersInLine.remove(at: 0) )
    
    // print("Now serving \(customerProvider())!")
    // Prints "Now serving Chris!"
    print(customersInLine.count)
    // Prints "4"
}

/*
 func serve(customer customerProvider: @autoclosure () -> String) {
 print("Now serving \(customerProvider())!")
 }
 */

func collectCustomerProviders(customer customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
