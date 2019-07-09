//
//  Functions.swift
//
//  Created by Mayank Bhaskar on 28/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation


var optionalName: String? = "Optimus Prime"

// Note: functions and closures are reference types
func functionMain() {
    //print(myName(text: optionalName, msg: "assemble on earth"))
    
    let _ = greet("Optimus Prime", on: "a good day")
    
    
    let stats = calculateStatistics(scores: [1,2,3,4,5,6,7,8,9])
    print(stats.0 + stats.1 + stats.2)
    
    passingAsArgument(num: 23, functionAsParameter: myName)
    
    // variadics parameter
    arithmeticMean(1, 2, 3, 4, 5)
    arithmeticMean(3, 8.25, 18.75)
    
    var currentValue = 3
    var moveNearerToZero = chooseStepFunction(backward: currentValue > 0)   // using a bool value
    
    // Nested Functions
    currentValue = -4
    moveNearerToZero = chooseStepFunctionAsNestedFunction(backward: currentValue > 0)
    // moveNearerToZero now refers to the nested stepForward() function
    while currentValue != 0 {
        print("\(currentValue)... ")
        currentValue = moveNearerToZero(currentValue)
    }
    print("zero!")
}

// using two parameters: optional name of type 'Any', String type
func myName(text: Any?, msg: String) -> Any {
    return "Hello from \(text ?? "prime") and the message is \(msg)"
}

// using no argument label
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)"
}

// Returning tuple
func calculateStatistics(scores: [Int]) -> (Int, Int, Int) {
    var min = scores[0], max = scores[0], sum = 0
    
    for score in scores {
        // do something with score
    }
    
    return (min, max, sum)
}

// passing a function as a parameter
func passingAsArgument(num: Int, functionAsParameter: ((Any?, String) -> Any)) -> String {
    
    print(functionAsParameter(optionalName, "assemble on earth"))
    return "bye"
}

// argumentLabel
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}

// variadics parameter
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

// Function Types as Return Types
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

// Nested Functions
func chooseStepFunctionAsNestedFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
