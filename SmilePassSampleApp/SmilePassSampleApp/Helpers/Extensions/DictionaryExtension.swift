//
//  DictionaryExtension.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 20/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func getString(forKey key: Key, pointValue val: Int = 0, defaultValue def: String = "") -> String {
        if let str = self[key] as? String {
            return str
        } else if let num = self[key] as? NSNumber {
            let doubleVal = Double(truncating: num)
            return String(format: "%0.\(val)f", doubleVal)
        }
        return def
    }
    
    func getDouble(forKey key: Key, defaultValue def: Double = 0.0) -> Double {
        if let num = self[key] as? Double {
            return num
        } else if let str = self[key] as? String {
            return Double(str) ?? def
        } else if let num = self[key] as? NSNumber {
            return Double(truncating: num)
        }
        return def
    }
    
    func getInt(forKey key: Key, defaultValue def: Int = 0) -> Int {
        if let num = self[key] as? Int {
            return num
        } else if let str = self[key] as? String {
            return Int(str) ?? def
        } else if let num = self[key] as? NSNumber {
            return Int(truncating: num)
        }
        return def
    }
    
    func getBool(forKey key: Key, defaultValue def: Bool = false) -> Bool {
        if let val = self[key] as? Bool {
            return val
        } else if let num = self[key] as? NSNumber {
            return num == 1
        }
        return def
    }
    
}
