//
//  UserDefaultsHelper.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation

struct UserDefaultsHelper {
    static func save(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func remove(for key: String) {
         UserDefaults.standard.removeObject(forKey: key)
    }
}
