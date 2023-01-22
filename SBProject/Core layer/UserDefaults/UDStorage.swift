//
//  UDStorage.swift
//  SBProject
//
//  Created by Alex Misko on 14.01.23.
//


import Foundation

@propertyWrapper
public struct UDStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let defaults = UserDefaults.standard
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            if let data = defaults.value(forKey: key) as? Data {
                return (try? PropertyListDecoder().decode(T.self, from: data)) ?? defaultValue
            } else {
                return defaults.value(forKey: key) as? T ?? defaultValue
            }
        }
        set {
            let mirror = Mirror(reflecting: newValue)
            if mirror.displayStyle == .optional, mirror.children.isEmpty {
                defaults.removeObject(forKey: key)
            } else {
                let value: Any?
                if let encoded = try? PropertyListEncoder().encode(newValue) {
                    value = encoded
                } else {
                    value = newValue
                }
                defaults.set(value, forKey: key)
            }
        }
    }
}


