//
//  AYBaseViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/8.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let ChildScrollViewDidScrollNSNotification: NSNotification.Name = NSNotification.Name(rawValue: "ChildScrollViewDidScrollNSNotification")
let ChildScrollViewRefreshStateNSNotification: NSNotification.Name = NSNotification.Name(rawValue: "ChildScrollViewRefreshStateNSNotification")

class AYBaseViewController: UIViewController, UIScrollViewDelegate {

    var lastContentOffset: CGPoint = CGPoint.zero
    var baseScrollView: UIScrollView?
    var isFirstViewLoaded: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetDifference = scrollView.contentOffset.y - lastContentOffset.y;
        
        NotificationCenter.default.post(name: ChildScrollViewDidScrollNSNotification, object: nil, userInfo: ["scrollingScrollView" : scrollView, "offsetDifference" : offsetDifference])
        lastContentOffset = scrollView.contentOffset;
    }

}
