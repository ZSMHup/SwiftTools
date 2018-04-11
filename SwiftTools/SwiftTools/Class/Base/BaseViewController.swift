//
//  BaseViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        print("deinit: \(self.classForCoder)")
    }
}

// MARK: 点击直播列表跳转
extension BaseViewController {
    func liveDetail(liveListModel: TYSLiveCommonModel) {
        
        if liveListModel.up_down! == "2" {
            print("该直播已下架")
            return
        }
        
        let liveId: String = liveListModel.id!
        requestLiveDetailData(liveId: liveId) { (liveDetailModel) in
            
            if (liveDetailModel.dialing_number != nil) {
                print("电话会议拨打页面")
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
                    getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func requestLiveDetailData(liveId: String, completion: @escaping (TYSLiveDetailModel) -> ()) {
        let param = ["requestCode" : "80005", "id" : liveId, "user_id" : loginModel.user_id ?? ""]
        requestLiveDetail(paramterDic: param, successCompletion: { (successValue) in
            completion(successValue)
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
}
