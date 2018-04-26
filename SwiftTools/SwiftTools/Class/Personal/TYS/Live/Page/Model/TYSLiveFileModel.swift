//
//  TYSLiveFileModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import HandyJSON

struct TYSLiveFileModel: HandyJSON {
    var live_id: String? // 直播ID
    var create_time: String? // 创建时间 2017-07-03 14:52:04
    var att_path: String? // 附件路径
    var id: String? // 附件ID
    var att_name: String? // 附件名称
    var type: String? // 类型 1附件 2连接
}
