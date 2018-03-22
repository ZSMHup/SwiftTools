//
//  TabBarItemContentView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarItemContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        highlightTextColor = UIColor.black
        highlightIconColor = UIColor.black
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
