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
        tempTableView.register(TYSSettingCell.self, forCellReuseIdentifier: "TYSSettingCell")
        return tempTableView
    }()
    
    var configDataSource = ["清除缓存", "当前版本", "关于我的", "个人中心"]
    
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
}

extension TYSSettingViewController {
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
    
    @objc private func logoutBtnClick() {
        NotificationCenter.default.post(name: LogoutNotification, object: nil)
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
        } else if indexPath.row == 1 {
            cell.rightLabel?.text = "V4.0.5"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
        let logoutBtn = UIButton()
        logoutBtn.setTitle("退 出", for: .normal)
        logoutBtn.setTitleColor(UIColor.white, for: .normal)
        logoutBtn.backgroundColor = tys_backgroundColor
        logoutBtn.addTarget(self, action: #selector(logoutBtnClick), for: .touchUpInside)
        footer.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(footer.snp.centerY)
            make.centerX.equalTo(footer.snp.centerX)
            make.width.equalTo(kScreenW - 46)
            make.height.equalTo(50)
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TYSCommonWebViewController()
        
        if indexPath.row == 0 {
        } else if indexPath.row == 1 {
            vc.liveWebUrl = "http://192.168.20.18:3000/Live/LiveDetail/3ae871adf8c13566506e55be21f63034/110430/3050"
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            vc.liveWebUrl = webUrl + "Personal/Setting/AboutMe"
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            vc.liveWebUrl = webUrl + "Personal"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
