//
//  TYSLiveFileViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSLiveFileViewController: AYBaseViewController {

    var dataSource = [TYSLiveFileModel]()
    var liveDetailModel = TYSLiveDetailModel()
    
    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.contentInset = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0)
        tempTableView.scrollIndicatorInsets = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorInset = UIEdgeInsetsMake(0, AdaptW(w: 23), 0, AdaptW(w: 23))
        tempTableView.separatorColor = tys_lineColor
        tempTableView.tableFooterView = UIView()
        tempTableView.rowHeight = UITableViewAutomaticDimension
        tempTableView.estimatedRowHeight = 100
        tempTableView.register(TYSRecReadContentCell.self, forCellReuseIdentifier: "TYSRecReadContentCell")
        tempTableView.register(TYSRecReadContentCell.self, forCellReuseIdentifier: "TYSRecReadContentCell1")
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
            self?.requestLiveFileListData()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.requestLiveFileListData()
        })
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: requestData
extension TYSLiveFileViewController {
    private func requestLiveFileListData() {
        let param = [
            "requestCode" : "80009",
            "user_id" : kLoginModel.user_id ?? "",
            "live_id" : liveDetailModel.id ?? ""
        ]
        
        requestLiveFileList(paramterDic: param, cacheCompletion: { (cacheValue) in
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
extension TYSLiveFileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell")! as! TYSRecReadContentCell
            
            return cell
        } else {
            let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell1")! as! TYSRecReadContentCell
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        printLog("\(classForCoder) --- \(indexPath.row)")
        printLog("\(String(describing: getCurrentController()))")
    }
}

