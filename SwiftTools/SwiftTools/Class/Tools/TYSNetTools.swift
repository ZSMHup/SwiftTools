//
//  TYSNetTools.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

private let url = "http://api.touyanshe.com.cn/touyanshe_api/s/api"

func requestHomeListData(paramterDic: Dictionary<String, Any>, completion: @escaping (AYValue<String>)->()) {
    
    let params = configParameters(paramterDic: paramterDic)
    
    request(url: url, params: params).cache(true).responseCacheAndString { (value) in
        
        switch value.result {
            
        case .success(let string):
            
            if value.isCacheData {
                print("===缓存===\n \(string) \n===结束===")
                
            } else {
                print("===网络===\n \(string) \n===结束===")
            }
            
        case .failure(let error):
            print(error)
        }
    }
    
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


