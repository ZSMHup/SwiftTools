//
//  TYSRecReadDetailHeaderView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadDetailHeaderView: UIView {

    private var titleLabel: UILabel?
    private var userImgView: UIImageView?
    private var nameLabel: UILabel?
    private var timeLabel: UILabel?
    private var browseBtn: UIButton?
    private var msgBtn: UIButton?
    private var collectionBtn: UIButton?
    private var likeBtn: UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: TYSRecReadDetailModel) {
        titleLabel?.text = model.title
        let url = URL(string: model.head_img ?? "")
        userImgView?.kf.setImage(with: url, placeholder: UIImage(named: "defaut_avatar"))
        nameLabel?.text = model.name ?? "暂无数据"
        timeLabel?.text = formatDate(date: model.create_time ?? "2018-01-01 00:00:00")
        browseBtn?.setTitle(model.browse_count ?? "0", for: .normal)
        msgBtn?.setTitle(model.msg_count ?? "0", for: .normal)
        collectionBtn?.setTitle(model.collection_count ?? "0", for: .normal)
        likeBtn?.setTitle(model.like_count ?? "0", for: .normal)
    }
    
}

extension TYSRecReadDetailHeaderView {
    private func addSubViews() {
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 3
        titleLabel?.font = SystemFont(fontSize: 20)
        addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(AdaptW(w: 10))
            make.left.equalTo(self.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(self.snp.right).offset(AdaptW(w: -23))
        })
        
        userImgView = UIImageView()
        userImgView?.layer.masksToBounds = true
        userImgView?.layer.cornerRadius = 18.0 / 2
        addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(AdaptW(w: 23))
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(AdaptH(h: 14));
            make.size.equalTo(CGSize(width: 18.0, height: 18.0));
        })
        
        nameLabel = UILabel()
        nameLabel?.textColor = hexString("#5AA5DA")
        nameLabel?.font = SystemFont(fontSize: 16)
        addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!)
            make.left.equalTo((userImgView?.snp.right)!).offset(8.0)
        })
        
        timeLabel = UILabel()
        timeLabel?.textColor = tys_lightColor
        timeLabel?.font = SystemFont(fontSize: 12)
        timeLabel?.textAlignment = .right
        addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((userImgView?.snp.centerY)!)
            make.right.equalTo(self.snp.right).offset(AdaptW(w: -23))
        })
        
        browseBtn = UIButton()
        browseBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        browseBtn?.setTitleColor(tys_lightColor, for: .normal)
        browseBtn?.setImage(UIImage(named: "jiandu_liulanliang"), for: .normal)
        browseBtn?.setImage(UIImage(named: "jiandu_liulanliang"), for: .highlighted)
        browseBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        addSubview(browseBtn!)
        browseBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(AdaptW(w: 23))
            make.bottom.equalTo(self.snp.bottom).offset(AdaptH(h: -10))
        })
        
        msgBtn = UIButton()
        msgBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        msgBtn?.setTitleColor(tys_lightColor, for: .normal)
        msgBtn?.setImage(UIImage(named: "jiandu_pinglun_little"), for: .normal)
        msgBtn?.setImage(UIImage(named: "jiandu_pinglun_little"), for: .highlighted)
        msgBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        addSubview(msgBtn!)
        msgBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((browseBtn?.snp.right)!).offset(AdaptW(w: 24))
            make.centerY.equalTo((browseBtn?.snp.centerY)!)
        })
        
        collectionBtn = UIButton()
        collectionBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        collectionBtn?.setTitleColor(tys_lightColor, for: .normal)
        collectionBtn?.setImage(UIImage(named: "jiandu_shoucang_little"), for: .normal)
        collectionBtn?.setImage(UIImage(named: "jiandu_shoucang_little"), for: .highlighted)
        collectionBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((msgBtn?.snp.right)!).offset(AdaptW(w: 24))
            make.centerY.equalTo((browseBtn?.snp.centerY)!)
        })
        
        likeBtn = UIButton()
        likeBtn?.titleLabel?.font = SystemFont(fontSize: 12)
        likeBtn?.setTitleColor(tys_lightColor, for: .normal)
        likeBtn?.setImage(UIImage(named: "jiandu_zan_little"), for: .normal)
        likeBtn?.setImage(UIImage(named: "jiandu_zan_little"), for: .highlighted)
        likeBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        addSubview(likeBtn!)
        likeBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((collectionBtn?.snp.right)!).offset(AdaptW(w: 24))
            make.centerY.equalTo((browseBtn?.snp.centerY)!)
        })
    }
}
