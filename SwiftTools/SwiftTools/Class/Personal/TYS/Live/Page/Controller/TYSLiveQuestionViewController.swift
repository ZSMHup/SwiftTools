//
//  TYSLiveQuestionViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSLiveQuestionViewController: AYBaseViewController {
    
    var liveDetailModel = TYSLiveDetailModel()
    var page: Int = 0
    var dataSource = [TYSLiveQuestionModel]()
    private var meDataSource = [TYSQuestionModel]()
    private var allDataSource = [TYSQuestionModel]()
    
    
    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .grouped)
        tempTableView.backgroundColor = UIColor.white
        tempTableView.contentInset = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0)
        tempTableView.scrollIndicatorInsets = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = .none
        tempTableView.tableFooterView = UIView()
        tempTableView.rowHeight = UITableViewAutomaticDimension
        tempTableView.estimatedRowHeight = 100
        tempTableView.estimatedSectionFooterHeight = 0
        tempTableView.estimatedSectionHeaderHeight = 0
        tempTableView.register(TYSLiveQuestionCell.self, forCellReuseIdentifier: "TYSLiveQuestionCell")
        return tempTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        baseScrollView = tableView
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.page = 1
            self?.requestQuestionListData()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.page += 1
            self?.requestQuestionListData()
        })
        tableView.mj_header.beginRefreshing()
    }
    
    private func requestQuestionListData() {
        let param = [
            "requestCode" : "80007",
            "page" : String(describing: page),
            "limit" : "10",
            "user_id" : kLoginModel.user_id ?? "",
            "t" : "2",
            "live_id" : liveDetailModel.id ?? ""
        ]
        requestLiveQuestionList(paramterDic: param, cacheCompletion: { (cacheValue) in
            if self.tableView.mj_header.isRefreshing {
                self.meDataSource.removeAll()
                self.allDataSource.removeAll()
                if cacheValue.me_question != nil {
                    let meArr: [TYSQuestionModel] = cacheValue.me_question!
                    self.meDataSource = meArr
                }
                if cacheValue.unme_or_all_question != nil {
                    let allArr: [TYSQuestionModel] = cacheValue.unme_or_all_question!
                    self.allDataSource.append(contentsOf: allArr)
                }
                self.tableView.reloadData()
            }
        }, successCompletion: { (successValue) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
                self.meDataSource.removeAll()
                self.allDataSource.removeAll()
            }
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
            
            if successValue.me_question != nil {
                let meArr: [TYSQuestionModel] = successValue.me_question!
                self.meDataSource = meArr
            }
            if successValue.unme_or_all_question != nil {
                let allArr: [TYSQuestionModel] = successValue.unme_or_all_question!
                self.allDataSource.append(contentsOf: allArr)
            }
            
            self.tableView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
}

// MARK: delegate
extension TYSLiveQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return meDataSource.count
        }
        return allDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TYSLiveQuestionCell = tableView.dequeueReusableCell(withIdentifier: "TYSLiveQuestionCell")! as! TYSLiveQuestionCell
        
        if indexPath.section == 0 {
            cell.setModel(model: meDataSource[indexPath.row])
        } else {
            cell.setModel(model: allDataSource[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        printLog("\(classForCoder) --- \(indexPath.row)")
        printLog("\(String(describing: getCurrentController()))")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return meDataSource.count > 0 ? 50 : 0.01
        } else if section == 1 {
            return allDataSource.count > 0 ? 50 : 0.01
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.backgroundColor = UIColor.white
        sectionLabel.font = SystemFont(fontSize: 20)
        sectionLabel.textColor = tys_blackColor
        
        if section == 0 {
            sectionLabel.text = "    我的提问"
        } else {
            sectionLabel.text = "    其他提问"
        }
        if section == 0 {
            
            return meDataSource.count > 0 ? sectionLabel : nil
        }
        return allDataSource.count > 0 ? sectionLabel : nil
    }
    
}

