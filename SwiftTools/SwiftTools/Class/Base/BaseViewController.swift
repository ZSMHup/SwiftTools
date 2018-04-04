//
//  BaseViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)
    var baseScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
    }
    
    deinit {
        print("deinit: \(self.classForCoder)")
    }


}
