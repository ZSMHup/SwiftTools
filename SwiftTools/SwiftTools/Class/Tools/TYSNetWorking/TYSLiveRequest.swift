//
//  TYSLiveRequest.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

// MARK: 查询直播详情
func requestLiveDetail(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSLiveDetailModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLiveDetailModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 报名接口
func requestLiveSignUp(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSLiveSignupModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLiveSignupModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 加入直播
func requestLiveJoinLive(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSLiveJoinLiveModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLiveJoinLiveModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询直播问题列表
func requestLiveQuestionList(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSLiveQuestionModel)->(),
    successCompletion: @escaping (TYSLiveQuestionModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLiveQuestionModel>.deserializeFrom(dict: obj)!
        cacheCompletion(model)
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSLiveQuestionModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}
