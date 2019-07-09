//
//  ClassesAndStructures.swift
//
//  Created by Mayank Bhaskar on 03/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func classes() {
    
    class helloWorld {
        var perimeter: Double = 0.0
        
        var justAVariable: Double {
            get {
                return perimeter * 3.14
            }
            set {
                if(newValue > 6.8) {
                    self.justAVariable = newValue
                    /*
                     Setters and Getters apply to computed properties; such properties do not have storage in the instance - the value from the getter is meant to be computed from other instance properties
                     */
                }
            }
        }
    }
    
    var obj = helloWorld()
    obj.perimeter = 34
    //obj.justAVariable = 10
    print(obj.perimeter)
}
