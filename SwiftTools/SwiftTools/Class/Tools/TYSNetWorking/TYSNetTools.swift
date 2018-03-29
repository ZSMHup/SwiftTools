//
//  TYSNetTools.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON

let url = "http://api.touyanshe.com.cn/touyanshe_api/s/api"
private var modelClass: String?

func requestHanlder(
    paramterDic: Dictionary<String, Any>,
    cache: Bool,
    modelsClass: String,
    cacheCompletion: @escaping (Any)->(),
    successCompletion: @escaping (Any)->(),
    failureCompletion: @escaping (Any)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    print("***请求参数开始***请求参数\n\(params)\n***请求参数结束***")
    modelClass = modelsClass
    let cla = NSClassFromString(getAPPName() + "." + modelClass!) as! TYSRequestModel.Type
    
    print("-------\(cla)------")
    request(url: url, params: params).cache(cache).responseCacheAndString { (stringValue) in
        switch stringValue.result {
        case .success(let string):
            if !string.isEmpty {
                let resultDic = getDictionaryFromJSONString(jsonString: string)
                let object = resultDic["object"]
                if stringValue.isCacheData {
                    convertToModel(json: string)
                    cacheCompletion(object as Any)
                } else {
                    convertToModel(json: string)
                    successCompletion(object as Any)
//                    print("***返回数据开始***请求参数\n\(string)\n***返回数据结束***")
                }
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

func getDictionaryFromJSONString(jsonString: String) -> Dictionary<String, Any> {
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! Dictionary
    }
    return Dictionary()
}

func convertToModel(json: String) {
//    let resultDic = getDictionaryFromJSONString(jsonString: json)
//    
//    let cla = NSClassFromString(getAPPName() + "." + modelClass!) as! TYSRequestModel.Type
////    let model = cla.init()
//    
//    if resultDic["msg"] != nil {
//        model.msg = String(describing: resultDic["msg"])
//    }
//    
//    if resultDic["statusCode"] != nil {
//        model.statusCode = String(describing: resultDic["statusCode"])
//    }
}

func configParameters(paramterDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
    var paramsDic = [String : AnyObject]()
    let token = "4766972c35f26b2ca8ee8c0d96fdcb7"
    paramsDic["accessToken"] = token as AnyObject
    paramsDic["version"] = "4.0.5" as AnyObject
    paramsDic["deviceType"] = "1" as AnyObject
    for e in paramterDic {
        paramsDic[e.key] = paramterDic[e.key] as AnyObject
    }
    return paramsDic
}


