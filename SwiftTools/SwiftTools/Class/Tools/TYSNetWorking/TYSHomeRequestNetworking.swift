//
//  TYSHomeRequestNetworking.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

/// 查询首页热门，推荐，回听数据
///
/// - Parameters:
///   - paramterDic: 参数
///   - cacheCompletion: 缓存回调
///   - successCompletion: 成功回调
///   - failureCompletion: 失败回调
func requestHomeListData(
    paramterDic: Dictionary<String, Any>,
    cacheCompletion: @escaping (TYSHomeLiveModel)->(),
    successCompletion: @escaping (TYSHomeLiveModel)->(),
    failureCompletion: @escaping (Any)->()) {
    
    requestHanlder(paramterDic: paramterDic, cache: true, modelsClass: "TYSHomeLiveModel", cacheCompletion: { (cacheValue) in
        cacheCompletion(cacheValue as! TYSHomeLiveModel)
    }, successCompletion: { (successValue) in
        successCompletion(successValue as! TYSHomeLiveModel)
    }) { (error) in
        failureCompletion(error)
    }
}
