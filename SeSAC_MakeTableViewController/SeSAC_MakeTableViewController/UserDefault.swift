//
//  UserDefault.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    private var key: String
    private var defaultData: T?
    
    init(key: String, defaultData: T?) {
        self.key = key
        self.defaultData = defaultData
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(T.self, from: savedData) {
                    return loadedData
                }
            }
            return defaultData
        }
        set {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        }
    }
}
