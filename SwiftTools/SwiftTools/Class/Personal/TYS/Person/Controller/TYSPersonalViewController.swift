//
//  TYSPersonalViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

@objc protocol TYSPersonalViewControllerDelegate {
    @objc func postValueToUpPage(str: String)
}

typealias postValueToUpPageBlock = (String) -> Void

class TYSPersonalViewController: BaseViewController {
    
    var postValue: String?
    weak var delegate: TYSPersonalViewControllerDelegate?
    var postValueToUpPage: postValueToUpPageBlock?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(postValue as Any)

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 30)
        button.setTitle("代理传值", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        view.addSubview(button)
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 100, y: 260, width: 100, height: 30)
        button1.setTitle("闭包传值", for: .normal)
        button1.backgroundColor = UIColor.red
        button1.addTarget(self, action: #selector(buttonClick1), for: .touchUpInside)
        view.addSubview(button1)
        
    }

    public func addPostValueToUpPageBlock(tempPostValueToUpPage: @escaping postValueToUpPageBlock) {
        postValueToUpPage = tempPostValueToUpPage
    }
    
    @objc private func buttonClick() {
        delegate?.postValueToUpPage(str: "代理传值到第一页")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func buttonClick1() {
        if postValueToUpPage != nil {
            postValueToUpPage!("闭包传值到上一页")
            navigationController?.popViewController(animated: true)
        }
    }

}
