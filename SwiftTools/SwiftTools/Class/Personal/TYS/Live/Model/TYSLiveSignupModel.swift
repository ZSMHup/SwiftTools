//
//  TYSLiveSignupModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSLiveSignupModel: HandyJSON {

    var msg: String? // 返回信息
    var code: String? // 返回编码 -11本场路演（电话会议）仅对认证用户开放请登陆/注册/认证后，再参与 -10您的试听机会已经用完请登陆/注册/认证后，再参与本场路演（电话会议）") -9用户不在白名单中 -8该场路演嘉宾有限制 0报名失败 1报名人数已满 5已报名本场直播 8预报名成功，待支付 9报名成功
    var id: String? // 报名数据ID
    var pay_money: String? // code =8 返回 支付金额
    var assets: String? // code =8 返回 账户余额
    var home_path: String? // code =-9 返回券商跳转链接

}
