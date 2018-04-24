//
//  TYSConnectionViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSConnectionViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = .none
        tempTableView.register(TYSCommonPersonalCell.self, forCellReuseIdentifier: "TYSCommonPersonalCellIsMe")
        tempTableView.register(TYSBehaviorCell.self, forCellReuseIdentifier: "TYSBehaviorCell")
        tempTableView.register(TYSConnectionLikelyPeoCell.self, forCellReuseIdentifier: "TYSConnectionLikelyPeoCell")
        tempTableView.register(TYSConnectionAnalystCell.self, forCellReuseIdentifier: "TYSConnectionAnalystCell")
        return tempTableView
    }()
    
    private var featureDataSource = [
        ["featureTitle" : "贡献值", "count" : "0"],
        ["featureTitle" : "粉丝", "count" : "0"],
        ["featureTitle" : "关注", "count" : "0"]
    ]
    
    var personalModel: TYSPersonalModel = TYSPersonalModel() {
        willSet {
            featureDataSource[0]["count"] = newValue.activityFormat
            featureDataSource[1]["count"] = newValue.fansCountFormat
            featureDataSource[2]["count"] = newValue.followCountFormat
        }
    }
    
    private var interestedPeoDataSource = [TYSInterestedPeopleModel]()
    private var analystDataSource = [TYSInterestedPeopleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "人脉"
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.requestPersonalDetailData()
            self?.requestInterestedPeopleData()
            self?.requestAnalystListData()
        })
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: requestData
extension TYSConnectionViewController {
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
    
    private func requestInterestedPeopleData() {
        let param = [
            "requestCode" : "V219001",
            "page" : "1",
            "limit" : "10",
            "login_user_id" : kLoginModel.user_id ?? ""
        ]
        
        requestInterestedPeople(paramterDic: param, cacheCompletion: { (cacheValue) in
            self.interestedPeoDataSource.removeAll()
            self.interestedPeoDataSource = cacheValue
            self.tableView.reloadData()
        }, successCompletion: { (valueArray) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            
            self.interestedPeoDataSource.removeAll()
            self.interestedPeoDataSource = valueArray
            self.tableView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    private func requestAnalystListData() {
        let param = [
            "requestCode" : "V219002",
            "page" : "1",
            "limit" : "10",
            "login_user_id" : kLoginModel.user_id ?? ""
        ]
        requestAnalystList(paramterDic: param, cacheCompletion: { (cacheValue) in
            self.analystDataSource.removeAll()
            self.analystDataSource = cacheValue
            self.tableView.reloadData()
        }, successCompletion: { (valueArray) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            self.analystDataSource.removeAll()
            self.analystDataSource = valueArray
            self.tableView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
}

// MARK: delegate
extension TYSConnectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TYSCommonPersonalCell = tableView.dequeueReusableCell(withIdentifier: "TYSCommonPersonalCellIsMe")! as! TYSCommonPersonalCell
            cell.selectionStyle = .none
            cell.setModel(model: personalModel)
            return cell
        case 1:
            let cell: TYSBehaviorCell = tableView.dequeueReusableCell(withIdentifier: "TYSBehaviorCell")! as! TYSBehaviorCell
            cell.selectionStyle = .none
            cell.didSelectedItemAction(tempClick: { (index) in
                printLog(index)
            })
            cell.setTabArray(tabArray: featureDataSource)
            return cell
        case 2:
            let cell: TYSConnectionLikelyPeoCell = tableView.dequeueReusableCell(withIdentifier: "TYSConnectionLikelyPeoCell")! as! TYSConnectionLikelyPeoCell
            cell.selectionStyle = .none
            cell.setInterestedPeoArray(interestedPeoArray: interestedPeoDataSource)
            return cell
            
        default:
            let cell: TYSConnectionAnalystCell = tableView.dequeueReusableCell(withIdentifier: "TYSConnectionAnalystCell")! as! TYSConnectionAnalystCell
            cell.selectionStyle = .none
            cell.setAnalystArray(analystArr: analystDataSource)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title: String?
        var image: String?
        
        switch section {
        case 2:
            title = "可能感兴趣的人"
            image = "default_arrow_renew"
            let sectionView = TYSSectionView().initWith(leftTitle: title!, rightImage: image!)
            sectionView.addRightBtnAction(tempRightBtnAction: {[weak self] (button) in
                self?.requestInterestedPeopleData()
            })
            return sectionView
        case 3:
            title = "分析师"
            image = "default_arrow_right"
            let sectionView = TYSSectionView().initWith(leftTitle: title!, rightImage: image!)
            sectionView.addRightBtnAction(tempRightBtnAction: {(button) in
                printLog("分析师")
            })
            return sectionView
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return AdaptH(h: 60)
        case 1:
            return AdaptH(h: 110)
        case 2:
            return AdaptH(h: 90)
        default:
            return AdaptH(h: 120)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        default:
            return AdaptH(h: 60)
        }
    }
    
}

