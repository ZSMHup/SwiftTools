//
//  TYSLiveJoinLiveModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSLiveJoinLiveModel: HandyJSON {
    var number: String? // 直播房间号
    var t: String? // 加入直播类型 1主持人 2嘉宾 3报名用户
    var msg: String? // 返回信息
    var domain: String? // 域名
    var joinPwd: String? // 加入密码
    var back_id: String? // 回播ID
    var back_pwd: String? // 回播加入密码
    var recordStartTime: String? // 回播开始时间
    var recordEndTime: String? // 回播结束时间
}


