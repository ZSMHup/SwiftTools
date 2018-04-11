//
//  TYSLiveDetailModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/11.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSLiveDetailModel: HandyJSON {
    var speakerInfo: String? // 嘉宾描述
    var industry_name: String? // 行业名称
    var entry_count: String? // 报名人数
    var subject: String? // 直播主题
    var description: String? // 直播描述
    var is_melive: String? // 是否我的直播 1是 2不是
    var is_signup: String? // 是否报名 1报名 2未报名
    var free_money: String? // 收费金额
    var post_name: String? // 职位名称
    var is_free: String? // 是否收费 1收费 2不收费
    var name: String? // 分析师名称
    var startTime: String? // 开始时间
    var id: String? // 直播ID
    var state: String? // 状态 1未开始 2开始 3结束
    var maxAttendees: String? // 最大报名人数
    var host_id: String? // 主持人ID
    var guest_id: String? // 嘉宾ID
    var head_img: String? // 嘉宾头像
    var gz_id: String? // 是否关注 >0 表示已关注 值为关注数据ID
    var sc_id: String? // 是否收藏 >0 表示已收藏 值为收藏数据ID
    var score: String? // 评分
    var pj_id: String? // 是否评价 >0 表示已评价 值为评价数据ID
    var notes: String? // notes
    var dialing_number: String? // 拨号号码 多个,号分割
    var room_number: String? // 房间号码
    var room_pwd: String? // 房间密码
    var type: String? // 类型 2路演 3会议
    var live_img_path: String? // 行业名称
    var easemob_group_id: String? // 环信组ID
    var host_org_group_ids: String? // V2参数 主持人所在分组ID
    var host_org_group_name: String? // V2参数 主持人所在分组名称
    var guest_org_group_ids: String? // V2参数 嘉宾所在分组ID
    var guest_org_group_name: String? // V2参数 嘉宾所在分组名称
    var host_name: String? // V2参数 主持人姓名
    var host_head_img: String? // V2参数 主持人头像
    var host_gz_id: String? // V2 关注主持人ID
    var group_gz_id: String? // V2 关注嘉宾组ID
    var host_group_gz_id: String? // V2 关注主持人组ID
}
