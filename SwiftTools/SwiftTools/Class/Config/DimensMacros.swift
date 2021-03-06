//
//  DimensMacros.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let kScreenFrame = UIScreen.main.bounds
let kScreenW = kScreenFrame.size.width
let kScreenH = kScreenFrame.size.height
let kNavigationBarHeight = UIApplication.shared.statusBarFrame.size.height + 44.0


func AdaptW(w: CGFloat) -> CGFloat {
    return kScreenW / 375 * (w) * 1.0
}

func AdaptH(h: CGFloat) -> CGFloat {
    return (kScreenH == 812.0 ? 667.0 / 667.0 : kScreenH / 667.0) * (h) * 1.0
}

func AdaptFont(fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: AdaptH(h: fontSize))
}

func SystemFont(fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize)
}
// 获取项目名称
func getAPPName() -> String {
    let nameKey = "CFBundleName"
    let appName = Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
    return appName!
}

func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

// color
let tys_grayColor = hexString("#696969")
let tys_whiteColor = UIColor.white
let tys_blackColor = UIColor.black
let tys_backgroundColor = hexString("#FF333743")
let tys_disabledBackgroundColor = hexString("#FF9F9B9A")
let tys_disabledTextColor = hexString("#C7C7C7")
let tys_searchBackgroundColor = hexString("#FFF3F0F0")
let tys_titleColor = hexString("#FF777777")
let tys_lightColor = hexString("#BBBBBB")
let tys_lineColor = hexString("#DDDDDD")
let tys_middleDarkColor = hexString("#FF222222")
let tys_inputTintColor = hexString("#F65038")







