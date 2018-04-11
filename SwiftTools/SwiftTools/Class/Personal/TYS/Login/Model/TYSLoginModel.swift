//
//  TYSLoginModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

class TYSLoginModel: TYSRequestModel {
    var user_id: String? // 用户ID
    var access_token: String? // 接口凭证
    var org_id: String? // 1 固定值 投研社机构ID
    var mobile_state: String? // 手机绑定状态 1绑定 2未绑定
    var data_state: String? // 资料状态 1审核通过 2未完善 3待审核 4审核不通过
    var auth_state: String? // 分析师认证状态 1未认证 2提交申请 3审核通过 4审核不通过 5取消认证
    var dis_state: String? // 直播免责阅读状态 1已阅读 2未阅读
    var type: String? // 用户类型 0游客 1分析师 2普通用户
    var register_state: String? // 注册免责阅读状态 1已阅读 2未阅读
    var play_state: String? // 播放免责阅读状态 1已阅读 2未阅读
    var org_name: String? // 机构名称
    var data_state_time: String? // V2资料审核通过时间
    var ly_count: String? // 路演参与次数
    var hy_count: String? // 会议参与次数
}

class TYSLoginGetCaptcha: TYSRequestModel {
    var vstatus: String? // 验证码
}
