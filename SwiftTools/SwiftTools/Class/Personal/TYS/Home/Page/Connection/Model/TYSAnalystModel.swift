//
//  TYSAnalystModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSAnalystModel: HandyJSON {
    var org_name: String? // 机构名称
    var post: String? // 职位ID
    var user_id: String? // 用户Id
    var frist_pinyin: String? // 用户姓名首字母
    var post_name: String? // 职位名称
    var head_img: String? // 头像图片
    var name: String? // 用户名称
    var auth_org_id: String? // 机构ID
    var industry_name: String? // 行业名称 参数ind_id传入时返回 二级新三板1。不传入返回 二级新三板1,二级新三板2,二级期货市场1
    var gz_id: String? // 关注ID >0 表示关注
}
