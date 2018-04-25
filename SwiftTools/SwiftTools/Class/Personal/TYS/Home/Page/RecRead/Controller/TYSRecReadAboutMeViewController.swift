//
//  TYSRecReadAboutMeViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSRecReadAboutMeViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorInset = UIEdgeInsetsMake(0, AdaptW(w: 23), 0, AdaptW(w: 23))
        tempTableView.separatorColor = tys_lineColor
        tempTableView.tableFooterView = UIView()
        tempTableView.rowHeight = UITableViewAutomaticDimension
        tempTableView.estimatedRowHeight = 100
        tempTableView.register(TYSRecReadAboutMeCell.self, forCellReuseIdentifier: "TYSRecReadAboutMeCell")
        return tempTableView
    }()
    
    private var page: Int = 1
    private var dataSource = [TYSRecReadAboutMeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-kNavigationBarHeight)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.page = 1
            self?.requestRecReadAboutMeListData()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.page += 1
            self?.requestRecReadAboutMeListData()
        })
        tableView.mj_header.beginRefreshing()
    }
}

extension TYSRecReadAboutMeViewController {
    private func requestRecReadAboutMeListData() {
        let param = [
            "requestCode" : "V240013",
            "page" : String(describing: page),
            "limit" : "10",
            "user_id" : kLoginModel.user_id ?? ""
        ]
        requestRecReadAboutMeList(paramterDic: param, cacheCompletion: { (cacheValue) in
            if self.tableView.mj_header.isRefreshing {
                if !cacheValue.isEmpty {
                    self.dataSource.removeAll()
                    self.dataSource = cacheValue
                    self.tableView.reloadData()
                }
            }
        }, successCompletion: { (successValue) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
                self.dataSource.removeAll()
            }
            
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
            self.dataSource.append(contentsOf: successValue)
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
extension TYSRecReadAboutMeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TYSRecReadAboutMeCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadAboutMeCell") as! TYSRecReadAboutMeCell
        cell.setModel(model: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        printLog("\(classForCoder) --- \(indexPath.row)")
        printLog("\(String(describing: getCurrentController()))")
    }
    
}
