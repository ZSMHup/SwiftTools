//
//  TYSHomeLiveModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

class TYSHomeLiveModel: TYSRequestModel {
    var home_hot_live = [TYSLiveCommonModel]() // 推荐热门数据集合
    var home_tj_live = [TYSLiveCommonModel]() // 首页推荐数据集合
    var home_theme = [HomeTheme]() // 主题列表数据集合
    var home_ind = [HomeInd]() // 一级分类数据集合
}

class HomeTheme: TYSRequestModel {
    var img_path: String? // 主题图片
    var org_id: String? // 机构ID
    var theme_name: String? // 主题名称
    var id: String? // 主题ID
    var description: String? // 描述
    var live_count: String? // 直播数量
    var meeting_count: String? // 会议数量
    var easemob_group_id: String? // 环信组ID
}

class HomeInd: TYSRequestModel {
    var name: String? // 分类名称
    var id: String? // 分类id
}
