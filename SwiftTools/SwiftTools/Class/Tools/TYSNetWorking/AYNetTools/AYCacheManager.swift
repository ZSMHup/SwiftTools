//
//  AYCacheManager.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import Cache

class AYCacheManager {
    static let `default` = AYCacheManager()
    /// Manage storage
    private var storage: Storage?
    
    private var filePath: String?
    /// init
    init() {
        let diskConfig = DiskConfig(name: "AYCache", directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("TYSCache"))
        filePath = diskConfig.directory?.path
        let memoryConfig = MemoryConfig(expiry: .never)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        } catch {
            printLog(error)
        }
    }
    /// 清除所有缓存
    ///
    /// - Parameter completion: 完成闭包
    func removeAllCache(completion: @escaping (Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// 根据key值清除缓存
    func removeObjectCache(_ cacheKey: String, completion: @escaping (Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// 异步读取缓存
    func object<T: Codable>(ofType type: T.Type, forKey key: String, completion: @escaping (Cache.Result<T>)->Void) {
        storage?.async.object(ofType: type, forKey: key, completion: completion)
    }
    /// 读取缓存
    func objectSync<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            return (try storage?.object(ofType: type, forKey: key)) ?? nil
        } catch {
            return nil
        }
    }
    /// 异步存储
    func setObject<T: Codable>(_ object: T, forKey: String) {
        storage?.async.setObject(object, forKey: forKey, completion: { _ in
        })
    }
    
    func getFileSize() -> Double  {
        var size: Double = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: filePath!, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: filePath!)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = filePath?.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath!)
                        size += attr[FileAttributeKey.size] as! Double
                    } catch  {
                        printLog("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: filePath!)
                    size += attr[FileAttributeKey.size] as! Double
                    
                } catch  {
                    printLog("error :\(error)")
                }
            }
        }
        return size
    }
}
