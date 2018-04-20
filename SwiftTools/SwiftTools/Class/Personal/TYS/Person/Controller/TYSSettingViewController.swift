//
//  TYSSettingViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/10.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSSettingViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect.zero, style: .plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorInset = UIEdgeInsetsMake(0, AdaptW(w: 24), 0, AdaptW(w: 24))
        tempTableView.separatorColor = tys_lineColor
        tempTableView.tableFooterView = UIView()
        tempTableView.register(TYSSettingCell.self, forCellReuseIdentifier: "TYSSettingCell")
        return tempTableView
    }()
    
    var configDataSource = ["清除缓存", "当前版本"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
    }

    private func addSubViews() {
        
        navigationItem.title = "设置"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    private func getFileSize() -> String {
        var stringSize: String?
        let size = AYCacheManager().getFileSize()
        if size < 1000 {
            stringSize = "\(size) B"
        } else if (1000 <= size && size < 1000 * 1000) {
            stringSize = String(format: "%.1f KB", size / 1000)
            
        } else {
            stringSize = String(format: "%.1f MB", size / 1000 / 1000)
        }
        return stringSize!
    }
    
}

extension TYSSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TYSSettingCell = tableView.dequeueReusableCell(withIdentifier: "TYSSettingCell")! as! TYSSettingCell
        cell.leftLabel?.text = configDataSource[indexPath.row]
        
        if indexPath.row == 0 {
            cell.rightLabel?.text = getFileSize()
        } else {
            cell.rightLabel?.text = "V4.0.5"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            TYSLoginModel.manager.deleteLoginTable()
        } else if indexPath.row == 1 {
            UserDefaults.standard.saveCustomObject(customObject: false as NSCoding, key: "LoginState")
            print("LoginState: \(UserDefaults.standard.getCustomObject(forKey: "LoginState") ?? false as AnyObject)")
        }
    }
}
