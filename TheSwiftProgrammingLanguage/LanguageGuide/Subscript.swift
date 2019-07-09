//
//  Subscript.swift
//
//  Created by Mayank Bhaskar on 02/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func subscriptMain() {
    
/**
     Subscript Syntax
     
     subscript(index: Int) -> Int {
        get {
            // return an appropriate subscript value here
        }
        set(newValue) {
            // perform a suitable setting action here
        }
     }
**/
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    let threeTimesTable = TimesTable(multiplier: 3)
    print("six times three is \(threeTimesTable[6])")
    
    
    
    // Subscript Options
    var matrix = Matrix(rows: 2, columns: 2)
    
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2
    
    let someValue = matrix[2, 2]
    debugPrint(someValue)
    
    
    // Type Subscripts -- Swift 5.1: Static and Class subscripts 
    NewSettings["Captain"] = "Gary"
    NewSettings["Friend"] = "Whatever"
    debugPrint(NewSettings["Captain"] ?? "Unknown")
}

//
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

// MARK: Static/Class subscripts
public enum NewSettings {
    
    private static var values = [String: String]()

    public static subscript(_ name: String) -> String? {
        get {
            return values[name]
        }
        set {
            print("Adjusting \(name) to \(newValue ?? "nil")")
            values[name] = newValue
        }
    }
}
