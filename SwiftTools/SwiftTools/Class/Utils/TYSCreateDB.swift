//
//  TYSCreateDB.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import SQLite

private var db: Connection?

func getDB() -> Connection {
    if db == nil {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        print("path: \(path)")
        db = try! Connection("\(path)/db.sqlite3")
        db?.busyTimeout = 5.0
    }
    return db!
}



