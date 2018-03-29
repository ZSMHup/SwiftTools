//
//  TYSHomeRequestNetworking.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

/// 查询首页热门，推荐，回听数据
///
/// - Parameters:
///   - paramterDic: 参数
///   - cacheCompletion: 缓存回调
///   - successCompletion: 成功回调
///   - failureCompletion: 失败回调
func requestHomeListData(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSHomeLiveModel)->(),
    successCompletion: @escaping (TYSHomeLiveModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, modelsClass: "TYSHomeLiveModel", cacheCompletion: { (cacheValue) in
        let obj: [String : Any] = cacheValue as! [String : Any]
        let model = JSONDeserializer<TYSHomeLiveModel>.deserializeFrom(dict: obj)!
        cacheCompletion(model)
        
    }, successCompletion: { (successValue) in
        let obj: [String : Any] = successValue as! [String : Any]
        let model = JSONDeserializer<TYSHomeLiveModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

func requestInterestedPeople(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSInterestedPeopleModel)->(),
    successCompletion: @escaping (TYSInterestedPeopleModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    
    request(url: url, params: params).cache(true).responseCacheAndString { (stringValue) in
        switch stringValue.result {
        case .success(let json):
            if stringValue.isCacheData {
//                print(json)
                
                
            } else {
                print("==========\n \(json) \n========")
//                var models = TYSInterestedPeopleModel()
                
//                let model = JSONDeserializer<TYSRequestModel>.deserializeFrom(json: json)
//                let models = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: model?.object)
//                print(models)
                
            }
        case .failure(let error):
            print(error)
            failureCompletion(error)
        }
    }
}















