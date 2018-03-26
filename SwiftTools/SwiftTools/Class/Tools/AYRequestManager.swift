//
//  AYRequestManager.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import Alamofire

class AYRequestManager {
    static let `default` = AYRequestManager()
    private var requestTasks = [String: AYRequestTaskManager]()
    
    func request(
        url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        dynamicParams: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        heards: HTTPHeaders? = nil) -> AYRequestTaskManager {
        
        let key = cacheKey(url, params, dynamicParams)
        var taskManager: AYRequestTaskManager?
        if requestTasks[key] == nil {
            taskManager = AYRequestTaskManager()
            requestTasks[key] = taskManager
        } else {
            taskManager = requestTasks[key]
        }
        taskManager?.completionClosure = {
            self.requestTasks.removeValue(forKey: key)
        }
        
        var tempParam = params == nil ? [:] : params!
        let dynamicTempParam = dynamicParams == nil ? [:] : dynamicParams!
        dynamicTempParam.forEach { (arg) in
            tempParam[arg.key] = arg.value
        }
        
        taskManager?.request(url: url, method: method, params: params, cacheKey: key, encoding: encoding, headers: heards)
        
        return taskManager!
    }
    
    /// 取消请求
    func cancel(url: String, params: Parameters? = nil, dynamicParams: Parameters? = nil) {
        let key = cacheKey(url, params, dynamicParams)
        let taskManager = requestTasks[key]
        taskManager?.dataRequest?.cancel()
    }
    
    /// 清除所有缓存
    func removeAllCache(completion: @escaping (Bool)->()) {
        AYCacheManager.default.removeAllCache(completion: completion)
    }
    
    /// 根据key值清除缓存
    func removeObjectCache(_ url: String, params: [String: Any]? = nil, dynamicParams: Parameters? = nil,  completion: @escaping (Bool)->()) {
        let key = cacheKey(url, params, dynamicParams)
        AYCacheManager.default.removeObjectCache(key, completion: completion)
    }
    
}

// MARK: - 请求任务
public class AYRequestTaskManager {
    fileprivate var dataRequest: DataRequest?
    fileprivate var cache: Bool = false
    fileprivate var cacheKey: String!
    fileprivate var completionClosure: (() -> ())?
    
