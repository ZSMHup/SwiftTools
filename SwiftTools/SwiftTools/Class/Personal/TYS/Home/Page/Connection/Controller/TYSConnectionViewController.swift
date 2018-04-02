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
        tempTableView.register(TYSConnectionLikelyPeoCell.self, forCellReuseIdentifier: "TYSConnectionLikelyPeoCell")
        tempTableView.register(TYSCommonPersonalCell.self, forCellReuseIdentifier: "TYSCommonPersonalAddMoveBtnCell")
        return tempTableView
    }()
    
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.tableView.mj_header.endRefreshing()
            })
        })
        tableView.mj_header.beginRefreshing()
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
            return cell
        case 1:
            let cell: TYSCommonPersonalCell = tableView.dequeueReusableCell(withIdentifier: "TYSCommonPersonalCellIsMe")! as! TYSCommonPersonalCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell: TYSConnectionLikelyPeoCell = tableView.dequeueReusableCell(withIdentifier: "TYSConnectionLikelyPeoCell")! as! TYSConnectionLikelyPeoCell
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell: TYSCommonPersonalCell = tableView.dequeueReusableCell(withIdentifier: "TYSCommonPersonalCellIsMe")! as! TYSCommonPersonalCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title: String?
        var image: String?
        
        switch section {
        case 0:
            return nil
        case 1:
            return nil
        case 2:
            title = "可能感兴趣的人"
            image = "default_arrow_renew"
            let sectionView = TYSSectionView().initWithLeftTitle(title: title!, image: image!)
            sectionView.addRightBtnAction(tempRightBtnAction: {(button) in
                print("可能感兴趣的人")
            })
            return sectionView
        default:
            title = "分析师"
            image = "default_arrow_right"
            let sectionView = TYSSectionView().initWithLeftTitle(title: title!, image: image!)
            sectionView.addRightBtnAction(tempRightBtnAction: {(button) in
                print("分析师")
            })
            return sectionView
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 100
        case 2:
            return 90
        default:
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        default:
            return 60
        }
    }
    
}

