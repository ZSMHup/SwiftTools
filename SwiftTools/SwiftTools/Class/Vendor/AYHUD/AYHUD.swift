//
//  AYHUD.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/10.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let time = 1.5

func hidHUD() {
    SwiftNotice.clear()
}

/// 加载菊花
func showWait() {
    SwiftNotice.wait()
    
}

func showSuccess(text: String) {
    SwiftNotice.showNoticeWithText(.success, text: text, autoClear: true, autoClearTime: Int(1.5))
}

/// 失败
func showFail(text: String) {
    SwiftNotice.showNoticeWithText(.error, text: text, autoClear: true, autoClearTime: Int(1.5))
}

/// 只有文字
func showOnlyText(text: String) {
    SwiftNotice.showText(text, autoClear: true, autoClearTime: Int(1.5))
}



