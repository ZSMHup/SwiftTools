//
//  AYPageMenu.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

/////////////////////////////////////// AYPageMenu /////////////////////////////////////

protocol AYPageMenuDelegate {
    func didSelectedItemChange(pageMen: AYPageMenu, selectedIndex: Int)
}

class AYPageMenu: UIView {
    
    private var _items: [String]?
    private var selectedBtn: UIButton?
    private var indexView: UIView?
    private var lineView: UIView?
    var menuBtn: UIButton?
    var isTimer = true
    
    var selectedIndex: Int = 0 {
        didSet {
            changeMenu(index: selectedIndex)
        }
    }
    
    var delegate: AYPageMenuDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       print("deinit: \(self.classForCoder)")
    }
    
    /// 创建 AYPageMenu
    ///
    /// - Parameter items: 标题（数组[String]）
    /// - Returns: self
    public func pageMenu(items: [String]) -> AYPageMenu {
        let pageMenu = AYPageMenu()
        pageMenu.frame = frame
        pageMenu._items = items
        pageMenu.addSubViews()
        return pageMenu
    }
    
    // MARK: 初始化
    private func addSubViews() {
        indexView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 2, width: 50, height: 1))
        indexView?.backgroundColor = UIColor.red
        self.addSubview(indexView!)
        
        for i in 0..<(_items?.count)! {
            menuBtn = UIButton(frame: CGRect(x: 10 + 60 * CGFloat(i) , y: 0, width: 60, height: self.frame.size.height - 1))
            
            menuBtn?.setTitleColor(UIColor.gray, for: .normal)
            menuBtn?.setTitleColor(UIColor.red, for: .selected)
            menuBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
            menuBtn?.setTitle(_items?[i], for: .normal)
            menuBtn?.tag = 1000 + i
            menuBtn?.addTarget(self, action: #selector(menuBtnClick(sender:)), for: .touchUpInside)
            self.addSubview(menuBtn!)
            if i == 0 {
                menuBtnClick(sender: menuBtn!)
            }
        }
        
        lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 1, width: kScreenH, height: 1))
        lineView?.backgroundColor = RGBA(0, 0, 0, 0.1)
        self.addSubview(lineView!)
    }
    
    private func changeMenu(index: Int) {
        menuBtn = self.viewWithTag(1000 + index) as? UIButton
        for i in 0..<(_items?.count)! {
            selectedBtn = self.viewWithTag(1000 + i) as? UIButton
            if menuBtn == selectedBtn {
                selectedBtn?.setTitleColor(UIColor.red, for: .normal)
                UIView.animate(withDuration: 0.25, animations: {[weak self] in
                    self?.indexView?.center.x = (self?.selectedBtn?.center.x)!
                })
            } else {
                selectedBtn?.setTitleColor(UIColor.gray, for: .normal)
            }
        }
        menuBtn = selectedBtn
    }
    
    // MARK: event response
    @objc func menuBtnClick(sender: UIButton?) {
        
        var sender = sender
        for i in 0..<(_items?.count)! {
            selectedBtn = self.viewWithTag(1000 + i) as? UIButton
            if sender == selectedBtn {
                selectedBtn?.setTitleColor(UIColor.red, for: .normal)
                UIView.animate(withDuration: 0.25, animations: {[weak self] in
                    self?.indexView?.center.x = (self?.selectedBtn?.center.x)!
                })
                delegate?.didSelectedItemChange(pageMen: self, selectedIndex: i)
                if isTimer {
                    selectedBtn?.buttonTimer(sec: 1.0)
                }
                
            } else {
                selectedBtn?.setTitleColor(UIColor.gray, for: .normal)
                if isTimer {
                    selectedBtn?.buttonTimer(sec: 1.0)
                }
            }
        }
        sender = selectedBtn
    }
}

/////////////////////////////////////// AYSwitchVCContentView /////////////////////////////////////

class AYSwitchVCContentView: UIView {
    private var _items: [String]?
    private var _controllers : [String]?
    private var _didShowControllers = [UIViewController]()
    private lazy var pageMenu: AYPageMenu = {
        let tempPageMenu = AYPageMenu(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30)).pageMenu(items: _items!)
        tempPageMenu.delegate = self
        return tempPageMenu
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let tempContentScrollView = UIScrollView()
        tempContentScrollView.isPagingEnabled = true
        tempContentScrollView.showsHorizontalScrollIndicator = false
        tempContentScrollView.showsVerticalScrollIndicator = false
        tempContentScrollView.delegate = self
        return tempContentScrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit: \(self.classForCoder)")
    }
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - items: 标题(数组[String])
    ///   - controllers: 控制器(数组[String])
    public func initWithItems(items: [String], controllers: [String]) -> AYSwitchVCContentView {
        let switchVCContentView = AYSwitchVCContentView()
        switchVCContentView.frame = frame
        switchVCContentView._items = items
        switchVCContentView._controllers = controllers

        switchVCContentView.addSubViews()
        return switchVCContentView
    }
    
    // MARK: 添加子控件
    private func addSubViews() {
        for vc in _controllers! {
            let cla = NSClassFromString(getAPPName() + "." + vc) as! UIViewController.Type
            let willShowVC = cla.init()
            _didShowControllers.append(willShowVC)
        }
        
        self.addSubview(pageMenu)
        
        contentScrollView.frame = CGRect(x: 0, y: pageMenu.frame.size.height, width: kScreenW, height: kScreenH - pageMenu.frame.size.height)
        contentScrollView.contentSize = CGSize(width: kScreenW * CGFloat((_controllers?.count)!), height: 0)
        self.addSubview(contentScrollView)
        scrollViewDidEndScrollingAnimation(contentScrollView)
    }
}

// MARK: UIScrollViewDelegate
extension AYSwitchVCContentView: UIScrollViewDelegate, AYPageMenuDelegate{

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let height = scrollView.frame.size.height
        let offsetX = scrollView.contentOffset.x
        
        let index: Int = Int(offsetX / width)
        
        pageMenu.selectedIndex = index
        
        if !(_didShowControllers.isEmpty) {
            let willShowVc = _didShowControllers[index]
            if willShowVc.isViewLoaded {
                pageMenu.isTimer = false
                return
            }
            willShowVc.view.frame = CGRect(x: offsetX, y: 0, width: width, height: height)
            scrollView.addSubview(willShowVc.view)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func didSelectedItemChange(pageMen: AYPageMenu, selectedIndex: Int) {
        var offset = contentScrollView.contentOffset
        offset.x = CGFloat(selectedIndex) * contentScrollView.frame.size.width
        contentScrollView.setContentOffset(offset, animated: true)
    }
}
