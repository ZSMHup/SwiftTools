//
//  TYSTelViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSTelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "电话会议"
        
        let items = ["最新","回放","我的"]
        let controllers = ["TYSTelNewsLiveViewController", "TYSTelBackViewController", "TYSTelMyViewController"]
        let pageMenu = AYSwitchVCContentView(frame: CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: kScreenH - kNavigationBarHeight)).initWithItems(items: items, controllers: controllers)
        view.addSubview(pageMenu)
    }



}
