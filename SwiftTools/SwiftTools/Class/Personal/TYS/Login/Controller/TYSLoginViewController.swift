//
//  TYSLoginViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSLoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
//    }
//    
    private func setupUI () {
        let skipBtn = UIButton() //跳过
        skipBtn.setTitle("跳过", for: .normal)
        skipBtn.setTitleColor(tys_grayColor, for: .normal)
        skipBtn.titleLabel?.font = AdaptFont(fontSize: 16)
        skipBtn.addTarget(self, action: #selector(skipBtnClick), for: .touchUpInside)
        view.addSubview(skipBtn)
        skipBtn.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -22))
            make.top.equalTo(view.snp.top).offset(AdaptH(h: 31))
            make.size.equalTo(CGSize(width: AdaptW(w: 36), height: AdaptH(h: 22)))
        }
        
        let logImg = UIImageView() //log
        logImg.image = UIImage(named: "default_logo")
        view.addSubview(logImg)
        logImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(AdaptH(h: 181))
            make.size.equalTo(CGSize(width: AdaptW(w: 76), height: AdaptH(h: 76)))
        }
        
        let wechatLoginBtn = UIButton() // 微信登录
        wechatLoginBtn.setTitle("微信快捷登录", for: .normal)
        wechatLoginBtn.setTitleColor(tys_grayColor, for: .normal)
        wechatLoginBtn.titleLabel?.font = AdaptFont(fontSize: 16)
        wechatLoginBtn.backgroundColor = tys_whiteColor
        wechatLoginBtn.layer.borderWidth = 1
        wechatLoginBtn.layer.borderColor = hexString("#DDDDDD").cgColor
        wechatLoginBtn.addTarget(self, action: #selector(wechatBtnClick), for: .touchUpInside)
        view.addSubview(wechatLoginBtn)
        wechatLoginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(AdaptH(h: -66))
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.height.equalTo(AdaptH(h: 50))
        }
        
        let phoneLoginBtn = UIButton() // 手机验证码登录
        phoneLoginBtn.setTitle("手机验证码登录", for: .normal)
        phoneLoginBtn.setTitleColor(tys_whiteColor, for: .normal)
        phoneLoginBtn.titleLabel?.font = AdaptFont(fontSize: 16)
        phoneLoginBtn.backgroundColor = tys_backgroundColor
        phoneLoginBtn.addTarget(self, action: #selector(phoneLoginBtnClick), for: .touchUpInside)
        view.addSubview(phoneLoginBtn)
        phoneLoginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(wechatLoginBtn.snp.top).offset(AdaptH(h: -19))
            make.left.equalTo(wechatLoginBtn.snp.left)
            make.height.equalTo(AdaptH(h: 50))
        }
    }
}

// MARK: event response
extension TYSLoginViewController {
    
    @objc private func skipBtnClick() {
        let homeVc = TYSHomeViewController()
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    @objc private func wechatBtnClick() {
        let homeVc = TYSHomeViewController()
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    @objc private func phoneLoginBtnClick() {
        let homeVc = TYSMobileLoginViewController()
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
}
