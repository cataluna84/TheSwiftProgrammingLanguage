//
//  Sequence&IteratorProtocols.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 05/09/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]

func iteratorProtocol() {       // From documentation of IteratorProtocol
    var animalIterator = animals.makeIterator()
    while let animal = animalIterator.next() {
        print(animal)
    }

    // Using Iterators Directly
    let longestAnimal = animals.reduce1 { current, element in
        if current.count > element.count {
            return current
        } else {
            return element
        }
    }
    print(longestAnimal)      // Prints "Butterfly"



    // Adding IteratorProtocol Conformance to Your Type
    struct Countdown: Sequence {
        let start: Int

        func makeIterator() -> CountdownIterator {
            return CountdownIterator(self)
        }
    }
    
    struct CountdownIterator: IteratorProtocol {
        let countdown: Countdown
        var times = 0

        init(_ countdown: Countdown) {
            self.countdown = countdown
        }

        mutating func next() -> Int? {
            let nextNumber = countdown.start - times
            guard nextNumber > 0
                else { return nil }

            times += 1
            return nextNumber
        }
    }

    let threeTwoOne = Countdown(start: 3)
    for count in threeTwoOne {
        print("\(count)...")
    }
}

extension Sequence {
    func reduce1(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        var i = makeIterator()
        guard var accumulated = i.next() else {
            return nil
        }

        while let element = i.next() {
            accumulated = nextPartialResult(accumulated, element)   // Self
        }
        return accumulated
    }
}
