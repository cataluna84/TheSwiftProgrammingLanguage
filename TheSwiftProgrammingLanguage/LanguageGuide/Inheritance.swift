//
//  Inheritance.swift
//
//  Created by Mayank Bhaskar on 02/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func inheritanceMain() {
    let someVehicle = Vehicle()
    
    print("Vehicle: \(someVehicle.description)")
    
    let bicycle = Bicycle()
    bicycle.hasBasket = true
    
    bicycle.currentSpeed = 15.0
    print("Bicycle: \(bicycle.description)")
    
    let tandem = Tandem()
    tandem.hasBasket = true
    tandem.currentNumberOfPassengers = 2
    tandem.currentSpeed = 22.0
    print("Tandem: \(tandem.description)")
    
    let train = Train()
    train.makeNoise()
    
    let car = Car()
    car.currentSpeed = 25.0
    car.gear = 3
    print("Car: \(car.description)")
    
    let automatic = AutomaticCar()
    automatic.currentSpeed = 35.0
    print("AutomaticCar: \(automatic.description)")
}

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
