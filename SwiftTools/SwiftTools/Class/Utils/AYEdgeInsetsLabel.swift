//
//  AYEdgeInsetsLabel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class AYEdgeInsetsLabel: UILabel {
    
    private var _contentInset: UIEdgeInsets?
    
    func setContentInset(contentInset: UIEdgeInsets) {
        _contentInset = contentInset
        
        self.setNeedsDisplay()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, _contentInset!))
    }
    
    override func sizeToFit() {
        
    }
}
