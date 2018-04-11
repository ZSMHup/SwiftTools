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
//let url = "http://tyapi.znzkj.net/touyanshe_api/s/api"

private var modelClass: String?

func requestHanlder(
    paramterDic: Dictionary<String, Any>,
    cache: Bool,
    cacheCompletion: @escaping (Any)->(),
    successCompletion: @escaping (Any)->(),
    failureCompletion: @escaping (Any)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    print("***请求参数开始***\n\(params)\n***请求参数结束***")
    request(url: url, params: params).cache(cache).responseCacheAndString { (stringValue) in
        
        switch stringValue.result {
        case .success(let string):
            
            if !string.isEmpty {
                if !stringValue.isCacheData {
                    print("***返回数据开始***\n\(string)\n***返回数据结束***")
                }
                
                let resultDic = getDictionaryFromJSONString(jsonString: string)
                if resultDic.count == 0 {
                    showOnlyText(text: "服务器异常")
                    return
                }
                let msg: String = resultDic["msg"] as! String
                let statusCode: String = resultDic["statusCode"] as! String
                
                if statusCode != "00000" {
                    showOnlyText(text: msg)
                    return
                }
                
                if stringValue.isCacheData {
                    cacheCompletion(string as Any)
                } else {
                    
                    successCompletion(string as Any)
                }
            }
        case .failure(let error):
            print("*****错误信息\n \(error) \n*****")
            failureCompletion(error)
        }
    }
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
    let token = "32d6ac1566e77585f83e4386727a97c8"
    paramsDic["accessToken"] = token as AnyObject
    paramsDic["version"] = "4.0.5" as AnyObject
    paramsDic["deviceType"] = "1" as AnyObject
    for e in paramterDic {
        paramsDic[e.key] = paramterDic[e.key] as AnyObject
    }
    return paramsDic
}


