//
//  TYSInterestedPeopleModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

class TYSInterestedPeopleModel: TYSRequestModel {
    var industry_name: String? // 行业名称 二级海外市场1,二级期货市场2,二级新三板1,二级市场
    var p_post_name: String? // 用户职位名称
    var company_profile: String? // 公司简介
    var frist_pinyin: String? // 姓名首字母
    var post_name: String? // 机构职位名称
    var head_img: String? // 头像
    var name: String? // 名称
    var mobile: String? // 手机号
    var type: String? // 类型 1分析师 2普通用户
    var org_name: String? // 券商名称
    var user_id: String? // 用户ID
    var gz_id: String? // 关注ID >0 返回关注ID
    
}
