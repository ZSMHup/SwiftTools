//
//  TYSRecReadDetailModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSRecReadDetailModel: HandyJSON {
    var like_count: String? // 点赞量
    var gz_id: String? // 是否关注文章发布人 >0 表示已关注
    var create_time: String? // 发布时间
    var attr_name: String? // 附件名称
    var head_img: String? // 用户头像
    var sc_id: String? // 是否收藏ID >0表示已收藏
    var type: String? // 类型 1短文 2图文 3连接 4附件
    var title: String? // 标题
    var org_group_ids: String? // 荐读发布组ID
    var org_group_name: String? // 发布组名称
    var path: String? // 图片，附件，第三方地址
    var contents: String? // 内容
    var name: String? // 用户名称
    var collection_count: String? // 收藏量
    var browse_count: String? // 浏览量
    var id: String? // 荐读ID
    var state: String? // 发布状态 1待审核 2发布 3下架
    var position: String? // 发布位置 1个人 2个人和分组
    var msg_count: String? // 评论量
    var dz_id: String? // 点赞ID >0表示已点赞
    var user_id: String? // 用户ID
}
