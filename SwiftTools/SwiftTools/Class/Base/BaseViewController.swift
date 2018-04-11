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
        let liveId: String = liveListModel.id!
        let liveImgPath: String = liveListModel.live_img_path!
        print("liveId: \(liveId) -- liveImgPath: \(liveImgPath)")
        
        if liveListModel.up_down! == "2" {
            print("该直播已下架")
            return
        }
        
        if (liveListModel.dialing_number != nil) {
            print("电话会议拨打页面")
            return
        }
        
        let liveState = liveListModel.state!
        
        if liveState == "3" {
            let vc = TYSLiveAudioBackViewController()
            vc.navigationItem.title = liveListModel.subject!
            vc.liveListModel = liveListModel
            getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
        } else {
            if liveListModel.is_melive! == "1" {
                let vc = TYSLivePersonalRoomViewController()
                vc.navigationItem.title = liveListModel.subject!
                getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = TYSLiveOtherPeopleRoomViewController()
                vc.navigationItem.title = liveListModel.subject!
                getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
