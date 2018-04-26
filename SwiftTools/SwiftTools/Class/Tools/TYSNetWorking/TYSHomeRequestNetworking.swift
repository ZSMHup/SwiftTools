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
        
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = {} as AnyObject
        }
        let object = resultDic["object"]
        
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSHomeLiveModel>.deserializeFrom(dict: obj)!
        cacheCompletion(model)
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = {} as AnyObject
        }
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
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSInterestedPeopleModel])
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: object)
      
        successCompletion(model! as! [TYSInterestedPeopleModel])
        
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询分析师列表
func requestAnalystList(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSInterestedPeopleModel])->(),
    successCompletion: @escaping ([TYSInterestedPeopleModel])->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSInterestedPeopleModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSInterestedPeopleModel])
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
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
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSHomeADModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSHomeADModel])
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
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
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSLiveCommonModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSLiveCommonModel])
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSLiveCommonModel>.deserializeModelArrayFrom(array: object)
        
        successCompletion(model! as! [TYSLiveCommonModel])
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询荐读列表
func requestRecReadList(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSRecReadModel])->(),
    successCompletion: @escaping ([TYSRecReadModel])->(),
    failureCompletion: @escaping (Any)->()) {
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSRecReadModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSRecReadModel])
    }, successCompletion: { (successValue) in
        let resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSRecReadModel>.deserializeModelArrayFrom(array: object)
        
        successCompletion(model! as! [TYSRecReadModel])
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询荐读详情
func requestRecReadDetail(
    paramterDic: Dictionary<String, Any>,
    successCompletion: @escaping (TYSRecReadDetailModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: false, cacheCompletion: { (cacheValue) in
        
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = {} as AnyObject
        }
        let object = resultDic["object"]
        let obj: [String : Any] = object as! [String : Any]
        let model = JSONDeserializer<TYSRecReadDetailModel>.deserializeFrom(dict: obj)!
        successCompletion(model)
    }) { (error) in
        failureCompletion(error)
    }
}

// MARK: 查询荐读与我相关
func requestRecReadAboutMeList(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping ([TYSRecReadAboutMeModel])->(),
    successCompletion: @escaping ([TYSRecReadAboutMeModel])->(),
    failureCompletion: @escaping (Any)->()) {
    requestHanlder(paramterDic: paramterDic, cache: true, cacheCompletion: { (cacheValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: cacheValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSRecReadAboutMeModel>.deserializeModelArrayFrom(array: object)
        
        cacheCompletion(model! as! [TYSRecReadAboutMeModel])
    }, successCompletion: { (successValue) in
        var resultDic = getDictionaryFromJSONString(jsonString: successValue as! String)
        if resultDic["object"] is NSNull {
            resultDic["object"] = [] as AnyObject
        }
        let object: [Any] = resultDic["object"] as! [Any]
        
        let model = JSONDeserializer<TYSRecReadAboutMeModel>.deserializeModelArrayFrom(array: object)
        
        successCompletion(model! as! [TYSRecReadAboutMeModel])
    }) { (error) in
        failureCompletion(error)
    }
}





