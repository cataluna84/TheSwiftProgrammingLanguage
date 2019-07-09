//
//  PropertyWrappers.swift
//  TheSwiftProgrammingLanguage
//
//  Created by Mayank Bhaskar on 7/8/19.
//  Copyright © 2019 Mayank Bhaskar. All rights reserved.
//

import Foundation

func propertyWrappersMain() {
    UserDefaultsConfig.hasSeenAppIntroduction = false
    print(UserDefaultsConfig.hasSeenAppIntroduction) // Prints: false
    
    UserDefaultsConfig.hasSeenAppIntroduction = true
    print(UserDefaultsConfig.hasSeenAppIntroduction) // Prints: true
}

/*
// Before Wrappers
 
extension UserDefaults {
    public enum Keys {
        static let hasSeenAppIntroduction = "has_seen_app_introduction"
    }

    var hasSeenAppIntroduction: Bool {
        set {
            set(newValue, forKey: Keys.hasSeenAppIntroduction)
        }
        get {
            return bool(forKey: Keys.hasSeenAppIntroduction)
        }
    }
}

func wrapperFunc() {
    UserDefaults.standard.hasSeenAppIntroduction = true

    print(" adsads: \(UserDefaults.standard.hasSeenAppIntroduction) ")

    guard !UserDefaults.standard.hasSeenAppIntroduction else { return }

    print(" adsads: \(UserDefaults.standard.hasSeenAppIntroduction) ")
}

wrapperFunc()
 */


@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsConfig {
    @UserDefault("has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}
