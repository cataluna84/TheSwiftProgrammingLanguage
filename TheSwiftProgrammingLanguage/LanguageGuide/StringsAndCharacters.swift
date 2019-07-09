//
//  StringsAndCharacters.swift
//
//  Created by Mayank Bhaskar on 03/08/17.
//  Copyright © 2017 Mayank Bhaskar. All rights reserved.
//

import Foundation

func stringsAndCharactersMain() {
    
    var str = "Hello, playground"
    var numb : Float = 78
    
    let otherStr = """
    Multiline is allowed here
    Asdd \(numb)
    """
    print(otherStr)
    
    print(str.startIndex)
    str.endIndex
    str.index(before: str.endIndex)
    str[str.index(before: str.endIndex)]
    
    
    
    var newString = str + " Rob!"
    for character in newString {
        print(character)
    }
    
    let newTypeString = NSString(string: newString)
    newTypeString.substring(to: 5)
    newTypeString.substring(from: 4)
    
    NSString(string: newTypeString.substring(from: 6)).substring(to: 3)
    
    newTypeString.substring(with: NSRange(location: 6, length: 3))
    
    if newTypeString.contains("Rob") {
        print("newTypeString contains Rob!")
    }
    
    newTypeString.components(separatedBy: " ")
    
    newTypeString.uppercased
    
    newTypeString.lowercased

}

func characters() {
    
    
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

    let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
    let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
    let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

}
