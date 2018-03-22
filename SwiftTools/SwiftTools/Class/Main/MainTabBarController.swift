//
//  MainTabBarController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = HomeViewController()
        let v2 = HomeViewController()
        let v3 = HomeViewController()
        let v4 = HomeViewController()
        let v5 = TYSLoginViewController()
        
        v1.navigationItem.title = "Home"
        v2.navigationItem.title = "Find"
        v3.navigationItem.title = "Photo"
        v4.navigationItem.title = "Favor"
//        v5.navigationItem.title = "Me"
        
        let nav1 = NavigationViewController(rootViewController: v1)
        nav1.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"), tag: 0)
        
        let nav2 = NavigationViewController(rootViewController: v2)
        nav2.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"), tag: 1)
        
        let nav3 = NavigationViewController(rootViewController: v3)
        nav3.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"), tag: 2)
        
        let nav4 = NavigationViewController(rootViewController: v4)
        nav4.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"), tag: 3)
        
        let nav5 = NavigationViewController(rootViewController: v5)
        nav5.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"), tag: 4)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]

    }
}
