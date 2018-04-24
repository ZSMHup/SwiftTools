//
//  TYSLoginModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/9.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import HandyJSON
import SQLite

class TYSLoginModel: HandyJSON {

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
    
    private let user_id_column = Expression<String>("user_id")
    private let access_token_column = Expression<String>("access_token")
    private let org_id_column = Expression<String>("org_id")
    private let mobile_state_column = Expression<String>("mobile_state")
    private let data_state_column = Expression<String>("data_state")
    private let auth_state_column = Expression<String>("auth_state")
    private let dis_state_column = Expression<String>("dis_state")
    private let type_column = Expression<String>("type")
    private let register_state_column = Expression<String>("register_state")
    private let play_state_column = Expression<String>("play_state")
    private let org_name_column = Expression<String>("org_name")
    private let data_state_time_column = Expression<String>("data_state_time")
    private let ly_count_column = Expression<String>("ly_count")
    private let hy_count_column = Expression<String>("hy_count")

    
    static let manager = TYSLoginModel()
    private var db: Connection?
    private var table: Table?
    
    func getTable() -> Table {
        if table == nil {
            table = Table("records")
            try! getDB().run(
                table!.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                    builder.column(user_id_column)
                    builder.column(access_token_column)
                    builder.column(org_id_column)
                    builder.column(mobile_state_column)
                    builder.column(data_state_column)
                    builder.column(auth_state_column)
                    builder.column(dis_state_column)
                    builder.column(type_column)
                    builder.column(register_state_column)
                    builder.column(play_state_column)
                    builder.column(org_name_column)
                    builder.column(data_state_time_column)
                    builder.column(ly_count_column)
                    builder.column(hy_count_column)
                })
            )
        }
        return table!
    }
    
    //增
    func insert(loginModel: TYSLoginModel) {
        let insert = getTable().insert(
            user_id_column <- loginModel.user_id ?? "",
            access_token_column <- loginModel.access_token ?? "",
            org_id_column <- loginModel.org_id ?? "",
            mobile_state_column <- loginModel.mobile_state ?? "",
            data_state_column <- loginModel.data_state ?? "",
            auth_state_column <- loginModel.auth_state ?? "",
            dis_state_column <- loginModel.dis_state ?? "",
            type_column <- loginModel.type ?? "",
            register_state_column <- loginModel.register_state ?? "",
            play_state_column <- loginModel.play_state ?? "",
            org_name_column <- loginModel.org_name ?? "",
            data_state_time_column <- loginModel.data_state_time ?? "",
            ly_count_column <- loginModel.ly_count ?? "",
            hy_count_column <- loginModel.hy_count ?? ""
            )
        if let rowId = try? getDB().run(insert) {
            printLog("插入成功：\(rowId)")
        } else {
            printLog("插入失败")
        }
    }

    //删除表
    func deleteLoginTable() {
        
        let query = getTable()
        
        do {
            let count = try getDB().run(query.drop())
            printLog("deleteSuccess: \(count)")
        } catch {
            printLog("deleteError: \(error)")
        }
    }
    
    //改
    func update(loginModel: TYSLoginModel) {
        let update = getTable()
        if let count = try? getDB().run(update.update(
            user_id_column <- loginModel.user_id!,
            access_token_column <- loginModel.access_token!,
            org_id_column <- loginModel.org_id!,
            mobile_state_column <- loginModel.mobile_state!,
            data_state_column <- loginModel.data_state!,
            auth_state_column <- loginModel.auth_state!,
            dis_state_column <- loginModel.dis_state!,
            type_column <- loginModel.type!,
            register_state_column <- loginModel.register_state!,
            play_state_column <- loginModel.play_state!,
            org_name_column <- loginModel.org_name!,
            data_state_time_column <- loginModel.data_state_time!,
            ly_count_column <- loginModel.ly_count!,
            hy_count_column <- loginModel.hy_count!
            )) {
            printLog("修改的结果为：\(count == 1)")
        } else {
            printLog("修改失败")
        }
    }
    
    func loginInsertOrupdate(loginModel: TYSLoginModel) {
        let model = readData()
        if model.access_token == nil {
            insert(loginModel: loginModel)
        } else {
            update(loginModel: loginModel)
        }
    }
    
    func readData() -> TYSLoginModel {
        let loginModel = TYSLoginModel()
        for model in try! getDB().prepare(getTable()) {
            loginModel.user_id = model[user_id_column]
            loginModel.access_token = model[access_token_column]
            loginModel.org_id = model[org_id_column]
            loginModel.mobile_state = model[mobile_state_column]
            loginModel.data_state = model[data_state_column]
            loginModel.auth_state = model[auth_state_column]
            loginModel.dis_state = model[dis_state_column]
            loginModel.type = model[type_column]
            loginModel.register_state = model[register_state_column]
            loginModel.play_state = model[play_state_column]
            loginModel.org_name = model[org_name_column]
            loginModel.data_state_time = model[data_state_time_column]
            loginModel.ly_count = model[ly_count_column]
            loginModel.hy_count = model[hy_count_column]
        }
        return loginModel
    }
    
    required init() {
        
    } 
}

struct TYSLoginGetCaptcha: HandyJSON {
    var vstatus: String? // 验证码
}
