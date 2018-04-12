//
//  TYSLiveQuestionModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSLiveQuestionModel: HandyJSON {
    var unme_or_all_question: [TYSQuestionModel]? // 不包含当前用户提问或者所有提问集合
    var me_question: [TYSQuestionModel]? // 查询我的提问集合
}

struct TYSQuestionModel: HandyJSON {
    var live_id: String? // 直播ID
    var create_time: String? // 创建时间 格式 2017-07-03 14:02:43
    var user_id: String? // 提问用户ID
    var head_img: String? // 用户头像
    var name: String? // 用户名称
    var questions: String? // 问题
    var id: String? // 提问数据ID
    var is_anonymous: String? // 是否匿名 1匿名 2不匿名
}
