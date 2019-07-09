//
//  OptionalChaining.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 22/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func optionalChainingMain() {
    let john = Person()
    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
    
    func createAddress() -> Address {
        print("Function was called.")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }
    john.residence?.address = createAddress()       // createAddress isn't called as john.residence is nil
    
    // Calling Methods Through Optional Chaining
    // If you call a method which returns nothing on an optional value with optional chaining, the method’s return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining.
    if john.residence?.printNumberOfRooms() != nil {
        print("It was possible to print the number of rooms.")
    } else {
        print("It was not possible to print the number of rooms.")
    }
    // Prints "It was not possible to print the number of rooms."
    
    // Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully:
    if (john.residence?.address = createAddress()) != nil {
        print("It was possible to set the address.")
    } else {
        print("It was not possible to set the address.")
    }
    // Prints "It was not possible to set the address."

    // Accessing Subscripts Through Optional Chaining
    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
    
    john.residence?[0] = Room(name: "Bathroom")     // Fails since the subscript is null
    
    let johnsHouse = Residence()
    johnsHouse.rooms.append(Room(name: "Living Room"))
    johnsHouse.rooms.append(Room(name: "Kitchen"))
    john.residence = johnsHouse
    
    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
    // Prints "The first room name is Living Room."

    let johnsAddress = Address()
    johnsAddress.buildingName = "The Larches"
    johnsAddress.street = "Laurel Street"
    john.residence?.address = johnsAddress
    
    if let johnsStreet = john.residence?.address?.street {
        print("John's street name is \(johnsStreet).")
    } else {
        print("Unable to retrieve the address.")
    }
    // Prints "John's street name is Laurel Street."
    
    // Chaining on Methods with Optional Return Values
    if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
        print("John's building identifier is \(buildingIdentifier).")
    }
    // Prints "John's building identifier is The Larches."
    
    // If you want to perform further optional chaining on this method’s return value, place the optional chaining question mark after the method’s parentheses:
    if let beginsWithThe =
        john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
    }
    // Prints "John's building identifier begins with "The"."
    
    // Accessing Subscripts of Optional Type
    var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
    testScores["Dave"]?[0] = 91
    testScores["Bev"]?[0] += 1
    testScores["Brian"]?[0] = 72
    // the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
    
    
}

class Person {
    var residence: Residence?
}
class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
