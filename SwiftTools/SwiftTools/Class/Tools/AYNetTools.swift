//
//  AYNetTools.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import Alamofire


/// 网络请求
///
/// - Parameters:
///   - url: url
///   - method: .get .post ... 默认.get
///   - params: 参数字典
///   - dynamicParams: 变化的参数，例如 时间戳-token 等
///   - encoding: 编码方式
///   - headers: 请求头
/// - Returns:
@discardableResult
public func request(
    url: String,
    method: HTTPMethod = .post,
    params: Parameters? = nil,
    dynamicParams: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil) -> AYRequestTaskManager {
    
    return AYRequestManager.default.request(url: url, method: method, params: params, dynamicParams: dynamicParams, encoding: encoding, heards: headers)
}

/// 清除所有缓存
public func removeAllCache(completion: @escaping (Bool)->()) {
    AYRequestManager.default.removeAllCache(completion: completion)
}

/// 根据url和params清除缓存
public func removeObjectCache(_ url: String, params: [String: Any]? = nil, dynamicParams: Parameters? = nil, completion: @escaping (Bool)->()) {
    AYRequestManager.default.removeObjectCache(url, params: params,dynamicParams: dynamicParams, completion: completion)
}

protocol AYRequestProtocol {
    /// 是否缓存数据
    func cache(_ cache: Bool) -> AYRequestTaskManager
    /// 获取缓存Data
    @discardableResult
    func cacheData(completion: @escaping (Data)->()) -> AYDataResponse
    /// 响应Data
    func responseData(completion: @escaping (AYValue<Data>)->())
    /// 先获取Data缓存，再响应Data
    func responseCacheAndData(completion: @escaping (AYValue<Data>)->())
    /// 获取缓存String
    @discardableResult
    func cacheString(completion: @escaping (String)->()) -> AYStringResponse
    /// 响应String
    func responseString(completion: @escaping (AYValue<String>)->())
    /// 先获取缓存String,再响应String
    func responseCacheAndString(completion: @escaping (AYValue<String>)->())
    /// 获取缓存JSON
    @discardableResult
    func cacheJson(completion: @escaping (Any)->()) -> AYJsonResponse
    /// 响应JSON
    func responseJson(completion: @escaping (AYValue<Any>)->())
    /// 先获取缓存JSON，再响应JSON
    func responseCacheAndJson(completion: @escaping (AYValue<Any>)->())
}
protocol AYJsonResponseProtocol {
    /// 响应JSON
    func responseJson(completion: @escaping (AYValue<Any>)->())
}
protocol AYDataResponseProtocol {
    /// 响应Data
    func responseData(completion: @escaping (AYValue<Data>)->())
}
protocol AYStringResponseProtocol {
    /// 响应String
    func responseString(completion: @escaping (AYValue<String>)->())
}