    @discardableResult
    fileprivate func request(
        url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        cacheKey: String,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> AYRequestTaskManager {
        
        self.cacheKey = cacheKey
        dataRequest = Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        return self
    }
    
    /// 是否缓存数据
    public func cache(_ cache: Bool) -> AYRequestTaskManager {
        self.cache = cache
        return self
    }
    
    /// 获取缓存Data
    @discardableResult
    public func cacheData(completion: @escaping (Data)->()) -> AYDataResponse {
        let dataResponse = AYDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return dataResponse.cacheData(completion: completion)
    }
    
    /// 先获取Data缓存，再响应Data
    public func responseCacheAndData(completion: @escaping (AYValue<Data>)->()) {
        let dataResponse = AYDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        dataResponse.responseCacheAndData(completion: completion)
    }
    /// 获取缓存String
    @discardableResult
    public func cacheString(completion: @escaping (String)->()) -> AYStringResponse {
        let stringResponse = AYStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return stringResponse.cacheString(completion:completion)
    }
    /// 响应String
    public func responseString(completion: @escaping (AYValue<String>)->()) {
        let stringResponse = AYStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseString(completion: completion)
    }
    /// 先获取缓存String,再响应String
    public func responseCacheAndString(completion: @escaping (AYValue<String>)->()) {
        let stringResponse = AYStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseCacheAndString(completion: completion)
    }
    /// 获取缓存JSON
    @discardableResult
    public func cacheJson(completion: @escaping (Any)->()) -> AYJsonResponse {
        let jsonResponse = AYJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return jsonResponse.cacheJson(completion:completion)
    }
    /// 响应JSON
    public func responseJson(completion: @escaping (AYValue<Any>)->()) {
        let jsonResponse = AYJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        jsonResponse.responseJson(completion: completion)
    }
    /// 先获取缓存JSON，再响应JSON
    public func responseCacheAndJson(completion: @escaping (AYValue<Any>)->()) {
        let jsonResponse = AYJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        jsonResponse.responseCacheAndJson(completion: completion)
    }
}

// MARK: - AYBaseResponse
public class AYResponse {
    fileprivate var dataRequest: DataRequest
    fileprivate var cache: Bool
    fileprivate var cacheKey: String
    fileprivate var completionClosure: (()->())?
    fileprivate init(dataRequest: DataRequest, cache: Bool, cacheKey: String, completionClosure: (()->())?) {
        self.dataRequest = dataRequest
        self.cache = cache
        self.cacheKey = cacheKey
        self.completionClosure = completionClosure
    }
    ///
    fileprivate func response<T>(response: DataResponse<T>, completion: @escaping (AYValue<T>)->()) {
        responseCache(response: response) { (result) in
            completion(result)
        }
    }
    /// isCacheData
    fileprivate func responseCache<T>(response: DataResponse<T>, completion: @escaping (AYValue<T>)->()) {
        if completionClosure != nil { completionClosure!() }
        let result = AYValue(isCacheData: false, result: response.result, response: response.response)
//        print("--------")
//        switch response.result {
//        case .success(let value): print(value)
        if self.cache {/// 写入缓存
            AYCacheManager.default.setObject(response.data, forKey: self.cacheKey)
            }
//        case .failure(let error): print(error.localizedDescription)
//        }
        completion(result)
    }
}

// MARK: - AYJsonResponse
public class AYJsonResponse: AYResponse , AYJsonResponseProtocol {
    /// 响应JSON
    func responseJson(completion: @escaping (AYValue<Any>)->()) {
        dataRequest.responseJSON(completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    fileprivate func responseCacheAndJson(completion: @escaping (AYValue<Any>)->()) {
        if cache { cacheJson(completion: { (json) in
            let res = AYValue(isCacheData: true, result: Alamofire.Result.success(json), response: nil)
            completion(res)
        }) }
        dataRequest.responseJSON { (response) in
            self.responseCache(response: response, completion: completion)
        }
    }
    @discardableResult
    fileprivate func cacheJson(completion: @escaping (Any)->()) -> AYJsonResponse {
        AYCacheManager.default.object(ofType: Data.self, forKey: cacheKey) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value(let data):
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        DispatchQueue.main.async {/// 主线程
                            //print(json)
                            completion(json)
                        }
                    }
                case .error(_):
                    print("读取缓存失败")
                }
            }
        }
        return self
    }
}

// MARK: - AYStringResponse
public class AYStringResponse: AYResponse, AYStringResponseProtocol {
    /// 响应String
    func responseString(completion: @escaping (AYValue<String>)->()) {
        dataRequest.responseString(completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    @discardableResult
    fileprivate func cacheString(completion: @escaping (String)->()) -> AYStringResponse {
        AYCacheManager.default.object(ofType: Data.self, forKey: cacheKey) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value(let data):
                    if let str = String(data: data, encoding: .utf8) {
                        completion(str)
                    }
                case .error(_):
                    print("读取缓存失败")
                }
            }
        }
        return self
    }
    fileprivate func responseCacheAndString(completion: @escaping (AYValue<String>)->()) {
        if cache { cacheString(completion: { str in
            let res = AYValue(isCacheData: true, result: Alamofire.Result.success(str), response: nil)
            completion(res)
        })}
        dataRequest.responseString { (response) in
            self.responseCache(response: response, completion: completion)
        }
    }
}

// MARK: - AYDataResponse
public class AYDataResponse: AYResponse, AYDataResponseProtocol {
    /// 响应Data
    func responseData(completion: @escaping (AYValue<Data>)->()) {
        dataRequest.responseData(completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    @discardableResult
    fileprivate func cacheData(completion: @escaping (Data)->()) -> AYDataResponse {
        AYCacheManager.default.object(ofType: Data.self, forKey: cacheKey) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value(let data):
                    completion(data)
                case .error(_):
                    print("读取缓存失败")
                }
            }
        }
        return self
    }
    fileprivate func responseCacheAndData(completion: @escaping (AYValue<Data>)->()) {
        if cache { cacheData(completion: { (data) in
            let res = AYValue(isCacheData: true, result: Alamofire.Result.success(data), response: nil)
            completion(res)
        }) }
        dataRequest.responseData { (response) in
            self.responseCache(response: response, completion: completion)
        }
    }
}
