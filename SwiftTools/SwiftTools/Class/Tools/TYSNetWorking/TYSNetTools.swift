//
//  TYSNetTools.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import SwiftyJSON

private let url = "http://api.touyanshe.com.cn/touyanshe_api/s/api"
private var modelClass: String?

func requestHanlder(
    paramterDic: Dictionary<String, Any>,
    cache: Bool,
    modelsClass: String,
    cacheCompletion: @escaping (Any)->(),
    successCompletion: @escaping (Any)->(),
    failureCompletion: @escaping (Any)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    modelClass = modelsClass
    request(url: url, params: params).cache(cache).responseCacheAndJson { (jsonValue) in
        switch jsonValue.result {
        case .success(let json):
            if jsonValue.isCacheData {
                let model = convertToModel(json: json)
                cacheCompletion(model)
            } else {
                let model = convertToModel(json: json)
                successCompletion(model)
            }
        case .failure(let error):
            failureCompletion(error)
        }
    }
}

private func getAPPName() -> String {
    let nameKey = "CFBundleName"
    let appName = Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
    return appName!
}

private func convertToModel(json: Any) -> Any {
    
    var resultDic = JSON(json)
    var model = TYSRequestModel()
    let object = resultDic["object"]
    
    let cla = NSClassFromString(getAPPName() + "." + modelClass!) as! TYSRequestModel.Type
    if object.type == Type.array {
        model = cla.init()
//        model.responseResultList = Array(object)
        model.responseResultList = object.array!
    } else if object.type == Type.dictionary {
        let obj = JSON(arrayLiteral: object)
        model = cla.init()
        model.responseResultList = obj.array!
    } else if object.type == Type.string || object.type == Type.number {
        model = cla.init()
        model.responseResultString = object.string!
    } else {
        model = cla.init()
    }
    
    if (resultDic["msg"].string != nil) {
        model.msg = resultDic["msg"].string!
    }
    if (resultDic["statusCode"].string != nil) {
        model.statusCode = resultDic["statusCode"].string!
    }
    return model
}

private func configParameters(paramterDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
    var paramsDic = [String : AnyObject]()
    let token = "87e601929ef0a446708490d4b692b5"
    paramsDic["accessToken"] = token as AnyObject
    paramsDic["version"] = "4.0.3" as AnyObject
    paramsDic["deviceType"] = "1" as AnyObject
    for e in paramterDic {
        paramsDic[e.key] = paramterDic[e.key] as AnyObject
    }
    return paramsDic
}


