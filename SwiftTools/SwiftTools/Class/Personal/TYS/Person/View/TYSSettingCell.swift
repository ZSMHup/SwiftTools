//
//  TYSSettingCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/10.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSSettingCell: UITableViewCell {

    var leftLabel: UILabel?
    var rightLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        leftLabel = UILabel()
        leftLabel?.textColor = tys_middleDarkColor
        leftLabel?.font = SystemFont(fontSize: 16)
        contentView.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
        })
        
        rightLabel = UILabel()
        rightLabel?.textColor = tys_lightColor
        rightLabel?.font = SystemFont(fontSize: 16)
        contentView.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
        })
    }
    
}
