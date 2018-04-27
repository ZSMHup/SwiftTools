//
//  TYSPersonalModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import HandyJSON
import SQLite

struct TYSPersonalModel: HandyJSON {
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
    
    private let vip_end_time_column = Expression<String>("vip_end_time")
    private let is_vip_column = Expression<String>("is_vip")
    private let sex_column = Expression<String>("sex")
    private let head_img_column = Expression<String>("head_img")
    private let mobile_column = Expression<String>("mobile")
    private let wechat_column = Expression<String>("wechat")
    private let auth_state_column = Expression<String>("auth_state")
    private let card_img_column = Expression<String>("card_img")
    private let assets_column = Expression<String>("assets")
    private let company_profile_column = Expression<String>("company_profile")
    private let post_column = Expression<String>("post")
    private let post_name_column = Expression<String>("post_name")
    private let org_id_column = Expression<String>("org_id")
    private let user_id_column = Expression<String>("user_id")
    private let data_state_column = Expression<String>("data_state")
    private let name_column = Expression<String>("name")
    private let industry_name_column = Expression<String>("industry_name")
    private let per_att_name_column = Expression<String>("per_att_name")
    private let personal_attribute_column = Expression<String>("personal_attribute")
    private let email_column = Expression<String>("email")
    private let username_column = Expression<String>("username")
    private let status_column = Expression<String>("status")
    private let qua_cer_column = Expression<String>("qua_cer")
    private let follow_count_column = Expression<String>("follow_count")
    private let fans_count_column = Expression<String>("fans_count")
    private let pre_exp_column = Expression<String>("pre_exp")
    private let gz_id_column = Expression<String>("gz_id")
    private let score_column = Expression<String>("score")
    private let type_column = Expression<String>("type")
    private let activity_column = Expression<String>("activity")
    private let effect_column = Expression<String>("effect")
    private let is_shield_hy_group_column = Expression<String>("is_shield_hy_group")
    private let is_shield_my_group_column = Expression<String>("is_shield_my_group")
    private let is_shield_fs_group_column = Expression<String>("is_shield_fs_group")
    private let data_state_time_column = Expression<String>("data_state_time")
    private let ly_count_column = Expression<String>("ly_count")
    private let hy_count_column = Expression<String>("hy_count")
  
    static var manager = TYSPersonalModel()
    private var table: Table?
    
