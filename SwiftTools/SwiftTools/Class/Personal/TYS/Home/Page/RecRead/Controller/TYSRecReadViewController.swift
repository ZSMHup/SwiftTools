//
//  TYSRecReadViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "荐读"
        
        let items = ["荐读","与我相关"]
        let controllers = ["TYSRecReadContentViewController", "TYSRecReadAboutMeViewController"]
        let pageMenu = AYSwitchVCContentView(frame: CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: kScreenH - kNavigationBarHeight)).initWithItems(items: items, controllers: controllers)
        view.addSubview(pageMenu)
        
    }



}
