//
//  TYSRecReadContentCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadContentCell: UITableViewCell {
    
    private var userImgView: UIImageView?
    private var nameLabel: UILabel?
    private var timeLabel: UILabel?
    private var contentLabel: UILabel?
    private var moreBtn: UIButton?
    private var msgBtn: UIButton?
    private var collectionBtn: UIButton?
    private var likeBtn: UIButton?
    private var cancelBtn: UIButton?
    
    private var recBgView: UIView?
    private var recUserImgView: UIImageView?
    private var recNameLabel: UILabel?
    private var recContentLabel: UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == "TYSRecReadContentCell" {
            addSubViews()
            addCommonSubViews()
        } else {
            addSubViews()
            addRecSubViews()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TYSRecReadContentCell {
    private func addSubViews() {
        userImgView = UIImageView()
        userImgView?.image = UIImage(named: "defaut_avatar")
        userImgView?.layer.masksToBounds = true
        userImgView?.layer.cornerRadius = 16.0 / 2
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23));
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 14));
            make.size.equalTo(CGSize(width: 16.0, height: 16.0));
        })
        
        nameLabel = UILabel()
        nameLabel?.text = "投研社"
        nameLabel?.textColor = tys_titleColor
        nameLabel?.font = SystemFont(fontSize: 12)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!)
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
            make.width.equalTo(AdaptW(w: 150))
        })
        
        timeLabel = UILabel()
        timeLabel?.text = "2018-04-02"
        timeLabel?.textColor = tys_lightColor
        timeLabel?.font = SystemFont(fontSize: 10)
        timeLabel?.textAlignment = .right
        contentView.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!)
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
        })
        
        
        msgBtn = UIButton()
        msgBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        msgBtn?.setTitleColor(tys_lightColor, for: .normal)
        msgBtn?.setTitle("10000", for: .normal)
        msgBtn?.setImage(UIImage(named: "jiandu_pinglun_little"), for: .normal)
        msgBtn?.setImage(UIImage(named: "jiandu_pinglun_little"), for: .highlighted)
        msgBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        contentView.addSubview(msgBtn!)
        msgBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -12))
        })
        
        collectionBtn = UIButton()
        collectionBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        collectionBtn?.setTitleColor(tys_lightColor, for: .normal)
        collectionBtn?.setTitle("10000", for: .normal)
        collectionBtn?.setImage(UIImage(named: "jiandu_shoucang_little"), for: .normal)
        collectionBtn?.setImage(UIImage(named: "jiandu_shoucang_little"), for: .highlighted)
        collectionBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        contentView.addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((msgBtn?.snp.right)!).offset(AdaptW(w: 23))
            make.centerY.equalTo((msgBtn?.snp.centerY)!)
        })
        
        likeBtn = UIButton()
        likeBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        likeBtn?.setTitleColor(tys_lightColor, for: .normal)
        likeBtn?.setTitle("10000", for: .normal)
        likeBtn?.setImage(UIImage(named: "jiandu_zan_little"), for: .normal)
        likeBtn?.setImage(UIImage(named: "jiandu_zan_little"), for: .highlighted)
        likeBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        contentView.addSubview(likeBtn!)
        likeBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((collectionBtn?.snp.right)!).offset(AdaptW(w: 23))
            make.centerY.equalTo((msgBtn?.snp.centerY)!)
        })
        
        cancelBtn = UIButton()
        cancelBtn?.setImage(UIImage(named: "jiandu_guanbi_little"), for: .normal)
        cancelBtn?.setImage(UIImage(named: "jiandu_guanbi_little"), for: .highlighted)
        cancelBtn?.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        contentView.addSubview(cancelBtn!)
        cancelBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.centerY.equalTo((msgBtn?.snp.centerY)!)
        })
    }
    
    private func addCommonSubViews() {
        contentLabel = UILabel()
        contentLabel?.text = "万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长"
        contentLabel?.textColor = tys_middleDarkColor
        contentLabel?.font = SystemFont(fontSize: 17)
        contentLabel?.numberOfLines = 0
        contentView.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 35))
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -40))
        })
        /*
         moreBtn = UIButton()
         moreBtn?.titleLabel?.font = SystemFont(fontSize: 14)
         moreBtn?.setTitleColor(hexString("#5AA5DA"), for: .normal)
         moreBtn?.setTitle("更多", for: .normal)
         contentView.addSubview(moreBtn!)
         moreBtn?.snp.makeConstraints({ (make) in
         make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
         make.top.equalTo((contentLabel?.snp.bottom)!).offset(AdaptH(h: 8))
         make.height.equalTo(20)
         })
         */
    }
    
    private func addRecSubViews() {
        recBgView = UIView()
        recBgView?.backgroundColor = hexString("#F9F9F9")
        contentView.addSubview(recBgView!)
        recBgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 35))
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -40))
        })
        
        recUserImgView = UIImageView()
        recUserImgView?.image = UIImage(named: "defaut_avatar")
        recUserImgView?.layer.masksToBounds = true
        recUserImgView?.layer.cornerRadius = 16.0 / 2
        recBgView?.addSubview(recUserImgView!)
        recUserImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo((recBgView?.snp.left)!).offset(AdaptW(w: 5));
            make.top.equalTo((recBgView?.snp.top)!).offset(AdaptH(h: 5));
            make.size.equalTo(CGSize(width: 16.0, height: 16.0));
        })
        
        recNameLabel = UILabel()
        recNameLabel?.text = "投研社"
        recNameLabel?.textColor = tys_titleColor
        recNameLabel?.font = SystemFont(fontSize: 12)
        recBgView?.addSubview(recNameLabel!)
        recNameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((recUserImgView?.snp.centerY)!)
            make.left.equalTo((recUserImgView?.snp.right)!).offset(8.0)
            make.width.equalTo(AdaptW(w: 150))
        })
        
        recContentLabel = UILabel()
        recContentLabel?.text = "万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长万物智能化升级使能者，重研发扩产能业绩快速增长"
        recContentLabel?.textColor = tys_middleDarkColor
        recContentLabel?.font = SystemFont(fontSize: 17)
        recContentLabel?.numberOfLines = 0
        recBgView?.addSubview(recContentLabel!)
        recContentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((recBgView?.snp.top)!).offset(AdaptH(h: 25))
            make.left.equalTo((recBgView?.snp.left)!).offset(AdaptW(w: 5))
            make.right.equalTo((recBgView?.snp.right)!).offset(AdaptW(w: -5))
            make.bottom.equalTo((recBgView?.snp.bottom)!).offset(AdaptH(h: -5))
        })
        
    }
}

extension TYSRecReadContentCell {
    @objc private func cancelBtnClick() {
        
    }
}
