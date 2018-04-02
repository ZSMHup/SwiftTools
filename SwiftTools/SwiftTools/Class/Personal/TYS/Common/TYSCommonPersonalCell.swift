//
//  TYSCommonPersonalCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSCommonPersonalCell: UITableViewCell {
    
    private var userImgView: UIImageView?
    private var nameLabel: UILabel?
    private var orgLabel: UILabel?
    
    private var addAttentionBtn: UIButton?
    private var commonBtn: UIButton?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "TYSCommonPersonalCell" {
            addCommonSubViews()
        } else if reuseIdentifier == "TYSCommonPersonalAddMoveBtnCell" { // 带移组的cell
            addCommonSubViews()
            addMoveBtn()
        } else { //个人
            personalCell()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension TYSCommonPersonalCell {
    
    private func addCommonSubViews() {
        userImgView = UIImageView()
        userImgView?.image = UIImage(named: "defaut_avatar")
        userImgView?.layer.masksToBounds = true
        userImgView?.layer.cornerRadius = 25
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(AdaptW(w: 23))
            make.size.equalTo(CGSize(width: 50, height: 50))
        })
        
        nameLabel = UILabel()
        nameLabel?.text = "投研社"
        nameLabel?.textColor = tys_middleDarkColor
        nameLabel?.font = SystemFont(fontSize: 18)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!).offset(AdaptH(h: -10))
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -85))
        })
        
        orgLabel = UILabel()
        orgLabel?.text = "测试测试测试测试测试测试测试测试测试"
        orgLabel?.textColor = tys_titleColor
        orgLabel?.font = SystemFont(fontSize: 14)
        contentView.addSubview(orgLabel!)
        orgLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!).offset(AdaptH(h: 10))
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -85))
        })
        
        addAttentionBtn = UIButton()
        addAttentionBtn?.setImage(UIImage(named: "default_follow_icon"), for: .normal)
        addAttentionBtn?.setImage(UIImage(named: "default_followed_icon"), for: .selected)
        contentView.addSubview(addAttentionBtn!)
        addAttentionBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.size.equalTo(CGSize(width: AdaptW(w: 60), height: AdaptH(h: 30)));
        })
    }
    
    private func addMoveBtn() {
        commonBtn = UIButton()
        commonBtn?.setImage(UIImage(named: "default_moveGroup_icon"), for: .normal)
        commonBtn?.setImage(UIImage(named: "default_moveGroup_icon"), for: .selected)
        contentView.addSubview(commonBtn!)
        commonBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -90))
            make.size.equalTo(CGSize(width: AdaptW(w: 60), height: AdaptH(h: 30)));
        })
        
        nameLabel?.snp.updateConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -160))
        })
        
        orgLabel?.snp.updateConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -160))
        })
    }
    
    private func personalCell() {
        addCommonSubViews()
        addAttentionBtn?.isHidden = true
        nameLabel?.snp.updateConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
        })
        
        orgLabel?.snp.updateConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
        })
    }
    
    
    
}
