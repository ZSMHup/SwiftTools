//
//  TextField.swift
//  TYS
//
//  Created by 张书孟 on 2017/12/5.
//  Copyright © 2017年 张书孟. All rights reserved.
//

import UIKit

typealias TextFieldHandler = (UITextField) -> Void

class TextField: UITextField {
    /** 能否被复制 默认为NO */
    var canBeCopied: Bool?
    /** 能否被粘贴 默认为NO */
    var canBePasted: Bool?
    /** 能否被剪切 默认为NO */
    var canBeCut: Bool?
    /** 能否被选择 默认为YES */
    var canBeSelected: Bool?
    /** 能否被全选 默认为NO */
    var canBeAllSelected: Bool?
    /** 最大限制文本长度, 默认不限制长度 */
    var maxLength: Int?
    
    private var changeHandler: TextFieldHandler?
    private var maxHandler: TextFieldHandler?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        maxHandler = nil
        changeHandler = nil
    }
}

extension TextField {
    private func initialize() {
        canBeCopied = false
        canBePasted = false
        canBeCut = false
        canBeSelected = false
        canBeAllSelected = false
        if maxLength == 0 || maxLength == NSNotFound {
            maxLength = LONG_MAX
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        let become = super.becomeFirstResponder()
        // 成为第一响应者时注册通知监听文本变化
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
        return become
    }
    
    override func resignFirstResponder() -> Bool {
        let resign = super.resignFirstResponder()
        // 注销第一响应者时移除文本变化的通知, 以免影响其它的`UITextField`对象.
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        return resign
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // 复制功能
        if action == #selector(copy(_:)) {
            if canBeCopied! {
                return true
            } else {
                return false
            }
        }
        
        // 粘贴功能
        if action == #selector(paste(_:)) {
            if canBePasted! {
                return true
            } else {
                return false
            }
        }
        
        // 剪切功能
        if action == #selector(cut(_:)) {
            if canBeCut! {
                return true
            } else {
                return false
            }
        }
        
        // 选择功能
        if action == #selector(select(_:)) {
            if canBeSelected! {
                return true
            } else {
                return false
            }
        }
        
        // 全选功能
        if action == #selector(selectAll(_:)) {
            if canBeAllSelected! {
                return true
            } else {
                return false
            }
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    /** 设定文本改变Block回调 */
    public func addTextDidChangeHandler(tempChangeHandler: @escaping TextFieldHandler) {
        changeHandler = tempChangeHandler
    }
    
    /** 设定文本达到最大长度的回调 */
    public func addTextLengthDidMaxHandler(tempMaxHandler: @escaping TextFieldHandler) {
        maxHandler = tempMaxHandler
    }
    
    // MARK: 通知
    @objc private func textFieldDidChange(notification: Notification) {
        
        if (notification.object as! UITextField) != self {
            return
        }
        
        // 禁止第一个字符输入空格或者换行
        if text?.count == 1 {
            if text == " " || text == "\n" {
                text = ""
            }
        }
        
        // 只有当maxLength字段的值不为无穷大整型也不为0时才计算限制字符数.
        if maxLength != LONG_MAX && maxLength != 0 && (text?.count)! > Int(0)  {
            if (markedTextRange == nil) && (text?.count)! > maxLength! {
                if maxHandler != nil {
                    maxHandler!(self)
                }
                let index = text?.index((text?.startIndex)!, offsetBy: maxLength!)
                text = String(text![..<index!])
            }
        }
        if changeHandler != nil {
            changeHandler!(self)
        }
    }

}


