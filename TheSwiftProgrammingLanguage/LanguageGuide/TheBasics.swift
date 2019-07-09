//
//
//  Created by Mayank Bhaskar on 28/07/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation



// START: TUPLES

// Defining a tuple
let someTuple: (Double, Double) = (3.14159, 2.71828)

typealias Point = (Int, Int)
let origin: Point = (0, 0)

// END: TUPLES





class AssertionsAndPreconditions {
    static func asserting() {
        let age = -3
        //assert(age >= 0, "A person's age can't be less than zero.")
        // This assertion fails because -3 is not >= 0.
        
        //assert(age >= 0)
        
        if age > 10 {
            print("You can ride the roller-coaster or the ferris wheel.")
        } else if age > 0 {
            print("You can ride the ferris wheel.")
        } else {
            assertionFailure("A person's age can't be less than zero.")
        }
        
    }
    
    static func preconditioning(a: Int) {
        precondition(a > 0, "a=\(a) should be greater than 0")
    }
}
