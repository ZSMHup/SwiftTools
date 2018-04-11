//
//  TYSLiveCommonModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import HandyJSON

struct TYSLiveCommonModel: HandyJSON {
    var industry_name: String? // 行业名称
    var live_img_path: String? // 行业名称
    var is_melive: String? // 是否我的直播 1是 2不是
    var is_signup: String? // 是否报名 1报名 2未报名
    var entry_count: String? // 报名人数
    var post_name: String? // 职位名称
    var subject: String? // 直播主题
    var is_free: String? // 是否收费 1收费 2不收费
    var name: String? // 分析师名称
    var startTime: String? // 开始时间
    var id: String? // 直播ID
    var state: String? // 状态 1未开始 2开始 3结束
    var maxAttendees: String? // 最大报名人数
    var p_post_name: String? // 个人信息职位信息
    var company_profile: String? // 公司名称
    var org_name: String? // 券商名称
    var score: String? // 评分
    var up_down: String? // 直播上下架状态 1已上架 2已下架
    var easemob_group_id: String? // 环信组ID
    var free_money: String? // 收费金额
    var dialing_number: String? // 拨号号码 多个,号分割
    var room_number: String? // 房间号码
    var room_pwd: String? // 房间密码
}

