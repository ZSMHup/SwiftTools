//
//  TYSPersonalModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

class TYSPersonalModel: TYSRequestModel {
    var vip_end_time: String? // vip到期时间 格式YYYY-mm-dd
    var is_vip: String? // 是否vip 1是2不是
    var sex: String? // 性别 性别 0男 1女
    var head_img: String? // 头像地址
    var mobile: String? // 手机号码
    var wechat: String? // 微信号
    var auth_state: String? // 分析师认证状态 1未认证 2提交申请 3审核通过 4审核不通过 5取消认证
    var card_img: String? // 正面名片地址
    var assets: String? // 账户余额 0.00 格式
    var company_profile: String? // 公司名称
    var post: String? // 职位ID
    var post_name: String? // 职位名称
    var user_id: String? // 用户ID
    var org_id: String? // 机构ID
    var data_state: String? // 资料状态 1审核通过 2未完善 3待审核 4审核不通过
    var name: String? // 分析师名称
    var industry_name: String? // 行业名称 二级海外市场1,二级期货市场2,二级新三板1,二级市场
    var per_att_name: String? // 个人属性
    var personal_attribute: String? // 个人属性ID
    var email: String? // 电子邮件
    var username: String? // 登陆用户名
    var status: String? // 状态 0：禁用 1：正常
    var qua_cer: String? // 从业资格证编号
    var follow_count: String? // 关注总人数
    var fans_count: String? // 粉丝总人数
    var pre_exp: String? // 个人经历
    var gz_id: String? // 传入参数login_user_id不为空时 返回此字段 > 0 表示关注 值为关注数据ID
    var score: String? // 评分
    var type: String? // 用户类型 1分析师 2普通用户
    var activity: String? // 活跃度
    var effect: String? // 影响力
    var is_shield_hy_group: String? // 是否屏蔽好友 1不屏蔽 2屏蔽 空未关注 login_user_id不为空返回
    var is_shield_my_group: String? // 是否屏蔽密友 1不屏蔽 2屏蔽 空未关注 login_user_id不为空返回
    var is_shield_fs_group: String? // 是否屏蔽粉丝 1不屏蔽 2屏蔽 空未关注 login_user_id不为空返回
    var data_state_time: String? // V2资料审核通过时间
    var ly_count: String? // 路演参与次数
    var hy_count: String? // 会议参与次数
    // 用户身份
    var identityName: String {
        if data_state == "1" {
            return "认证用户"
        } else {
            if type == "0" {
                return "游客"
            }
            return "普通用户"
        }
    }
    
    // 用户认证状态
    var userAuthStatus: String {
        switch data_state {
        case "1"?:
            if auth_state == "2" {
                return "直播认证中"
            } else if auth_state == "3" {
                return "直播已认证"
            } else {
                return "已认证"
            }
        case "2"?, "4"?:
            return "未认证"
        case "3"?:
            return "认证中"
        default:
            return "未知状态"
        }
    }
    
    
}
