//
//  UserDefault.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    @UserDefault(key: Shopping.key, defaultValue: Shopping.defaultList)
    var list: [Shopping]
    
    init() { }
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private var key: String
    private var defaultValue: T
    //userDefault를 옵셔널로 사용한다면 defaultValue 구현안해도 됨.
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(T.self, from: savedData) {
                    return loadedData
                }
            }
            
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        }
    }
}