    mutating func getPersonalTable() -> Table {
        if table == nil {
            table = Table("personal")
            try! getDB().run(
                table!.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                    builder.column(vip_end_time_column)
                    builder.column(is_vip_column)
                    builder.column(sex_column)
                    builder.column(head_img_column)
                    builder.column(mobile_column)
                    builder.column(wechat_column)
                    builder.column(auth_state_column)
                    builder.column(card_img_column)
                    builder.column(assets_column)
                    builder.column(company_profile_column)
                    builder.column(post_column)
                    builder.column(post_name_column)
                    builder.column(user_id_column)
                    builder.column(org_id_column)
                    builder.column(data_state_column)
                    builder.column(name_column)
                    builder.column(industry_name_column)
                    builder.column(per_att_name_column)
                    builder.column(personal_attribute_column)
                    builder.column(email_column)
                    builder.column(username_column)
                    builder.column(status_column)
                    builder.column(qua_cer_column)
                    builder.column(follow_count_column)
                    builder.column(fans_count_column)
                    builder.column(pre_exp_column)
                    builder.column(gz_id_column)
                    builder.column(score_column)
                    builder.column(type_column)
                    builder.column(activity_column)
                    builder.column(effect_column)
                    builder.column(is_shield_hy_group_column)
                    builder.column(is_shield_my_group_column)
                    builder.column(is_shield_fs_group_column)
                    builder.column(data_state_time_column)
                    builder.column(ly_count_column)
                    builder.column(hy_count_column)
                })
            )
        }
        return table!
    }
    
    //增
    mutating func insertPersonal(personalModel: TYSPersonalModel) {
        
        let insert = getPersonalTable().insert(
            vip_end_time_column <- personalModel.vip_end_time ?? "",
            is_vip_column <- personalModel.is_vip ?? "",
            sex_column <- personalModel.sex ?? "",
            head_img_column <- personalModel.head_img ?? "",
            mobile_column <- personalModel.mobile ?? "",
            wechat_column <- personalModel.wechat ?? "",
            auth_state_column <- personalModel.auth_state ?? "",
            card_img_column <- personalModel.card_img ?? "",
            assets_column <- personalModel.assets ?? "",
            company_profile_column <- personalModel.company_profile ?? "",
            post_column <- personalModel.post ?? "",
            post_name_column <- personalModel.post_name ?? "",
            user_id_column <- personalModel.user_id ?? "",
            org_id_column <- personalModel.org_id ?? "",
            data_state_column <- personalModel.data_state ?? "",
            name_column <- personalModel.name ?? "",
            industry_name_column <- personalModel.industry_name ?? "",
            per_att_name_column <- personalModel.per_att_name ?? "",
            personal_attribute_column <- personalModel.personal_attribute ?? "",
            email_column <- personalModel.email ?? "",
            username_column <- personalModel.username ?? "",
            status_column <- personalModel.status ?? "",
            qua_cer_column <- personalModel.qua_cer ?? "",
            follow_count_column <- personalModel.follow_count ?? "",
            fans_count_column <- personalModel.fans_count ?? "",
            pre_exp_column <- personalModel.pre_exp ?? "",
            gz_id_column <- personalModel.gz_id ?? "",
            score_column <- personalModel.score ?? "",
            type_column <- personalModel.type ?? "",
            activity_column <- personalModel.activity ?? "",
            effect_column <- personalModel.effect ?? "",
            is_shield_hy_group_column <- personalModel.is_shield_hy_group ?? "",
            is_shield_my_group_column <- personalModel.is_shield_my_group ?? "",
            is_shield_fs_group_column <- personalModel.is_shield_fs_group ?? "",
            data_state_time_column <- personalModel.data_state_time ?? "",
            ly_count_column <- personalModel.ly_count ?? "",
            hy_count_column <- personalModel.hy_count ?? ""
        )
        
        do {
            let rowId = try getDB().run(insert)
            printLog("插入成功：\(String(describing: rowId))")
        } catch {
            printLog("insertError:\(error)")
        }
    }
    
    //改
    mutating func update(personalModel: TYSPersonalModel) {
        let update = getPersonalTable().update(
            vip_end_time_column <- personalModel.vip_end_time ?? "",
            is_vip_column <- personalModel.is_vip ?? "",
            sex_column <- personalModel.sex ?? "",
            head_img_column <- personalModel.head_img ?? "",
            mobile_column <- personalModel.mobile ?? "",
            wechat_column <- personalModel.wechat ?? "",
            auth_state_column <- personalModel.auth_state ?? "",
            card_img_column <- personalModel.card_img ?? "",
            assets_column <- personalModel.assets ?? "",
            company_profile_column <- personalModel.company_profile ?? "",
            post_column <- personalModel.post ?? "",
            post_name_column <- personalModel.post_name ?? "",
            user_id_column <- personalModel.user_id ?? "",
            org_id_column <- personalModel.org_id ?? "",
            data_state_column <- personalModel.data_state ?? "",
            name_column <- personalModel.name ?? "",
            industry_name_column <- personalModel.industry_name ?? "",
            per_att_name_column <- personalModel.per_att_name ?? "",
            personal_attribute_column <- personalModel.personal_attribute ?? "",
            email_column <- personalModel.email ?? "",
            username_column <- personalModel.username ?? "",
            status_column <- personalModel.status ?? "",
            qua_cer_column <- personalModel.qua_cer ?? "",
            follow_count_column <- personalModel.follow_count ?? "",
            fans_count_column <- personalModel.fans_count ?? "",
            pre_exp_column <- personalModel.pre_exp ?? "",
            gz_id_column <- personalModel.gz_id ?? "",
            score_column <- personalModel.score ?? "",
            type_column <- personalModel.type ?? "",
            activity_column <- personalModel.activity ?? "",
            effect_column <- personalModel.effect ?? "",
            is_shield_hy_group_column <- personalModel.is_shield_hy_group ?? "",
            is_shield_my_group_column <- personalModel.is_shield_my_group ?? "",
            is_shield_fs_group_column <- personalModel.is_shield_fs_group ?? "",
            data_state_time_column <- personalModel.data_state_time ?? "",
            ly_count_column <- personalModel.ly_count ?? "",
            hy_count_column <- personalModel.hy_count ?? ""
        )
        
        do {
            let count = try getDB().run(update)
            printLog("修改的结果为：\(count)")
        } catch {
            printLog("updateError\(error)")
        }
    }
    
    mutating func insertOrUpdate(personalModel: TYSPersonalModel) {
        let model = readPersonalData()
        if model.user_id == nil {
            insertPersonal(personalModel: personalModel)
        } else {
            update(personalModel: personalModel)
        }
    }
    
    mutating func readPersonalData() -> TYSPersonalModel {
        var personalModel = TYSPersonalModel()
        for model in try! getDB().prepare(getPersonalTable()) {
            personalModel.vip_end_time = model[vip_end_time_column]
            personalModel.is_vip = model[is_vip_column]
            personalModel.sex = model[sex_column]
            personalModel.head_img = model[head_img_column]
            personalModel.mobile = model[mobile_column]
            personalModel.wechat = model[wechat_column]
            personalModel.auth_state = model[auth_state_column]
            personalModel.card_img = model[card_img_column]
            personalModel.assets = model[assets_column]
            personalModel.company_profile = model[company_profile_column]
            personalModel.post = model[post_column]
            personalModel.post_name = model[post_name_column]
            personalModel.user_id = model[user_id_column]
            personalModel.org_id = model[org_id_column]
            personalModel.data_state = model[data_state_column]
            personalModel.name = model[name_column]
            personalModel.industry_name = model[industry_name_column]
            personalModel.per_att_name = model[per_att_name_column]
            personalModel.personal_attribute = model[personal_attribute_column]
            personalModel.email = model[email_column]
            personalModel.username = model[username_column]
            personalModel.status = model[status_column]
            personalModel.qua_cer = model[qua_cer_column]
            personalModel.follow_count = model[follow_count_column]
            personalModel.fans_count = model[fans_count_column]
            personalModel.pre_exp = model[pre_exp_column]
            personalModel.gz_id = model[gz_id_column]
            personalModel.score = model[score_column]
            personalModel.type = model[type_column]
            personalModel.activity = model[activity_column]
            personalModel.effect = model[effect_column]
            personalModel.is_shield_hy_group = model[is_shield_hy_group_column]
            personalModel.is_shield_my_group = model[is_shield_my_group_column]
            personalModel.is_shield_fs_group = model[is_shield_fs_group_column]
            personalModel.data_state_time = model[data_state_time_column]
            personalModel.ly_count = model[ly_count_column]
            personalModel.hy_count = model[hy_count_column]
        }
        return personalModel
    }
    
    //删除表
    mutating func deletePersonalTable() {
        
        let query = getPersonalTable()
        
        do {
            let count = try getDB().run(query.drop())
            table = nil
            printLog("deleteSuccess: \(count)")
        } catch {
            printLog("deleteError: \(error)")
        }
    }
    
    // 用户身份
    var identityName: String {
        let model = TYSPersonalModel.manager.readPersonalData()
        if model.data_state == "1" {
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
        let model = TYSPersonalModel.manager.readPersonalData()
        switch model.data_state {
        case "1"?:
            if model.auth_state == "2" {
                return "直播认证中"
            } else if model.auth_state == "3" {
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
    
    var userName: String {
        let model = TYSPersonalModel.manager.readPersonalData()
        return model.name ?? model.mobile ?? "暂无数据"
    }
    
    var activityFormat: String {
        let model = TYSPersonalModel.manager.readPersonalData()
        var act = "0"
        let acti:Float = Float(model.activity ?? "0") ?? Float(0)
        
        if acti >= Float(10000) {
            act = String(format: "%.1lf 万", Float(acti / 10000))
        } else {
            act = model.activity ?? "0"
        }
        return act
    }
    
    var fansCountFormat: String {
        let model = TYSPersonalModel.manager.readPersonalData()
        var fc = "0"
        let fcf:Float = Float(model.fans_count ?? "0") ?? Float(0)
        
        if fcf >= Float(10000) {
            fc = String(format: "%.1lf 万", Float(fcf / 10000))
        } else {
            fc = model.fans_count ?? "0"
        }
        return fc
    }
    
    var followCountFormat: String {
        let model = TYSPersonalModel.manager.readPersonalData()
        var followC = "0"
        let followCF:Float = Float(model.follow_count ?? "0") ?? Float(0)
        
        if followCF >= Float(10000) {
            followC = String(format: "%.1lf 万", Float(followCF / 10000))
        } else {
            followC = model.fans_count ?? "0"
        }
        return followC
    }
    

}






