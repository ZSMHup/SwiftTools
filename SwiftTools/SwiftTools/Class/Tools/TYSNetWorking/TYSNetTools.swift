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

//let url = "http://tyapi.znzkj.net/touyanshe_api/s/api"
let url = "http://api.touyanshe.com.cn/touyanshe_api/s/api"

private var modelClass: String?

func requestHanlder(
    paramterDic: Dictionary<String, Any>,
    cache: Bool,
    cacheCompletion: @escaping (AnyObject)->(),
    successCompletion: @escaping (AnyObject)->(),
    failureCompletion: @escaping (Any)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    printLog("*****请求地址: \(url)")
    printLog("\n***请求参数开始***\n\(params)\n***请求参数结束***")
    request(url: url, params: params).cache(cache).responseCacheAndString { (stringValue) in
        
        switch stringValue.result {
        case .success(let string):
            
            if !string.isEmpty {
                if !stringValue.isCacheData {
                    printLog("\n***返回数据开始***\n\(string)\n***返回数据结束***")
                }

                let resultDic = getDictionaryFromJSONString(jsonString: string)
                let msg: String = resultDic["msg"] as! String
                let statusCode: String = resultDic["statusCode"] as! String
                var object = resultDic["object"]
                
                
                if resultDic.count == 0 {
                    showOnlyText(text: "服务器异常")
                    return
                }
                
                if statusCode != "00000" {
                    showOnlyText(text: msg)
                    if msg == "accessToken失效" && statusCode == "90000" {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            NotificationCenter.default.post(name: LogoutNotification, object: nil)
                        }
                    }
                    return
                }
                
                if object is Array<Any> {
                    printLog("Array")
                    
                } else if object is Dictionary<String, Any> {
                    printLog("Dictionary")
                    object = [object] as AnyObject
                } else if object is String {
                    printLog("String")
                    object = [object] as AnyObject
                } else if object is NSNull {
                    printLog("NSNull")
                    object = [] as AnyObject
                }
                
                if stringValue.isCacheData {
                    cacheCompletion(object!)
                } else {
                    successCompletion(object!)
                }
            }
        case .failure(let error):
            printLog("\n*****错误信息\n \(error) \n*****")
            failureCompletion(error)
        }
    }
}

func getDictionaryFromJSONString(jsonString: String) -> Dictionary<String, AnyObject> {
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! Dictionary
    }
    return Dictionary()
}

func configParameters(paramterDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
    
    var paramsDic = [String : AnyObject]()
    
    let loginModel = TYSLoginModel.manager.readData()
    let token = loginModel.access_token ?? ""
    paramsDic["accessToken"] = token as AnyObject
    paramsDic["version"] = "4.0.5" as AnyObject
    paramsDic["deviceType"] = "1" as AnyObject
    for e in paramterDic {
        paramsDic[e.key] = paramterDic[e.key] as AnyObject
    }
    return paramsDic
}


