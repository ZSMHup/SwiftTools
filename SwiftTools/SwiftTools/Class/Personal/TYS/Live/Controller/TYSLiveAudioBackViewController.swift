//
//  TYSLiveAudioBackViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let kHeaderViewH: CGFloat = (kScreenW - 23.0 * 2) / 4 * 3
let kPageMenuH: CGFloat = 30
let kScrollViewBeginTopInset: CGFloat = kHeaderViewH + kPageMenuH

class TYSLiveAudioBackViewController: BaseViewController {
    
    private var lastPageMenuY: CGFloat?
    private var lastPoint: CGPoint = CGPoint.zero
    var liveListModel: TYSLiveCommonModel?
    
    var vodplayer: VodPlayer?
    var voddownloader: VodDownLoader?
    var VodParam: VodParam?
    
    var isVideoFinished: Bool?
    var isDragging: Bool?
    var isPlayer: Bool?
    var isDownloadClick: Bool?
    var videoRestartValue: Float?
    var downloadItem: downItem?
    
    private lazy var scrollView: UIScrollView = {
       let tempScrollView = UIScrollView(frame: view.bounds)
        tempScrollView.delegate = self
        tempScrollView.isPagingEnabled = true
        tempScrollView.contentSize = CGSize(width: kScreenW * 4, height: 0)
        tempScrollView.showsVerticalScrollIndicator = false
        tempScrollView.showsHorizontalScrollIndicator = false
        return tempScrollView
    }()
    
    private lazy var headerView: TYSLiveAudioBackHeaderView = {
        
        let tempHeaderView = TYSLiveAudioBackHeaderView.createHeaderView(frame: CGRect(x: 0, y: kScrollViewBeginTopInset, width: kScreenW, height: kHeaderViewH), image: (liveListModel?.live_img_path)!)
        tempHeaderView.delegate = self
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(pan:)))
        tempHeaderView.addGestureRecognizer(pan)
        return tempHeaderView
    }()
    
    private lazy var pageMenu: AYPageMenu = {
        let items = ["互动","文档","提问", "资料"]
       let tempPageMenu = AYPageMenu(frame: CGRect(x: 0, y: kHeaderViewH + kNavigationBarHeight, width: kScreenW, height: kPageMenuH)).pageMenu(items: items)
        tempPageMenu.delegate = self
        tempPageMenu.isTimer = false
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(pan:)))
        tempPageMenu.addGestureRecognizer(pan)
        return tempPageMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        lastPageMenuY = kHeaderViewH

        addSubviews()

        NotificationCenter.default.addObserver(self, selector: #selector(subScrollViewDidScroll(notification:)), name: ChildScrollViewDidScrollNSNotification, object: nil)
    }
    
    private func follow(scrollingScrollView: UIScrollView, distanceY: CGFloat) {

        for i in 0..<childViewControllers.count {
            let baseVc: AYBaseViewController = childViewControllers[i] as! AYBaseViewController
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
        let baseVc: AYBaseViewController = childViewControllers[pageMenu.selectedIndex] as! AYBaseViewController

        if (scrollingScrollView === baseVc.baseScrollView && baseVc.isFirstViewLoaded == false) {
            var pageMenuFrame = pageMenu.frame
            if pageMenuFrame.origin.y >= kNavigationBarHeight {
                // 往上移
                if offsetDifference > 0 && scrollingScrollView.contentOffset.y + kScrollViewBeginTopInset + kNavigationBarHeight > 0 {
                    if ((scrollingScrollView.contentOffset.y + kScrollViewBeginTopInset + kNavigationBarHeight+pageMenu.frame.origin.y) >= kHeaderViewH) || scrollingScrollView.contentOffset.y + kScrollViewBeginTopInset + kNavigationBarHeight < 0 {
                        pageMenuFrame.origin.y += -offsetDifference
                        if (pageMenuFrame.origin.y <= kNavigationBarHeight) {
                            pageMenuFrame.origin.y = kNavigationBarHeight;
                        }
                    }
                } else {
                    // 往下移
                    if ((scrollingScrollView.contentOffset.y + kScrollViewBeginTopInset + pageMenu.frame.origin.y) < kHeaderViewH) {
                        pageMenuFrame.origin.y = -scrollingScrollView.contentOffset.y - kPageMenuH
                        if (pageMenuFrame.origin.y >= kHeaderViewH + kNavigationBarHeight) {
                            pageMenuFrame.origin.y = kHeaderViewH + kNavigationBarHeight;
                        }
                    }
                }
            }
            pageMenu.frame = pageMenuFrame

            var headerFrame = headerView.frame
            headerFrame.origin.y = pageMenu.frame.origin.y - kHeaderViewH;
            headerView.frame = headerFrame;

            // 记录悬浮菜单的y值改变量
            distanceY = pageMenuFrame.origin.y - lastPageMenuY!
            lastPageMenuY = pageMenu.frame.origin.y;
            follow(scrollingScrollView: scrollingScrollView, distanceY: distanceY)
        }
        baseVc.isFirstViewLoaded = false
    }

    @objc private func panGestureRecognizerAction(pan: UIPanGestureRecognizer) {
        if pan.state == .began {

        } else if pan.state == .changed {
            let currenrPoint: CGPoint = pan.translation(in: pan.view)
            let distanceY: CGFloat = currenrPoint.y - lastPoint.y
            lastPoint = currenrPoint
            let baseVc: AYBaseViewController = childViewControllers[pageMenu.selectedIndex] as! AYBaseViewController
            var offset = baseVc.baseScrollView?.contentOffset;
            let height: CGFloat = scrollView.frame.size.height
            offset?.y += -distanceY
            let distanceFromBottom: CGFloat = scrollView.contentSize.height - height
            if (offset?.y)! <= (-kScrollViewBeginTopInset - kNavigationBarHeight) {
                offset?.y = -kScrollViewBeginTopInset - kNavigationBarHeight
            } else if distanceFromBottom - (offset?.y)! <= 0 {
//                let offsetY = (offset?.y)! + distanceY
//                offset?.y = offsetY
            }
            
            baseVc.baseScrollView?.contentOffset = offset!
        } else {
            pan.setTranslation(CGPoint.zero, in: pan.view)
            lastPoint = CGPoint.zero
        }
    }
    
}

extension TYSLiveAudioBackViewController: UIScrollViewDelegate, AYPageMenuDelegate, TYSLiveAudioBackHeaderViewDelegate {

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

        let willShowVc: AYBaseViewController = childViewControllers[index] as! AYBaseViewController
        
        if willShowVc.isViewLoaded {
            if (willShowVc.baseScrollView?.contentSize.height)! < kScreenH {
                willShowVc.baseScrollView?.setContentOffset(CGPoint(x: 0, y: -kScrollViewBeginTopInset-kNavigationBarHeight), animated: true)
            }
            return
        }
        willShowVc.isFirstViewLoaded = true
        willShowVc.view.frame = CGRect(x: offsetX, y: 0, width: width, height: height)
        scrollView.addSubview(willShowVc.view)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    // TYSLiveAudioBackHeaderViewDelegate
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didPlay: UIButton) {
        print("开始播放")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didPause: UIButton) {
        print("暂停播放")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickBack: UIButton) {
        print("快退")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickFoward: UIButton) {
        print("快进")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickDownload: UIButton) {
        print("下载")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoHold: UISlider) {
        print("按下")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoSeek: UISlider) {
        print("滑动")
    }
    
}


