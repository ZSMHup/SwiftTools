//
//  TYSSectionView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/21.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

typealias rightBtnBlock = (UIButton) -> Void

class TYSSectionView: UIView {
    
    private lazy var bgView: UIView = {
        let tempbgView = UIView()
        return tempbgView
    }()
    
    private var leftLabel: UILabel?
    private var rightBtn: UIButton?
    var leftText = ""
    var rightImgText = ""
    
    var rightBtnAction: rightBtnBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWith(leftTitle: String, rightImage: String) -> TYSSectionView {
        let sectionView = TYSSectionView()
        sectionView.backgroundColor = UIColor.white
        sectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: AdaptH(h: 60))
        sectionView.leftText = leftTitle
        sectionView.rightImgText = rightImage
        sectionView.setupUI()
        return sectionView
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
        
        leftLabel = UILabel()
        leftLabel?.textColor = tys_blackColor
        leftLabel?.text = leftText
        leftLabel?.font = SystemFont(fontSize: 20)
        bgView.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(bgView)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        
        rightBtn = UIButton()
        rightBtn?.setImage(UIImage(named: rightImgText), for: .normal)
        rightBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20)
        rightBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0)
        rightBtn?.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        bgView.addSubview(rightBtn!)
        rightBtn?.snp.makeConstraints { (make) in
            make.centerY.equalTo((leftLabel?.snp.centerY)!)
            make.right.equalTo(bgView)
            make.size.equalTo(CGSize(width: AdaptW(w: 100), height: AdaptH(h: 40)))
        }
    }
    
    func addRightBtnAction(tempRightBtnAction: @escaping rightBtnBlock) {
        rightBtnAction = tempRightBtnAction
    }
    
    @objc private func rightBtnClick() {
        if rightBtnAction != nil {
            rightBtnAction!(rightBtn!)
        }
    }
    
}
