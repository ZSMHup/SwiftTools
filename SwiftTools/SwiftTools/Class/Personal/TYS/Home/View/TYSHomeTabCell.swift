//
//  TYSHomeTabCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSHomeTabCell: UICollectionViewCell {
    var userImgView: UIImageView?
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TYSHomeTabCell {
    
    private func addSubViews() {
        userImgView = UIImageView()
        userImgView?.image = UIImage(named: "home_icon_roadshow")
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 17.5))
            make.centerX.equalTo(contentView)
        })
        
        titleLabel = UILabel()
        titleLabel?.text = "路演"
        titleLabel?.textAlignment = .left
        titleLabel?.textColor = tys_middleDarkColor
        titleLabel?.font = SystemFont(fontSize: 16)
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((userImgView?.snp.centerX)!)
            make.bottom.equalTo(contentView.snp.bottom)
        })
        
    }
}
