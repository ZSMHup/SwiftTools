//
//  TYSCommonLikelyPeoCollectionViewCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSCommonLikelyPeoCollectionViewCell: UICollectionViewCell {
    
    var userImgView: UIImageView?
    var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TYSCommonLikelyPeoCollectionViewCell {
    
    private func addSubViews() {
        userImgView = UIImageView()
        userImgView?.image = UIImage(named: "defaut_avatar")
        userImgView?.layer.cornerRadius = AdaptW(w: 54) / 2
        userImgView?.layer.masksToBounds = true
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: AdaptW(w: 54), height: AdaptW(w: 54)))
        })
        
        nameLabel = UILabel()
        nameLabel?.text = "申万宏源"
        nameLabel?.textAlignment = .left
        nameLabel?.textColor = tys_titleColor
        nameLabel?.font = SystemFont(fontSize: 12)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((userImgView?.snp.centerX)!)
            make.left.equalTo((userImgView?.snp.left)!)
            make.top.equalTo((userImgView?.snp.bottom)!).offset(AdaptH(h: 8))
        })
        
    }
}
