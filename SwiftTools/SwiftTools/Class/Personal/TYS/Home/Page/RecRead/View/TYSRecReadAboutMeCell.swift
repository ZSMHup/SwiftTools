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
    
    func contentLabelClick(block: @escaping (Int, String) -> ()) {
        contentLabel?.setTap(block: { (index, charAttributedString) in
            
//            let range: NSRangePointer = NSRange(location: index, length: 1)
            
//            let link = charAttributedString.attributes(at: index, effectiveRange: range)
            printLog(link)
            block(index, charAttributedString.string)
        })
    }
    
    private func getAttrContent(model: TYSRecReadAboutMeModel) -> NSMutableAttributedString {
        
        if model.content != nil {
            let contentArr = model.content?.components(separatedBy: "|")
            var userName = ""
            var read = ""
            if contentArr?.count == 5 {
                
                let attributedStrM: NSMutableAttributedString = NSMutableAttributedString()
                let userArr = (contentArr?[1] ?? "").components(separatedBy: ",")
                let readArr = (contentArr?[3] ?? "").components(separatedBy: ",")
                if userArr.count > 0 {
                    userName = "#\(userArr.first ?? "")#"
                }
                if readArr.count > 0 {
                    read = "#\(readArr.first ?? "")#"
                }
                
                contentLabelClick(block: { (index, selectString) in
                    
                    if userName.contains(selectString) {
                        
                        printLog("用户: \(selectString)")
                        
                    } else if read.contains(selectString) {
                        
                        printLog("荐读: \(selectString)")
                        
                    } else {
                        printLog("all")
                    }
                    
                })
                
                let att1: NSAttributedString = NSAttributedString(string: contentArr?[0] ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: tys_middleDarkColor])
                let userNameAtt: NSAttributedString = NSAttributedString(string: userName, attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: hexString("5AA5DA"), NSAttributedStringKey.link: "user"])
                
                let att2: NSAttributedString = NSAttributedString(string: contentArr?[2] ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: tys_middleDarkColor])
                let readAtt: NSAttributedString = NSAttributedString(string: read, attributes: [NSAttributedStringKey.link: "read",NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: hexString("5AA5DA")])
                let att3: NSAttributedString = NSAttributedString(string: contentArr?[4] ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: tys_middleDarkColor])
                
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
                }
                
                contentLabelClick(block: { (index, selectString) in
                    
                    if read.contains(selectString) {
                        
                        printLog("荐读: \(selectString)")
                        
                    } else {
                        printLog("all")
                    }
                    
                })
                
                let att1: NSAttributedString = NSAttributedString(string: contentArr?[0] ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: tys_middleDarkColor])
                let readAtt: NSAttributedString = NSAttributedString(string: read, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: hexString("5AA5DA")])
                let att3: NSAttributedString = NSAttributedString(string: contentArr?[2] ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: tys_middleDarkColor])
                
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
