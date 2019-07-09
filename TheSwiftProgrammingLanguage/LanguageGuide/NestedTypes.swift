//
//  NestedTypes.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 25/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func nestedTypesMain() {
    let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
    print("theAceOfSpades: \(theAceOfSpades.description)")    // Prints "theAceOfSpades: suit is ♠, value is 1 or 11"
    
    let heartsSymbol = BlackjackCard.Suit.hearts.rawValue    // heartsSymbol is "♡"
}

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
