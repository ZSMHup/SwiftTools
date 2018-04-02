//
//  TYSRecReadAboutMeCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadAboutMeCell: UITableViewCell {
    
    private var contentLabel: UILabel?
    private var timeLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

extension TYSRecReadAboutMeCell {
    private func addSubViews() {
        contentLabel = UILabel()
        contentLabel?.text = "万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长"
        contentLabel?.textColor = tys_middleDarkColor
        contentLabel?.font = SystemFont(fontSize: 17)
        contentLabel?.numberOfLines = 0
        contentView.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 5))
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -30))
        })
        
        timeLabel = UILabel()
        timeLabel?.text = "2018-04-02"
        timeLabel?.textColor = tys_lightColor
        timeLabel?.font = SystemFont(fontSize: 10)
        timeLabel?.textAlignment = .right
        contentView.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -5))
        })
    }
    
    
}
