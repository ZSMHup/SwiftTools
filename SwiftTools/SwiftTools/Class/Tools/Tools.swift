//
//  Tools.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/21.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import Foundation
import Security

typealias itemClickBlock = (Int) -> Void

/// 手机号码校验
///
/// - Parameter num: 输入的号码
/// - Returns: 返回的是否为手机号码
func isTelNumber(num: String) -> Bool {
    
    let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
    let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
    let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
    let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true)) {
        return true
    } else {
        return false
    }
}

/* 递归找最上面的viewController */
func getCurrentController() -> UIViewController? {

        return topViewControllerWithRootViewController(viewController: getCurrentWindow()?.rootViewController)
}

func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {

    if viewController == nil {
        return nil
    }

    if viewController?.presentedViewController != nil {
        
        return topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
    }
    else if viewController?.isKind(of: UITabBarController.self) == true {
        
        return topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
    }
    else if viewController?.isKind(of: UINavigationController.self) == true {
        
        return topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
    }
    else {
        return viewController
    }
}

// 找到当前显示的window
func getCurrentWindow() -> UIWindow? {
    // 找到当前显示的UIWindow
    var window: UIWindow? = UIApplication.shared.keyWindow
    /**
     window有一个属性：windowLevel
     当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
     */
    if window?.windowLevel != UIWindowLevelNormal {
        
        for tempWindow in UIApplication.shared.windows {
            
            if tempWindow.windowLevel == UIWindowLevelNormal {
                
                window = tempWindow
                break
            }
        }
    }
    return window
}

// 计算文字高度或者宽度

func ay_getWidth(string: String, fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize)
    let rect = NSString(string: string).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
    return ceil(rect.width)
}

func ay_getHeight(string: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize)
    let rect = NSString(string: string).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
    return ceil(rect.height)
}

func ay_getHeight(string: String, fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize)
    let rect = NSString(string: string).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
    return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
}

/// 日期处理
///
/// - Parameter date: 日期（string）
/// - Returns: 返回想要的日期格式
func formatDate(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let formatDate = dateFormatter.date(from: date)
    
    let calendar = Calendar.current
    _ = calendar.component(.era, from: formatDate!)
    let year = calendar.component(.year, from: formatDate!)
    let month = calendar.component(.month, from: formatDate!)
    let day = calendar.component(.day, from: formatDate!)
    let hour = calendar.component(.hour, from: formatDate!)
    let minute = calendar.component(.minute, from: formatDate!)
    _ = calendar.component(.second, from: formatDate!)
    return String(format: "%.2zd/%.2zd/%.2zd %.2zd:%.2zd", year, month, day, hour, minute)
}

