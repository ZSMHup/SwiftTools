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

class TYSLoginModel: NSObject, NSCoding, HandyJSON {
    
    struct PropertyKey {
        static let user_idKey = "user_id"
        static let access_tokenKey = "access_token"
        static let org_idKey = "org_id"
        static let mobile_stateKey = "mobile_state"
        static let data_stateKey = "data_state"
        static let auth_stateKey = "auth_state"
        static let dis_stateKey = "dis_state"
        static let typeKey = "type"
        static let register_stateKey = "register_state"
        static let play_stateKey = "play_state"
        static let org_nameKey = "org_name"
        static let data_state_timeKey = "data_state_time"
        static let ly_countKey = "ly_count"
        static let hy_countKey = "hy_count"
    }
    
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
    
    private var db: Connection!
    private let loginModel = Table("loginModel")
    private let id = Expression<String>("access_token")
    private let accessToken = Expression<String>("access_token")
    private let userId = Expression<String>("user_id")
    private let mobileState = Expression<String>("mobile_state")
    
    required override init() {
        super.init()
        createdsqlite3()
    }
    
    private func createdsqlite3(filePath: String = "/Documents")  {
        
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        do {
            db = try Connection(sqlFilePath)
            try db.run(loginModel.create { t in
                t.column(id, primaryKey: true)
                t.column(accessToken)
                t.column(userId)
                t.column(mobileState)
            })
        } catch {
            print(error)
        }
    }
    
    //插入数据
    func insertData(_userId: String, _mobileState: String, _accessToken: String){
        do {
            let insert = loginModel.insert(userId <- _userId, mobileState <- _mobileState, accessToken <- _accessToken)
            try db.run(insert)
        } catch {
            print(error)
        }
    }
    
    //读取数据
    func readData() -> [(id: String, userId: String, mobileState: String, accessToken: String)] {
        var userData = (id: "", userId: "", mobileState: "", accessToken: "")
        var userDataArr = [userData]
        for user in try! db.prepare(loginModel) {
            userData.id = user[id]
            userData.userId = user[userId]
            userData.mobileState = user[mobileState]
            userData.accessToken = user[accessToken]
            userDataArr.append(userData)
        }
        return userDataArr
    }
    
    //更新数据
//    func updateData(userId: String, old_name: String, new_name: String) {
//        let currUser = loginModel.filter(id == userId)
//        do {
//            try db.run(currUser.update(name <- name.replace(old_name, with: new_name)))
//        } catch {
//            print(error)
//        }
//
//    }
    
    //删除数据
    func delData(userId: String) {
        let currUser = loginModel.filter(id == userId)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        user_id = aDecoder.decodeObject(forKey: PropertyKey.user_idKey) as? String
        access_token = aDecoder.decodeObject(forKey: PropertyKey.access_tokenKey) as? String
        org_id = aDecoder.decodeObject(forKey: PropertyKey.org_idKey) as? String
        mobile_state = aDecoder.decodeObject(forKey: PropertyKey.mobile_stateKey) as? String
        data_state = aDecoder.decodeObject(forKey: PropertyKey.data_stateKey) as? String
        auth_state = aDecoder.decodeObject(forKey: PropertyKey.auth_stateKey) as? String
        dis_state = aDecoder.decodeObject(forKey: PropertyKey.dis_stateKey) as? String
        type = aDecoder.decodeObject(forKey: PropertyKey.typeKey) as? String
        register_state = aDecoder.decodeObject(forKey: PropertyKey.register_stateKey) as? String
        play_state = aDecoder.decodeObject(forKey: PropertyKey.play_stateKey) as? String
        org_name = aDecoder.decodeObject(forKey: PropertyKey.org_nameKey) as? String
        data_state_time = aDecoder.decodeObject(forKey: PropertyKey.data_state_timeKey) as? String
        ly_count = aDecoder.decodeObject(forKey: PropertyKey.ly_countKey) as? String
        hy_count = aDecoder.decodeObject(forKey: PropertyKey.hy_countKey) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_id, forKey: PropertyKey.user_idKey)
        aCoder.encode(access_token, forKey: PropertyKey.access_tokenKey)
        aCoder.encode(org_id, forKey: PropertyKey.org_idKey)
        aCoder.encode(mobile_state, forKey: PropertyKey.mobile_stateKey)
        aCoder.encode(data_state, forKey: PropertyKey.data_stateKey)
        aCoder.encode(auth_state, forKey: PropertyKey.auth_stateKey)
        aCoder.encode(dis_state, forKey: PropertyKey.dis_stateKey)
        aCoder.encode(type, forKey: PropertyKey.typeKey)
        aCoder.encode(register_state, forKey: PropertyKey.register_stateKey)
        aCoder.encode(play_state, forKey: PropertyKey.play_stateKey)
        aCoder.encode(org_name, forKey: PropertyKey.org_nameKey)
        aCoder.encode(data_state_time, forKey: PropertyKey.data_state_timeKey)
        aCoder.encode(ly_count, forKey: PropertyKey.ly_countKey)
        aCoder.encode(hy_count, forKey: PropertyKey.hy_countKey)
    }
}

struct TYSLoginGetCaptcha: HandyJSON {
    var vstatus: String? // 验证码
}
