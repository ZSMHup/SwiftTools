//
//  TYSRecReadDetailInputView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadDetailInputView: UIView {
    
    private var lineView: UIView?
    private var inputTextField: TextField?
    private var msgBtn: UIButton?
    private var collectionBtn: UIButton?
    private var likeBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TYSRecReadDetailInputView {
    private func addSubViews() {
        lineView = UIView()
        lineView?.backgroundColor = tys_lineColor
        addSubview(lineView!)
        lineView?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(0.5)
        })
        
        likeBtn = UIButton()
        likeBtn?.setImage(UIImage(named: "jiandu_dianzaned_icon-1"), for: .normal)
        likeBtn?.setImage(UIImage(named: "jiandu_dianzaned_icon"), for: .selected)
        addSubview(likeBtn!)
        likeBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp.right).offset(AdaptW(w: -15))
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        })
        
        collectionBtn = UIButton()
        collectionBtn?.setImage(UIImage(named: "jiandu_fav_icon"), for: .normal)
        collectionBtn?.setImage(UIImage(named: "jiandu_faved_icon"), for: .selected)
        addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo((likeBtn?.snp.left)!).offset(AdaptW(w: -24))
            make.centerY.equalTo((likeBtn?.snp.centerY)!)
            make.size.equalTo(CGSize(width: 20, height: 20))
        })
        
        msgBtn = UIButton()
        msgBtn?.setImage(UIImage(named: "jiandu_comment_icon"), for: .normal)
        msgBtn?.setImage(UIImage(named: "jiandu_comment_icon"), for: .highlighted)
        addSubview(msgBtn!)
        msgBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo((collectionBtn?.snp.left)!).offset(AdaptW(w: -24))
            make.centerY.equalTo((likeBtn?.snp.centerY)!)
            make.size.equalTo(CGSize(width: 20, height: 20))
        })
        
        inputTextField = TextField()
        inputTextField?.placeholder = "写评论"
        inputTextField?.tintColor = tys_inputTintColor
        inputTextField?.backgroundColor = tys_searchBackgroundColor
        inputTextField?.layer.cornerRadius = 1.0
        inputTextField?.font = SystemFont(fontSize: 16)
        addSubview(inputTextField!)
        inputTextField?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(AdaptW(w: 23))
            make.right.equalTo((msgBtn?.snp.left)!).offset(AdaptW(w: -26))
            make.height.equalTo(36)
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
