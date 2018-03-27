//
//  TYSCommonCollectionViewCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSCommonCollectionViewCell: UICollectionViewCell {
    var commonImgView: UIImageView?
    var stateImgView: UIImageView?
    var watchCountLabel: UILabel?
    var titleLabel: UILabel?
    var nameLabel: UILabel?
    var dateLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: TYSLiveCommonModel) {
        
    }
}



extension TYSCommonCollectionViewCell {
    
    private func addSubViews() {
        commonImgView = UIImageView()
        commonImgView?.image = UIImage(named: "default_live_cover")
        contentView.addSubview(commonImgView!)
        commonImgView?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(contentView.frame.size.width * 3 / 4)
        })
        
        stateImgView = UIImageView()
        stateImgView?.image = UIImage(named: "default_label_yestday")
        contentView.addSubview(stateImgView!)
        stateImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView)
            make.top.equalTo((commonImgView?.snp.bottom)!).offset(AdaptH(h: 5))
            make.size.equalTo(CGSize(width: AdaptW(w: 17), height: AdaptH(h: 14)))
        })
        
        watchCountLabel = UILabel()
        watchCountLabel?.text = "123人"
        watchCountLabel?.textColor = tys_titleColor
        watchCountLabel?.font = SystemFont(fontSize: 10)
        contentView.addSubview(watchCountLabel!)
        watchCountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((stateImgView?.snp.right)!).offset(AdaptW(w: 5))
            make.centerY.equalTo((stateImgView?.snp.centerY)!)
        })
        
        titleLabel = UILabel()
        titleLabel?.text = "太平洋证券非银百万亿大资监管新政解读太平洋证券非银百万亿大资"
        titleLabel?.textColor = tys_blackColor
        titleLabel?.font = SystemFont(fontSize: 15)
        titleLabel?.numberOfLines = 3
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((stateImgView?.snp.bottom)!).offset(AdaptH(h: 5))
            make.left.right.equalTo(contentView)
        })
        
        dateLabel = UILabel()
        dateLabel?.text = "03/21 20:00"
        dateLabel?.textAlignment = .left
        dateLabel?.textColor = tys_lightColor
        dateLabel?.font = SystemFont(fontSize: 11)
        contentView.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(AdaptH(h: 5))
        })
        
        nameLabel = UILabel()
        nameLabel?.text = "申万宏源策略"
        nameLabel?.textAlignment = .left
        nameLabel?.textColor = tys_titleColor
        nameLabel?.font = SystemFont(fontSize: 11)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((dateLabel?.snp.centerY)!)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView).offset(AdaptW(w: 80))
        })
    }
}
