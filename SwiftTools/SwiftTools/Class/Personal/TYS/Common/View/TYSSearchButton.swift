//
//  TYSSearchButton.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/21.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSSearchButton: UIButton {

    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 35))
        self.backgroundColor = tys_searchBackgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(hexString("#FF999999"), for: .normal)
        self.titleLabel?.font = AdaptFont(fontSize: 16)
        self.setImage(UIImage(named: "default_nav_search"), for: .normal)
        self.setImage(UIImage(named: "default_nav_search"), for: .highlighted)
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, AdaptW(w: 15), 0, 0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, AdaptW(w: 5), 0, 0)
        self.contentHorizontalAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
