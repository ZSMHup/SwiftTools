//
//  UserDefaults+Save.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

extension UserDefaults {
    func saveCustomObject(customObject object: NSCoding, key: String) { //2
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    
    func getCustomObject(forKey key: String) -> AnyObject? { //3
        if key.isEmpty {
            return nil
        }
        let decodedObject = self.object(forKey: key) as? Data
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        
        return nil
    }
}
