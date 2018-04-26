//
//  BaseViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import SnapKit

let LogoutNotification: NSNotification.Name = NSNotification.Name(rawValue: "LogoutNotification")

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        addNotification()
    }
    
    deinit {
        printLog("deinit: \(self.classForCoder)")
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginOut), name: LogoutNotification, object: nil)
    }
}

extension BaseViewController {
    @objc private func loginOut() {
        UserDefaults.standard.saveCustomObject(customObject: false as NSCoding, key: "LoginState")
        deleteDB()
        removeAllCache { (remove) in }
        let loginVc = TYSLoginViewController()
        let loginNav = NavigationViewController(rootViewController: loginVc)
        getCurrentWindow()?.rootViewController = loginNav
    }
}

// MARK: 点击直播列表跳转
extension BaseViewController {
    func liveDetail(liveListModel: TYSLiveCommonModel) {
        
        if liveListModel.up_down! == "2" {
            showOnlyText(text: "该直播已下架")
            return
        }
        
        let liveId: String = liveListModel.id!
        requestLiveDetailData(liveId: liveId) { (liveDetailModel) in
            
            if (liveDetailModel.dialing_number != nil) {
                printLog("电话会议拨打页面")
                return
            }
            
            let liveState = liveDetailModel.state!
            
            if liveState == "3" {
                let vc = TYSLiveAudioBackViewController()
                vc.navigationItem.title = liveDetailModel.subject!
                vc.liveDetailModel = liveDetailModel
                getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
            } else {
                if liveDetailModel.is_melive! == "1" {
                    let vc = TYSLivePersonalRoomViewController()
                    vc.navigationItem.title = liveDetailModel.subject!
                    getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = TYSLiveOtherPeopleRoomViewController()
                    vc.navigationItem.title = liveDetailModel.subject!
                    vc.liveDetailModel = liveDetailModel
                    getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func requestLiveDetailData(liveId: String, completion: @escaping (TYSLiveDetailModel) -> ()) {
        let param = [
            "requestCode" : "80005",
            "id" : liveId,
            "user_id" : kLoginModel.user_id ?? ""
        ]
        requestLiveDetail(paramterDic: param, successCompletion: { (successValue) in
            completion(successValue)
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
}
