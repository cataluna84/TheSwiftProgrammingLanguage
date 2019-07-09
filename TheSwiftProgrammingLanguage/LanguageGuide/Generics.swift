//
//  Generics.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 01/09/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func genericsMain() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    
    let fromTheTop = stackOfStrings.pop()
    
    // Extending a Generic Type
    if let topItem = stackOfStrings.topItem {
        print("The top item on the stack is \(topItem).")
    }
    
    typeConstraints()
    
    associatedTypes()
    
    whereClauses()
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Stack {
    var topItem: Element? {         // Can use "Element"
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


// Type Constraints
func typeConstraints() {
    // Gives a compile time error is Type is not constrained to Equatable
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
    // doubleIndex is an optional Int with no value, because 9.3 isn't in the array
    let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
    // stringIndex is an optional Int containing a value of 2

}



// Associated Types: An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted.
func associatedTypes() {
    
}
protocol Container {
    associatedtype Item
//  associatedtype Item: Equatable  // Using Type Annotations to Constrain an Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Array: Container {}   // Extending an Existing Type to Specify an Associated Type
struct Stack2<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    // the type parameter Element is used as the type of the append(_:) method’s item parameter and the return type of the subscript
    typealias Item = Element    // Do not need this line due to Swift's type Inference
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}



// Generic Where clause: A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
func whereClauses() {
    var stackOfStrings = Stack2<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    
    var arrayOfStrings = ["uno", "dos", "tres"]
    
    if allItemsMatch(stackOfStrings, arrayOfStrings) {
        print("All items match.")
    } else {
        print("Not all items match.")
    }
    
    if stackOfStrings.isTop("tres") {
        print("Top element is tres.")
    } else {
        print("Top element is something else.")
    }    // Prints "Top element is tres."
    
    struct NotEquatable { }
    var notEquatableStack = Stack<NotEquatable>()
    let notEquatableValue = NotEquatable()
    notEquatableStack.push(notEquatableValue)
//  notEquatableStack.isTop(notEquatableValue)  // Error
    
    if [9, 9, 9].startsWith(42) {
        print("Starts with 42.")
    } else {
        print("Starts with something else.")
    }
    
    print([1260.0, 1200.0, 98.6, 37.0].average())
    
    
}
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}

// Extensions with a Generic Where Clause
// If you tried to do this without a generic where clause, you would have a problem: The implementation of isTop(_:) uses the == operator, but the definition of Stack doesn’t require its items to be equatable, so using the == operator results in a compile-time error.
extension Stack2 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
// The generic where clause in the example requires Item to conform to a protocol
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
// You can also write a generic where clauses that require Item to be a specific type
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

// Associated Types with a Generic Where Clause
protocol Container2 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    // The generic where clause on Iterator requires that the iterator must traverse over elements of the same item type as the container’s items, regardless of the iterator’s type.
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}
// the following code declares a ComparableContainer protocol that requires Item to conform to Comparable:
protocol ComparableContainer: Container where Item: Comparable { }


// Generic Subscripts
/**
 This extension to the Container protocol adds a subscript that takes a sequence of indices and returns an array containing the items at each given index. This generic subscript is constrained as follows:
 - The generic parameter Indices in angle brackets has to be a type that conforms to the Sequence protocol from the standard library.
 - The subscript takes a single parameter, indices, which is an instance of that Indices type.
 - The generic where clause requires that the iterator for the sequence must traverse over elements of type Int. This ensures that the indices in the sequence are the same type as the indices used for a container.
 **/
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}   // Taken together, these constraints mean that the value passed for the indices parameter is a sequence of integers.
