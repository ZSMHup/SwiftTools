//
//  TYSRecReadAboutMeModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSRecReadAboutMeModel: HandyJSON {
    var pk_id: String? // 荐读ID
    var send_user_id: String? // 发送人ID
    var create_time: String? // 消息时间
    var receive_user_id: String? // 接收人ID
    var id: String? // 数据ID
    var state: String? // 态状 0未读 1已读 9删除
    var title: String? // 标题
    var type: String? // 类型 2.荐读发布好友消息 3.荐读发布组消息 4.好友推送荐消息 5.评论别人文章 6.回复别人文章
    var content: String? // 内容
}
