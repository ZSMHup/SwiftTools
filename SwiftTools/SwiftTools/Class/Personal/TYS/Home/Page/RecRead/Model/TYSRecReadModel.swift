//
//  TYSRecReadModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSRecReadModel: HandyJSON {
    var tj_user_id: String? // 推荐用户ID
    var res: String? // 来源 1.我的荐读或者系统推送荐读 3好友发布个人 4好友发布组 5好友推荐个人 6好友推荐组
    var tj_res: String? // 推荐来源 1.粉丝 2.密友 3.好友
    var like_count: String? // 点赞量
    var create_time: String? // 发布时间
    var group_name: String? // 分组名称
    var head_img: String? // 用户头像
    var browse_count: String? // 浏览量
    var type: String? // 类型 1短文 2图文 3连接 4附件
    var title: String? // 标题
    var org_group_name: String? // 机构名称
    var user_id: String? // 发布用户ID
    var name: String? // 用户名称
    var collection_count: String? // 收藏量
    var id: String? // 荐读ID
    var position: String? // 发布位置 1个人 2个人和分组
    var tj_user_name: String? // 推荐用户
    var msg_count: String? // 评论量
    var tj_head_img: String? // 推荐用户头像
    var user_groups: String? // 发布组 1,1,1 参照发布接口参数说明
    var gz_id: String? // 关注ID res!=1 有效 返回关注数据ID
    var org_group_path: String? // 组封面图片
    var org_group_ids: String? // 荐读发布组ID
    
}


