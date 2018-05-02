//
//  AYHUD.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/10.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import PKHUD

let time = 1.5


func hidHUD() {
    SwiftProgressHUD.hideAllHUD()
}

/// 加载菊花
func showWait() {
    SwiftProgressHUD.showWait()
}

/// 失败
func showFail(text: String) {
    hidHUD()
    SwiftProgressHUD.showFail(text)
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        hidHUD()
    }
}

/// 只有文字
func showOnlyText(text: String) {
    SwiftProgressHUD.showOnlyText(text)
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        hidHUD()
    }
}

func showHud(string: String) {
    HUD.dimsBackground = false
    HUD.allowsInteraction = true
    HUD.show(.label(string))
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        HUD.hide()
    }
}
