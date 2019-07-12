//
//  AutomaticReferenceCounting.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 09/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func arcMain() {
    
    class Person {
        let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?
    
    reference1 = Person(name: "John Appleseed")
    
    reference2 = reference1
    reference3 = reference1
    
    reference1 = nil
    reference2 = nil
    reference3 = nil
    
    // Strong Reference Cycles Between class instances
    strongReferenceCycle()
    
    // MARK: Resolving Strong Reference Cycles Between Class Instances
    weakReference()
    unownedReference()
    unownedReferencesAndImplicitlyUnwrappedOptionalProperties()
    
    // MARK: Strong Reference Cycles for Closures
    class HTMLElement {
        let name: String
        let text: String?
        
        lazy var asHTML: () -> String = {
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    
    let heading = HTMLElement(name: "h1")
    let defaultText = "some default text"
    heading.asHTML = {
        return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
    }
    print(heading.asHTML())
    // Prints "<h1>some default text</h1>"
    
    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
    print(paragraph!.asHTML())
    // Prints "<p>hello, world</p>"
    
    paragraph = nil         // Creating a strong reference cycle which does'nt deinitializes the 'paragraph' object
    
    // MARK: Resolving Strong Reference Cycles for Closures
    weakAndUnownedReferences()
}

// MARK: Strong Reference Cycles Between Class Instances
func strongReferenceCycle() {
    
    class Person {
        let name: String
        var apartment: Apartment?
        
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    
    class Apartment {
        let unit: String
        var tenant: Person?
        
        init(unit: String) {
            self.unit = unit
            print("Apartment \(unit) is being initialized")
        }
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    
    var john: Person?
    var unit4A: Apartment?
    
    john = Person(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")
    
    john!.apartment = unit4A
    unit4A!.tenant = john
    
    john = nil
    unit4A = nil
    // Both 'john' and 'unit4A' are not deinitialiased due to strong reference cycles
}

// MARK: WEAK REFERENCES
func weakReference() {
    
    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { print("\(name) is being deinitialized") }
    }
    
    class Apartment {
        let unit: String
        init(unit: String) { self.unit = unit }
        weak var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    
    var john: Person?
    var unit4A: Apartment?
    
    john = Person(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")
    
    john!.apartment = unit4A
    unit4A!.tenant = john
    
    john = nil
    // Prints "John Appleseed is being deinitialized"
    
    if let per = unit4A!.tenant {
        print("\(per.name) is alive")
    } else {
        print("Person object's reference is \(String(describing: unit4A?.tenant))")
    }
    
    unit4A = nil
    // Prints "Apartment 4A is being deinitialized"
}

func unownedReference() {
    
    class Customer {
        let name: String
        var card: CreditCard?
        
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }
    
    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    
    var john: Customer?
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
    
    john = nil
}

func unownedReferencesAndImplicitlyUnwrappedOptionalProperties() {
    
    class Country {
        let name: String
        var capitalCity: City!
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
    }
    
    class City {
        let name: String
        unowned let country: Country
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
    }
    
    let country = Country(name: "Canada", capitalName: "Ottawa")
    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
    // Prints "Canada's capital city is called Ottawa"
}

/*
 MARK: Resolving strong reference cycle for closures
 */
// MARK: Defining a Capture List
class CaptureList {
    var delegate: AnyObject?
    
    init(_ delegate: AnyObject) {
        self.delegate = delegate
    }
    
    // Place the capture list before a closure parameter list and return type if they are provided:
    lazy var someClosure: (Int, String) -> String = {
        [unowned self, weak delegate = self.delegate!] (index: Int,
        stringToProcess: String) -> String in
        
        return String("To write something here")
    }
}

/**
 Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
 
 Conversely, define a capture as a weak reference when the captured reference may become nil at some point in the future. Weak references are always of an optional type, and automatically become nil when the instance they reference is deallocated. This enables you to check for their existence within the closure’s body.
 **/    
// MARK: Weak and Unowned References
func weakAndUnownedReferences() {
    
    class HTMLElement {
        let name: String
        let text: String?
        
        lazy var asHTML: () -> String = {
            [unowned self] in
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    
    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
    print(paragraph!.asHTML())
    
    paragraph = nil     // Prints "p is being deinitialized"
}
