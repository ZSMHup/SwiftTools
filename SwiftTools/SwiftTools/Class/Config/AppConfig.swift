//
//  AppConfig.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/10.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

// 网易云盾验证码captchaId
let kNetEaseCaptchaId = "e824e40907644c15b93b0ce1d677ff57"

/// 登录model的key
let kLoginModelKey = "loginModel"
let loginModel: TYSLoginModel = UserDefaults.standard.getCustomObject(forKey: kLoginModelKey) as? TYSLoginModel ?? TYSLoginModel()
