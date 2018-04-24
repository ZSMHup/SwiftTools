//
//  TYSPersonalViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSPersonalViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorInset = UIEdgeInsetsMake(0, AdaptW(w: 24), 0, AdaptW(w: 24))
        tempTableView.separatorColor = tys_lineColor
        tempTableView.tableFooterView = UIView()
        tempTableView.register(TYSPersonalCell.self, forCellReuseIdentifier: "TYSPersonalCell")
        tempTableView.register(TYSBehaviorCell.self, forCellReuseIdentifier: "TYSBehaviorCell")
        tempTableView.register(TYSCommonPersonalCell.self, forCellReuseIdentifier: "TYSCommonPersonalCenterCell")
        tempTableView.register(TYSPersonalPublishCell.self, forCellReuseIdentifier: "TYSPersonalPublishCell")
        return tempTableView
    }()
    
    private var featureDataSource = [
        ["featureTitle" : "研值", "count" : "0"],
        ["featureTitle" : "粉丝", "count" : "0"],
        ["featureTitle" : "关注", "count" : "0"]
    ]
    private var publishDataSource = [
        ["image" : "personal_user_button_melive", "count" : "0"],
        ["image" : "personal_user_button_addfriends", "count" : "0"]
    ]

    private var personalDataSource = [
        ["leftImage" : "personal_user_dl", "leftText" : "我的下载"],
        ["leftImage" : "personal_user_fav", "leftText" : "我的收藏"],
        ["leftImage" : "personal_user_prefer", "leftText" : "偏好选择"],
        ["leftImage" : "personal_user_about", "leftText" : "关于我们"],
        ["leftImage" : "personal_user_fb", "leftText" : "意见反馈"],
        ["leftImage" : "personal_user_settings", "leftText" : "设置"]
    ]
    
    var personalModel: TYSPersonalModel = TYSPersonalModel() {
        willSet {
            featureDataSource[0]["count"] = newValue.activityFormat
            featureDataSource[1]["count"] = newValue.fansCountFormat
            featureDataSource[2]["count"] = newValue.followCountFormat
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
    }
    
    private func requestPersonalDetailData() {
        let param = [
            "requestCode" : "10002",
            "user_id" : kLoginModel.user_id ?? "",
        ]
        requestPersonalDetail(paramterDic: param, cacheCompletion: { (cacheValue) in
            
            
        }, successCompletion: { (successValue) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            TYSPersonalModel.manager.insertOrUpdate(personalModel: successValue)
            
            self.personalModel = successValue
            self.tableView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
}

// MARK: setup ui
extension TYSPersonalViewController {
    private func addSubViews() {
        let rightBtn = UIButton()
        rightBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightBtn.setImage(UIImage(named: "default_nav_msg"), for: .normal)
        rightBtn.addTarget(self, action: #selector(navRightBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        addTableView()
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.requestPersonalDetailData()
        })
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: event response
extension TYSPersonalViewController {
    @objc private func navRightBtnClick() {
        printLog("msg")
    }
}

// MARK: delegate
extension TYSPersonalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + personalDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: TYSCommonPersonalCell = tableView.dequeueReusableCell(withIdentifier: "TYSCommonPersonalCenterCell")! as! TYSCommonPersonalCell
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenW)
            cell.setModel(model: personalModel)
            return cell
        case 1:
            let cell: TYSBehaviorCell = tableView.dequeueReusableCell(withIdentifier: "TYSBehaviorCell")! as! TYSBehaviorCell
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenW)
            cell.setTabArray(tabArray: featureDataSource)
            cell.didSelectedItemAction(tempClick: { (index) in
                printLog(index)
            })
            return cell
        case 2:
            let cell: TYSPersonalPublishCell = tableView.dequeueReusableCell(withIdentifier: "TYSPersonalPublishCell")! as! TYSPersonalPublishCell
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenW)
            cell.setTabArray(tabArray: publishDataSource)
            cell.didSelectedItemAction(tempClick: { (index) in
                printLog(index)
            })
            return cell
        default:
            let cell: TYSPersonalCell = tableView.dequeueReusableCell(withIdentifier: "TYSPersonalCell")! as! TYSPersonalCell
            cell.setTabConfig(tabDataSource: personalDataSource[indexPath.row - 3])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return AdaptH(h: 60)
        case 1:
            return AdaptH(h: 110)
        case 2:
            return AdaptH(h: 60)
        default:
            return AdaptH(h: 50)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 8:
            navigationController?.pushViewController(TYSSettingViewController(), animated: true)
            
        default:
            break
        }
        
    }
}


