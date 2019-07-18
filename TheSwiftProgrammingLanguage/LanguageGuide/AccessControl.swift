//
//  AccessControl.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 05/09/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

// MARK: Access Control Syntax
/**
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}
*/
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

//class SomeInternalClass {}              // implicitly internal
//let someInternalConstant = 0            // implicitly internal


// MARK: Custom Types
public class SomePublicClass {                      // explicitly public class
    public var somePublicProperty = 0               // explicitly public class member
    var someInternalProperty = 0                    // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}     // explicitly file-private class member
    private func somePrivateMethod() {}             // explicitly private class member
}

class SomeInternalClass {                        // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {         // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                 // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}


// MARK: Tuple Types
// Access level is the most restrictive, of all the types used in the tuple. Here, its deduced as private
private let tupleType = (SomePublicClass.self, SomePrivateClass.self, SomeInternalClass.self)


// MARK: Function Types
// As the overall return type of the tuple is private, the overall access level of the function must be marked with the most restrictive of all the types used, which here is private
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    return (SomeInternalClass(), SomePrivateClass())
}

// MARK: Enumeration Types
/*
 The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to. You can’t specify a different access level for individual enumeration case.
 */
public enum CompassingPoint {
    case north
}


// MARK: Subclassing
public class A {
    fileprivate func someMethod() {}
}
internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

// MARK: Constants, Variables, Properties, and Subscripts
/*
 Getters and Setters: Can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript.
 Assign a lower access level by writing fileprivate(set), private(set), or internal(set) before the var or subscript introducer.
*/
public struct TrackedString {
    public private(set) var numberOfEdits = 0
    
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    
    // MARK: Initializers
    /*
     A default initializer has the same access level as the type it initializes, unless that type is defined as public. For a type that is defined as public, the default initializer is considered internal. If you want a public type to be initializable with a no-argument initializer when used in another module, you must explicitly provide a public no-argument initializer yourself as part of the type’s definition.
    */
    public init() {}
}

func getterAndSetters() {
    var stringToEdit = TrackedString()
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // Prints "The number of edits is 3"
}
