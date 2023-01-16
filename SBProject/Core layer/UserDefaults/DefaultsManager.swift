//
//  DefaultsManager.swift
//  Pixpot
//
//  Created by Евгений Юнкин on 14.01.23.
//

import Foundation


final class DefaultsManager {
    
    @UDStorage(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
    
    @UDStorage(key: "isAskedForLocation", defaultValue: false)
    static var isAskedForLocation: Bool
    
    @UDStorage(key: "isAskedForPush", defaultValue: false)
    static var isAskedForPush: Bool
    
}
