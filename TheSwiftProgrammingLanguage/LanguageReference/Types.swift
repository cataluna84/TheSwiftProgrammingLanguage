//
//  Types.swift
//
//  Created by Mayank Bhaskar on 03/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation


// Start: TYPEALIAS
func typealiasing() {
    typealias MyFunctionDefinition = (Int, String) -> Void
    
    class ApiClient {
        static var sharedInstance = ApiClient()
        
        // ....
        typealias SuccessHandler = (AnyObject, Any) -> Void
        typealias ErrorHandler = (NSError, Any) -> Void
        typealias FinishedHandler = () -> Void
        
        func getUsers(success: (SuccessHandler)? = nil,
                      error: (ErrorHandler)? = nil,
                      finished: (FinishedHandler)? = nil) {
            // Do stuff
        }
        func getUser(success: (SuccessHandler)? = nil,
                     error: (ErrorHandler)? = nil,
                     finished: (FinishedHandler)? = nil) {
            // Do stuff
        }
    }
    
    ApiClient.sharedInstance.getUsers(success: { result, operation in
        // Do stuff
    }, error: { error, operation in
        // Do stuff
    },  finished: {
        // Do stuff
    })
}
// END: TYPEALIAS


// Start: METATYPE TYPE
func metatype() {
    class SomeBaseClass {
        class func printClassName() {
            print("SomeBaseClass")
        }
    }
    class SomeSubClass: SomeBaseClass {
        override class func printClassName() {
            print("SomeSubClass")
        }
    }
    let someInstance: SomeBaseClass = SomeSubClass()
    // The compile-time type of someInstance is SomeBaseClass,
    // and the runtime type of someInstance is SomeSubClass
    type(of: someInstance).printClassName()
    // Prints "SomeSubClass"
    
    class AnotherSubClass: SomeBaseClass {
        let string: String
        required init(string: String) {
            self.string = string
        }
        override class func printClassName() {
            print("AnotherSubClass")
        }
    }
    let metatype: AnotherSubClass.Type = AnotherSubClass.self
    let anotherInstance = metatype.init(string: "some string")
}
// End: METATYPE TYPE
