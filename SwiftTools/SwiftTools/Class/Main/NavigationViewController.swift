//
//  NavigationViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let backBtn = UIButton()
            backBtn.setImage(UIImage(named:"default_nav_back"), for: .normal)
            backBtn.setImage(UIImage(named:"default_nav_back"), for: .highlighted)
            backBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 70)
            backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        } else {
            return true
        }
    }
    
    private func setup() {
        /*
        interactivePopGestureRecognizer?.delegate = self

        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.setBackgroundImage(imageWithColor(color: UIColor.white), for: .default)
        let textAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black,
                              NSAttributedStringKey.font : UIFont.systemFont(ofSize: 22.0)]
        navigationBarAppearance.titleTextAttributes = textAttributes
        navigationBarAppearance.tintColor = UIColor.black
         */
        setNavBarAppearence()
    }
    
    func setNavBarAppearence()
    {
        // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.white
        // 设置导航栏标题默认颜色
        WRNavigationBar.defaultNavBarTitleColor = .black
    }

    private func imageWithColor(color: UIColor) -> UIImage {
        return imageWithColor(color: color, bounds: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    private func imageWithColor(color: UIColor, bounds: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(bounds)
        let outImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return outImg!
    }
    
    @objc private func backBtnClick() {
        self.popViewController(animated: true)
    }
    
}
