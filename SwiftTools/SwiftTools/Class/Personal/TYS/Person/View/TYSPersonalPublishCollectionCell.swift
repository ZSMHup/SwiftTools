//
//  TYSPersonalPublishCollectionCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSPersonalPublishCollectionCell: UICollectionViewCell {
    
    private var imgView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabConfig(tabDataSource: [String : String]) {
        imgView?.image = UIImage(named: tabDataSource["image"]!)
    }
}

extension TYSPersonalPublishCollectionCell {
    
    private func addSubViews() {
        imgView = UIImageView()
        imgView?.isUserInteractionEnabled = true
        contentView.addSubview(imgView!)
        imgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 10))
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 5))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -10))
            make.bottom.equalTo(contentView.snp.bottom)
        })
    }
}
