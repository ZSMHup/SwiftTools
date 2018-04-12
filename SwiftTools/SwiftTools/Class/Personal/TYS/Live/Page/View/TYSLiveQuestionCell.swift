//
//  TYSLiveQuestionCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSLiveQuestionCell: UITableViewCell {

    var userImgView: UIImageView?
    var userName: UILabel?
    var timeLabel: UILabel?
    var questionLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: TYSQuestionModel) {
        let url = URL(string: model.head_img ?? "")
        userImgView?.kf.setImage(with: url, placeholder: UIImage(named: "defaut_avatar"))
        
        if model.is_anonymous == "1" {
            userName?.text = "匿名"
        } else {
            userName?.text = model.name
        }
        timeLabel?.text = formatDate(date: model.create_time ?? "2018-01-01 00:00:00")
        questionLabel?.text = model.questions
    }
    
}

extension TYSLiveQuestionCell {
    private func addSubViews() {
        userImgView = UIImageView()
        userImgView?.layer.cornerRadius = 20.0
        userImgView?.layer.masksToBounds = true
        contentView.addSubview(userImgView!)
        userImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 18))
            make.size.equalTo(CGSize(width: 40, height: 40))
        })
        
        userName = UILabel()
        userName?.textColor = tys_titleColor
        userName?.font = SystemFont(fontSize: 14)
        contentView.addSubview(userName!)
        userName?.snp.makeConstraints({ (make) in
            make.left.equalTo((userImgView?.snp.right)!).offset(AdaptW(w: 8))
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 18))
        })
        
        timeLabel = UILabel()
        timeLabel?.textColor = tys_lightColor
        timeLabel?.textAlignment = .right
        timeLabel?.font = SystemFont(fontSize: 14)
        contentView.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.centerY.equalTo((userName?.snp.centerY)!)
        })
        
        questionLabel = UILabel()
        questionLabel?.numberOfLines = 0
        questionLabel?.textColor = tys_middleDarkColor
        questionLabel?.font = SystemFont(fontSize: 16)
        contentView.addSubview(questionLabel!)
        questionLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((userName?.snp.left)!)
            make.top.equalTo((userName?.snp.bottom)!).offset(AdaptH(h: 5))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -5))
        })
    }
}
