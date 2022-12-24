//
//  UserDefaultsManager.swift
//  Hero
//
//  Created by Byron Mejia on 12/24/22.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T> {
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

struct UserDefaultsManager {
    @UserDefaultWrapper("isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
