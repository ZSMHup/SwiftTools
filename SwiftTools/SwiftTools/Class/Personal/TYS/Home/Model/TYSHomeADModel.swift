//
//  TYSHomeADModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import HandyJSON

struct TYSHomeADModel: HandyJSON {
    var link_type: String? // 跳转连接类型 1html跳转
    var img_path: String? // 图片地址
    var link_path: String? // 连接地址
    var id: String? // 数据ID
    var position: String? // 位置 HOME 首页
    var title: String? // 标题
}
