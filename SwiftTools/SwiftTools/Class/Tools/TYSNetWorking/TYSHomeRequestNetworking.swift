//
//  TYSHomeRequestNetworking.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

// MARK: 查询首页热门，推荐，回听数据
func requestHomeListData(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSHomeLiveModel)->(),
    successCompletion: @escaping (TYSHomeLiveModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        
        let resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSHomeLiveModel>.deserializeFrom(dict: obj)!
        cacheCompletion(model)
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSHomeLiveModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 可能感兴趣的人
func requestInterestedPeople(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSInterestedPeopleModel])->(),
    successCompletion: @escaping ([TYSInterestedPeopleModel])->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSInterestedPeopleModel])
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: object)
      
        successCompletion(model! as! [TYSInterestedPeopleModel])
        
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 主页广告列表
func requestHomeAD(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSHomeADModel])->(),
    successCompletion: @escaping ([TYSHomeADModel])->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSHomeADModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSHomeADModel])
        
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSHomeADModel>.deserializeModelArrayFrom(array: object)
        
        successCompletion(model! as! [TYSHomeADModel])
        
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询直播列表
func requestLiveList(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSLiveCommonModel])->(),
    successCompletion: @escaping ([TYSLiveCommonModel])->(),
    failureCompletion: @escaping (Any)->()) {
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSLiveCommonModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSLiveCommonModel])
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSLiveCommonModel>.deserializeModelArrayFrom(array: object)
        
        successCompletion(model! as! [TYSLiveCommonModel])
    }) { (error) in
        failureCompletion(error)
    }
}











