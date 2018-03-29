//
//  AYPageMenuCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class AYPageMenuCell: UICollectionViewCell {
    
    var line: UIView?
    var menuBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(item: String) {
        menuBtn?.setTitle(item, for: .normal)
    }
}

extension AYPageMenuCell {
    
    private func addSubViews() {
        line = UIView()
        line?.backgroundColor = UIColor.red
        contentView.addSubview(line!)
        line?.snp.makeConstraints({ (make) in
            make.edges.equalTo(contentView)
        })
        
        menuBtn = UIButton()
        menuBtn?.backgroundColor = UIColor.white
        menuBtn?.setTitleColor(UIColor.gray, for: .normal)
        menuBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        contentView.addSubview(menuBtn!)
        menuBtn?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(line!)
            make.bottom.equalTo((line?.snp.bottom)!).offset(-1.0)
        })
        
    }
}
