//
//  TYSPersonalCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSPersonalCell: UITableViewCell {
    private var leftImgView: UIImageView?
    private var leftLabel: UILabel?
    private var rightImgView: UIImageView?
    private var rightLabel: UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabConfig(tabDataSource: [String : String]) {
        leftImgView?.image = UIImage(named: tabDataSource["leftImage"]!)
        leftLabel?.text = tabDataSource["leftText"]
    }
    
}

extension TYSPersonalCell {
    private func addSubViews() {
        leftImgView = UIImageView()
        contentView.addSubview(leftImgView!)
        leftImgView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 24))
        })
        
        leftLabel = UILabel()
        leftLabel?.textColor = tys_middleDarkColor
        leftLabel?.font = SystemFont(fontSize: 16)
        leftLabel?.textAlignment = .left
        contentView.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo((leftImgView?.snp.right)!).offset(AdaptW(w: 21))
        })
        
        rightImgView = UIImageView()
        rightImgView?.image = UIImage(named: "default_arrow_right")
        contentView.addSubview(rightImgView!)
        rightImgView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -24))
        })
        
        rightLabel = UILabel()
        rightLabel?.textColor = tys_middleDarkColor
        rightLabel?.font = SystemFont(fontSize: 14)
        rightLabel?.textAlignment = .right
        contentView.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo((leftImgView?.snp.left)!).offset(AdaptW(w: -10))
        })
        
    }
}
