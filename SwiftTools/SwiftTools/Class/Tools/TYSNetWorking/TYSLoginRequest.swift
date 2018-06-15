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
            
        let object: [Any] = successValue as! [Any]
        let model = JSONDeserializer<TYSLoginModel>.deserializeModelArrayFrom(array: object)
        successCompletion((model?.first ?? TYSLoginModel())!)
        
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
        let object: [Any] = successValue as! [Any]
        let model = JSONDeserializer<TYSLoginGetCaptcha>.deserializeModelArrayFrom(array: object)
        successCompletion((model?.first ?? TYSLoginGetCaptcha())!)
    }) { (error) in
        failureCompletion(error)
    }
}
