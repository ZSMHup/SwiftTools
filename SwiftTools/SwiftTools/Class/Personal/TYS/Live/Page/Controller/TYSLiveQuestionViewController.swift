//
//  TYSLiveQuestionViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSLiveQuestionViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.contentInset = UIEdgeInsetsMake(200 + 30, 0, 0, 0)
        tempTableView.scrollIndicatorInsets = UIEdgeInsetsMake(200 + 30, 0, 0, 0)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorInset = UIEdgeInsetsMake(0, AdaptW(w: 23), 0, AdaptW(w: 23))
        tempTableView.separatorColor = tys_lineColor
        tempTableView.tableFooterView = UIView()
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
extension TYSLiveQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        print("\(classForCoder) --- \(indexPath.row)")
        print("\(String(describing: getCurrentController()))")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetDifference = scrollView.contentOffset.y - lastContentOffset.y;
        
        NotificationCenter.default.post(name: ChildScrollViewDidScrollNSNotification, object: nil, userInfo: ["scrollingScrollView" : scrollView, "offsetDifference" : offsetDifference])
        lastContentOffset = scrollView.contentOffset;
    }
    
}

