//
//  PersistenceManager.swift
//  spotify-uikit-app
//
//  Created by loratech on 22/02/24.
//

import Foundation

enum Keys: String {
    case refreshToken
    case accessToken
    case expirationToken
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    static func save(_ value: Any?, forKey key: Keys){
        defaults.setValue(value, forKey: key.rawValue)
    }
}
