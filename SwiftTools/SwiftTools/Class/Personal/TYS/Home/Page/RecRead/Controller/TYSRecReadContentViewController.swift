//
//  TYSRecReadContentViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSRecReadContentViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
       let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
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
    
    private var page: Int = 1
    private var dataSource = [TYSRecReadModel]()

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
            self?.requestRecReadListData()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.page += 1
            self?.requestRecReadListData()
        })
        tableView.mj_header.beginRefreshing()
    }

    private func requestRecReadListData() {
        let param = [
            "requestCode" : "V240015",
            "page" : String(describing: page),
            "limit" : "10",
            "login_user_id" : loginModel.user_id ?? ""
        ]
        requestRecReadList(paramterDic: param, cacheCompletion: { (cacheValue) in
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
extension TYSRecReadContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: TYSRecReadModel = self.dataSource[indexPath.row]
        
        switch model.res {
        case "5"?:
            if model.tj_user_id == nil {
                let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell")! as! TYSRecReadContentCell
                cell.setModel(model: model)
                return cell
            } else {
                let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell1")! as! TYSRecReadContentCell
                cell.setModel(model: model)
                return cell
            }
        case "4"?, "6"?:
            if model.res == "4" {
                let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell")! as! TYSRecReadContentCell
                cell.setModel(model: model)
                return cell
            } else {
                let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell1")! as! TYSRecReadContentCell
                cell.setModel(model: model)
                return cell
            }
        default:
            let cell: TYSRecReadContentCell = tableView.dequeueReusableCell(withIdentifier: "TYSRecReadContentCell")! as! TYSRecReadContentCell
            cell.setModel(model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVc = TYSRecReadDetailViewController()
        detailVc.recReadModel = self.dataSource[indexPath.row]
        getCurrentController()?.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}

