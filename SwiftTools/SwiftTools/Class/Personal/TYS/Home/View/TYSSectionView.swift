//
//  TYSSectionView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/21.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSSectionView: UIView {
    private lazy var bgView = UIView()
    private lazy var leftLabel = UILabel()
    private lazy var rightBtn = UIButton()
    var leftText = String()
    var rightImgText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func initWithLeftTitle(title: String, image: String) -> TYSSectionView {
        
        var sectionView: TYSSectionView?
        
        if sectionView === nil {
            sectionView = TYSSectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: AdaptH(h: 60)))
            sectionView?.leftText = title
            sectionView?.rightImgText = image
            sectionView?.setupUI()
        }
        
        return sectionView!
    }
}


// MARK: UI
extension TYSSectionView {
    private func setupUI() {
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(self.snp.right).offset(AdaptW(w: -23))
            make.top.bottom.equalTo(self)
        }
        
        leftLabel.textColor = tys_blackColor
        leftLabel.text = leftText
        leftLabel.font = SystemFont(fontSize: 20)
        bgView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        
        rightBtn.setImage(UIImage(named: rightImgText), for: .normal)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        bgView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftLabel.snp.centerY)
            make.right.equalTo(bgView)
            make.size.equalTo(CGSize(width: AdaptW(w: 100), height: AdaptH(h: 40)))
        }
    }
    
    @objc private func rightBtnClick() {
        
    }
    
}
