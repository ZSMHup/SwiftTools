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
        
        let object: [Any] = cacheValue as! [Any]
        let model = JSONDeserializer<TYSPersonalModel>.deserializeModelArrayFrom(array: object)
        successCompletion((model?.first ?? TYSPersonalModel())!)
        
    }, successCompletion: { (successValue) in
        
        let object: [Any] = successValue as! [Any]
        let model = JSONDeserializer<TYSPersonalModel>.deserializeModelArrayFrom(array: object)
        successCompletion((model?.first ?? TYSPersonalModel())!)
        
    }) { (error) in
        failureCompletion(error)
    }
}
