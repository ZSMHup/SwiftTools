//
//  TYSLiveSyncViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSLiveSyncViewController: AYBaseViewController {

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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.tableView.mj_header.endRefreshing()
            })
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.tableView.mj_footer.endRefreshing()
            })
        })
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: delegate
extension TYSLiveSyncViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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

