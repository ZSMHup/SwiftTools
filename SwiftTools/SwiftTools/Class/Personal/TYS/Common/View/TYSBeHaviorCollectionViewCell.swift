//
//  TYSBeHaviorCollectionViewCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSBeHaviorCollectionViewCell: UICollectionViewCell {
    var countLabel: UILabel?
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabConfig(tabDataSource: [String : String]) {
        titleLabel?.text = tabDataSource["featureTitle"]!
        countLabel?.text = tabDataSource["count"]!
    }
}

extension TYSBeHaviorCollectionViewCell {
    
    private func addSubViews() {
        
        titleLabel = UILabel()
        titleLabel?.text = "贡献值"
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = tys_disabledTextColor
        titleLabel?.font = SystemFont(fontSize: 16)
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -5))
        })
        
        countLabel = UILabel()
        countLabel?.text = "0"
        countLabel?.textAlignment = .center
        countLabel?.textColor = hexString("#A7A7AA")
        countLabel?.font = SystemFont(fontSize: 36)
        contentView.addSubview(countLabel!)
        countLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((titleLabel?.snp.centerX)!)
            make.bottom.equalTo((titleLabel?.snp.top)!).offset(AdaptH(h: -10))
        })
    }
}

