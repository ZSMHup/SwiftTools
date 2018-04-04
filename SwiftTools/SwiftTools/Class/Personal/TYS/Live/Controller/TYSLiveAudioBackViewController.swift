//
//  TYSLiveAudioBackViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let ChildScrollViewDidScrollNSNotification: NSNotification.Name = NSNotification.Name(rawValue: "ChildScrollViewDidScrollNSNotification")
let ChildScrollViewRefreshStateNSNotification: NSNotification.Name = NSNotification.Name(rawValue: "ChildScrollViewRefreshStateNSNotification")

class TYSLiveAudioBackViewController: BaseViewController {
    
    private lazy var scrollView: UIScrollView = {
       let tempScrollView = UIScrollView(frame: view.bounds)
        tempScrollView.delegate = self
        tempScrollView.isPagingEnabled = true
        tempScrollView.contentSize = CGSize(width: kScreenW * 4, height: 0)
        
        return tempScrollView
    }()
    
    private lazy var headerView: TYSLiveAudioBackHeaderView = {
       let tempHeaderView = TYSLiveAudioBackHeaderView(frame: CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: 200))
        tempHeaderView.backgroundColor = UIColor.orange
        
        return tempHeaderView
    }()
    
    private lazy var pageMenu: AYPageMenu = {
        let items = ["互动","文档","提问", "资料"]
       let tempPageMenu = AYPageMenu(frame: CGRect(x: 0, y: 200 + kNavigationBarHeight, width: kScreenW, height: 30)).pageMenu(items: items)
        tempPageMenu.delegate = self
        tempPageMenu.isTimer = false
        return tempPageMenu
    }()
    
    var lastPageMenuY: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        lastPageMenuY = 200
        
        addSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(subScrollViewDidScroll(notification:)), name: ChildScrollViewDidScrollNSNotification, object: nil)
        
        
    }
    
    private func follow(scrollingScrollView: UIScrollView, distanceY: CGFloat) {
        //        var baseVc: BaseViewController?
        
        for i in 0..<childViewControllers.count {
            let baseVc: BaseViewController = childViewControllers[i] as! BaseViewController
            if baseVc.baseScrollView === scrollingScrollView {
                continue
            } else {
                var contentOffSet = baseVc.baseScrollView?.contentOffset
                contentOffSet?.y += -distanceY
                baseVc.baseScrollView?.contentOffset = contentOffSet!
                
            }
        }
        
    }
}

extension TYSLiveAudioBackViewController {
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(headerView)
        view.addSubview(pageMenu)
        self.addChildViewController(TYSLiveChatViewController())
        self.addChildViewController(TYSLiveSyncViewController())
        self.addChildViewController(TYSLiveQuestionViewController())
        self.addChildViewController(TYSLiveFileViewController())
        
        scrollView.addSubview(self.childViewControllers[0].view)
    }
    
}

extension TYSLiveAudioBackViewController {
    @objc func subScrollViewDidScroll(notification: NSNotification) {
        // 取出当前正在滑动的tableView
        let scrollingScrollView: UIScrollView = notification.userInfo!["scrollingScrollView"] as! UIScrollView
        let offsetDifference: CGFloat = notification.userInfo!["offsetDifference"] as! CGFloat
        
        var distanceY: CGFloat = 0
        // 取出的scrollingScrollView并非是唯一的，当有多个子控制器上的scrollView同时滑动时都会发出通知来到这个方法，所以要过滤
        let baseVc: BaseViewController = childViewControllers[pageMenu.selectedIndex] as! BaseViewController
        
        if (scrollingScrollView === baseVc.baseScrollView) {
            var pageMenuFrame = pageMenu.frame
            if pageMenuFrame.origin.y >= kNavigationBarHeight {
                // 往上移
                if offsetDifference > 0 && scrollingScrollView.contentOffset.y+230+kNavigationBarHeight > 0 {
                    if ((scrollingScrollView.contentOffset.y+230+kNavigationBarHeight+pageMenu.frame.origin.y)>=200) || scrollingScrollView.contentOffset.y+230+kNavigationBarHeight < 0 {
                        // 悬浮菜单的y值等于当前正在滑动且显示在屏幕范围内的的scrollView的contentOffset.y的改变量(这是最难的点)
                        pageMenuFrame.origin.y += -offsetDifference
                        if (pageMenuFrame.origin.y <= kNavigationBarHeight) {
                            pageMenuFrame.origin.y = kNavigationBarHeight;
                        }
                    }
                } else {
                    // 往下移
                    if ((scrollingScrollView.contentOffset.y+230+pageMenu.frame.origin.y)<200) {
                        pageMenuFrame.origin.y = -scrollingScrollView.contentOffset.y-30
                        print(pageMenuFrame.origin.y)
                        if (pageMenuFrame.origin.y >= 200+kNavigationBarHeight) {
                            pageMenuFrame.origin.y = 200+kNavigationBarHeight;
                        }
                    }
                }
            }
            pageMenu.frame = pageMenuFrame
            
            var headerFrame = headerView.frame
            headerFrame.origin.y = pageMenu.frame.origin.y-200;
            headerView.frame = headerFrame;
            
            // 记录悬浮菜单的y值改变量
            distanceY = pageMenuFrame.origin.y - lastPageMenuY!
            lastPageMenuY = pageMenu.frame.origin.y;
            
            follow(scrollingScrollView: scrollingScrollView, distanceY: distanceY)
        }
    }
    
    
    
}

extension TYSLiveAudioBackViewController: UIScrollViewDelegate, AYPageMenuDelegate {
    
    func didSelectedItemChange(pageMen: AYPageMenu, selectedIndex: Int) {
        var offset = scrollView.contentOffset
        offset.x = CGFloat(selectedIndex) * scrollView.frame.size.width
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let height = scrollView.frame.size.height
        let offsetX = scrollView.contentOffset.x
        
        let index: Int = Int(offsetX / width)
        
        pageMenu.selectedIndex = index
        
        let willShowVc = childViewControllers[index]
        if willShowVc.isViewLoaded {
            return
        }
        willShowVc.view.frame = CGRect(x: offsetX, y: 0, width: width, height: height)
        scrollView.addSubview(willShowVc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
}


