//
//  TYSPersonalRequestNetWorking.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

// MARK: 用户详情接口（v2新增返回是否屏蔽好友，密友，粉丝状态）
func requestPersonalDetail(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSPersonalModel)->(),
    successCompletion: @escaping (TYSPersonalModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = {} as AnyObject
        }
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSPersonalModel>.deserializeFrom(dict: obj)!
        cacheCompletion(model)
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = {} as AnyObject
        }
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSPersonalModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}
