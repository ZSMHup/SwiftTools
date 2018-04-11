//
//  TYSLoginRequest.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

/// 手机验证码登录
func requestMobileLogin(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSLoginModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLoginModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

/// 获取验证码
func requestGetCaptcha(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSLoginGetCaptcha)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLoginGetCaptcha>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}
