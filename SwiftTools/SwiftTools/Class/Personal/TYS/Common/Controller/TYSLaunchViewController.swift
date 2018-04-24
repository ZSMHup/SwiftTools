//
//  TYSLaunchViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/23.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSLaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLaunchData()
    }
    
}

extension TYSLaunchViewController {
    private func requestLaunchData() {
        let param = [
            "requestCode" : "95000",
            "position" : "START_PAGE"]
        requestHomeAD(paramterDic: param, cacheCompletion: { (cacheValue) in
            
        }, successCompletion: { (valueArray) in
            
        }) { (failure) in
            showFail(text: "网络异常")
            
        }
    }
}
