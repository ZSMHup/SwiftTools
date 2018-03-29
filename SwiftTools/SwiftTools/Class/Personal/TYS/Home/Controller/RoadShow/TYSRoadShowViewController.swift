//
//  TYSRoadShowViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRoadShowViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "路演"
        
//        let pageMenu = TYSPageMenu(frame: CGRect(x: 0, y: 100, width: kScreenW, height: 50)).pageMenu(trackerStyle: .line)
//        let items = ["第一页","第二页","第三页","第四页"]
//        pageMenu.setItems(items: items, selectedItemIndex: 0)
//        view.addSubview(pageMenu)
        
        let items = ["第一页","第二页","第三页","第四页"]
        let pageMenu = AYPageMenu(frame: CGRect(x: 0, y: 100, width: kScreenW, height: 50)).pageMenu(items: items)
        pageMenu.setItems(items: items, selectedItemIndex: 0)
        view.addSubview(pageMenu)
    }



}
