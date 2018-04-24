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
    private var authLabel: AYEdgeInsetsLabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        if reuseIdentifier == "TYSCommonPersonalCell" {
            addCommonSubViews()
        } else if reuseIdentifier == "TYSCommonPersonalAddMoveBtnCell" { // 带移组的cell
            addCommonSubViews()
            addMoveBtn()
        } else if reuseIdentifier == "TYSCommonPersonalCenterCell" { //个人中心
            personalCell()
            addAuthLabel()
        } else {
            personalCell()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: TYSPersonalModel) {
        if reuseIdentifier == "TYSCommonPersonalCell" {
            
        } else if reuseIdentifier == "TYSCommonPersonalAddMoveBtnCell" { // 带移组的cell
            
        } else if reuseIdentifier == "TYSCommonPersonalCenterCell" { //个人中心
            let url = URL(string: model.head_img ?? "")
            userImgView?.kf.setImage(with: url, placeholder: UIImage(named: "defaut_avatar"))
            nameLabel?.text = model.userName
            orgLabel?.text = model.identityName
            authLabel?.text = model.userAuthStatus
            
            authLabel?.snp.updateConstraints({ (make) in
                make.width.equalTo(AdaptW(w: ay_getWidth(string: (authLabel?.text)!, fontSize: 10, height: 20) + 10))
            })
        } else {
            let url = URL(string: model.head_img ?? "")
            userImgView?.kf.setImage(with: url, placeholder: UIImage(named: "defaut_avatar"))
            nameLabel?.text = model.userName
            orgLabel?.text = model.company_profile ?? ""
        }
    }

}

extension TYSCommonPersonalCell {
    
    private func addCommonSubViews() {
        userImgView = UIImageView()
//        let url = URL(string: TYSPersonalModel.manager.readPersonalData().head_img ?? "")
//        userImgView?.kf.setImage(with: url, placeholder: UIImage(named: "defaut_avatar"))
        userImgView?.layer.masksToBounds = true
        userImgView?.layer.cornerRadius = 25
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(AdaptW(w: 23))
            make.size.equalTo(CGSize(width: 50, height: 50))
        })
        
        nameLabel = UILabel()
//        nameLabel?.text = userName
        nameLabel?.textColor = tys_middleDarkColor
        nameLabel?.font = SystemFont(fontSize: 18)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!).offset(AdaptH(h: -10))
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -85))
        })
        
        orgLabel = UILabel()
//        orgLabel?.text = identityName
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
       
        nameLabel?.snp.removeConstraints()
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!).offset(AdaptH(h: -10))
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
        })
        
        orgLabel?.snp.removeConstraints()
        orgLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!).offset(AdaptH(h: 10))
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
        })
        
    }
    
    private func addAuthLabel() {
        authLabel = AYEdgeInsetsLabel()
        authLabel?.text = "未知状态"
        authLabel?.textColor = hexString("#E25039")
        authLabel?.font = SystemFont(fontSize: 10)
        authLabel?.layer.borderColor = hexString("#F8D7D1").cgColor
        authLabel?.layer.borderWidth = 0.5
        authLabel?.layer.cornerRadius = 1
        authLabel?.layer.masksToBounds = true
        authLabel?.setContentInset(contentInset: UIEdgeInsetsMake(5, 5, 5, 5))
        
        contentView.addSubview(authLabel!)
        authLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((nameLabel?.snp.centerY)!)
            make.left.equalTo((nameLabel?.snp.right)!).offset(8.0)
            make.height.equalTo(20)
            make.width.equalTo(AdaptW(w: ay_getWidth(string: (authLabel?.text)!, fontSize: 10, height: 20) + 5))
        })
    }
    
    
}
