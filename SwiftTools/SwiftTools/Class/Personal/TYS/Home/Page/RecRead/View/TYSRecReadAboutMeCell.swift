//
//  TYSRecReadAboutMeCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/2.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadAboutMeCell: UITableViewCell {
    
    private var contentLabel: UILabel?
    private var timeLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: TYSRecReadAboutMeModel) {
        contentLabel?.attributedText = getAttrContent(model: model)
        timeLabel?.text = formatDate(date: model.create_time ?? "")
    }
    
    func contentLabelClick(block: @escaping (String) -> ()) {
        contentLabel?.setTap(block: { (index, charAttributedString) in
            var ran: NSRange = NSRange(location: 0, length: 1)
            let link = charAttributedString.attribute(NSAttributedStringKey.link, at: 0, effectiveRange: &ran)
            block((link ?? "") as! String)
        })
    }
    
    private func getAttrContent(model: TYSRecReadAboutMeModel) -> NSMutableAttributedString {
        
        if model.content != nil {
            let contentArr = model.content?.components(separatedBy: "|")
            var userName = ""
            var userId = ""
            var read = ""
            var readId = ""
            
            if contentArr?.count == 5 {
                
                let attributedStrM: NSMutableAttributedString = NSMutableAttributedString()
                let userArr = (contentArr?[1] ?? "").components(separatedBy: ",")
                let readArr = (contentArr?[3] ?? "").components(separatedBy: ",")
                if userArr.count > 0 {
                    userName = "#\(userArr.first ?? "")#"
                    userId = userArr[1]
                }
                if readArr.count > 0 {
                    read = "#\(readArr.first ?? "")#"
                    readId = readArr[1]
                }
                
                contentLabelClick(block: { (link) in
                    if link == "user" {
                        printLog("用户: \(userId)")
                    } else if link == "read" {
                        printLog("荐读: \(readId)")
                        let detailVc = TYSRecReadDetailViewController()
                        detailVc.readTitle = read
                        detailVc.readId = readId
                        getCurrentController()?.navigationController?.pushViewController(detailVc, animated: true)
                    } else {
                        printLog("all")
                    }
                })
                
                let att1: NSAttributedString = NSAttributedString(string: contentArr?[0] ?? "", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: tys_middleDarkColor])
                
                let userNameAtt: NSAttributedString = NSAttributedString(string: userName, attributes:[

                    .link: "user",
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: hexString("5AA5DA"),
                    .underlineColor: UIColor.clear])
                
                let att2: NSAttributedString = NSAttributedString(string: contentArr?[2] ?? "", attributes: [
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: tys_middleDarkColor])
                
                let readAtt: NSAttributedString = NSAttributedString(string: read, attributes: [
                    .link: "read",
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: hexString("5AA5DA"),
                    .underlineColor: UIColor.clear
                    ])
                
                let att3: NSAttributedString = NSAttributedString(string: contentArr?[4] ?? "", attributes: [
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: tys_middleDarkColor])
                
                attributedStrM.append(att1)
                attributedStrM.append(userNameAtt)
                attributedStrM.append(att2)
                attributedStrM.append(readAtt)
                attributedStrM.append(att3)
                
                return attributedStrM
            } else {
                let attributedStrM: NSMutableAttributedString = NSMutableAttributedString()
                let readArr = (contentArr?[1] ?? "").components(separatedBy: ",")
                if readArr.count > 0 {
                    read = "#\(readArr.first ?? "")#"
                    readId = readArr[1]
                }
                
                contentLabelClick(block: { (link) in
                    
                    if link == "read" {
                        let detailVc = TYSRecReadDetailViewController()
                        detailVc.readTitle = read
                        detailVc.readId = readId
                        getCurrentController()?.navigationController?.pushViewController(detailVc, animated: true)
                    } else {
                        printLog("all")
                    }
                    
                })
                
                let att1: NSAttributedString = NSAttributedString(string: contentArr?[0] ?? "", attributes: [
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: tys_middleDarkColor])
                let readAtt: NSAttributedString = NSAttributedString(string: read, attributes: [
                    .link: "read",
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: hexString("5AA5DA"),
                    .underlineColor: UIColor.clear])
                let att3: NSAttributedString = NSAttributedString(string: contentArr?[2] ?? "", attributes: [
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: tys_middleDarkColor])
                
                attributedStrM.append(att1)
                attributedStrM.append(readAtt)
                attributedStrM.append(att3)
                
                return attributedStrM
            }
        } else {
            return NSMutableAttributedString()
        }
    }
}

extension TYSRecReadAboutMeCell {
    private func addSubViews() {
        contentLabel = UILabel()
        contentLabel?.textColor = tys_middleDarkColor
        contentLabel?.font = SystemFont(fontSize: 17)
        contentLabel?.numberOfLines = 0
        contentView.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(AdaptH(h: 10))
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.right.equalTo(contentView.snp.right).offset(AdaptW(w: -23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -30))
        })

        
        timeLabel = UILabel()
        timeLabel?.textColor = tys_lightColor
        timeLabel?.font = SystemFont(fontSize: 10)
        timeLabel?.textAlignment = .right
        contentView.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView.snp.left).offset(AdaptW(w: 23))
            make.bottom.equalTo(contentView.snp.bottom).offset(AdaptH(h: -5))
        })
    }
}
