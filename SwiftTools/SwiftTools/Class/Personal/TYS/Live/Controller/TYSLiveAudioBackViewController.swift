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
    var liveDetailModel = TYSLiveDetailModel()
    var joinLiveModel = TYSLiveJoinLiveModel()
    
    var vodplayer: VodPlayer?
    var vodParam: VodParam?
    var downloadItem: downItem?
    
    var isVideoFinished: Bool = false
    var isDragging: Bool = false
    var isPlayer: Bool = false
    var isDownloadClick: Bool = false
    var videoRestartValue: Int32?
    var vodTotalTime: String? // 点播的总时间
    var _position: Int32? // 当前进度值
    var allPosition: Int32? // 总进度值
    var isOffLinePlay: Bool = false // 在线／离线播放
    

    private lazy var scrollView: UIScrollView = {
       let tempScrollView = UIScrollView(frame: view.bounds)
        tempScrollView.delegate = self
        tempScrollView.isPagingEnabled = true
        tempScrollView.contentSize = CGSize(width: kScreenW * 3, height: 0)
        tempScrollView.showsVerticalScrollIndicator = false
        tempScrollView.showsHorizontalScrollIndicator = false
        return tempScrollView
    }()
    
    private lazy var headerView: TYSLiveAudioBackHeaderView = {
        
        let tempHeaderView = TYSLiveAudioBackHeaderView.createHeaderView(frame: CGRect(x: 0, y: kScrollViewBeginTopInset, width: kScreenW, height: kHeaderViewH), image: (liveDetailModel.live_img_path)!)
        tempHeaderView.delegate = self
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(pan:)))
        tempHeaderView.addGestureRecognizer(pan)
        return tempHeaderView
    }()
    
    private lazy var pageMenu: AYPageMenu = {
        let items = ["互动","提问", "资料"]
       let tempPageMenu = AYPageMenu(frame: CGRect(x: 0, y: kHeaderViewH + kNavigationBarHeight, width: kScreenW, height: kPageMenuH)).pageMenu(items: items)
        tempPageMenu.delegate = self
        tempPageMenu.isTimer = false
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(pan:)))
        tempPageMenu.addGestureRecognizer(pan)
        return tempPageMenu
    }()
    
    private lazy var voddownloader: VodDownLoader = {
        let tempVoddownloader = VodDownLoader()
        tempVoddownloader.delegate = self
        return tempVoddownloader
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        if (vodplayer != nil) {
            vodplayer?.stop()
            vodplayer = nil
        }
        
    }
    
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
        
        joinLive()
    }
}

extension TYSLiveAudioBackViewController {
    
    private func joinLive() {
        if liveDetailModel.is_melive == "1" { // 我的直播
            requestLiveJoinLiveData()
        } else {
            if liveDetailModel.is_signup == "2" { // 未报名
                requestLiveSignUpData()
            } else {
                requestLiveJoinLiveData()
            }
        }
    }
    
    private func signUpHandler(signUpModel: TYSLiveSignupModel) {
        // 返回编码 -11本场路演（电话会议）仅对认证用户开放请登陆/注册/认证后，再参与 -10您的试听机会已经用完请登陆/注册/认证后，再参与本场路演（电话会议）") -9用户不在白名单中 -8该场路演嘉宾有限制 0报名失败 1报名人数已满 5已报名本场直播 8预报名成功，待支付 9报名成功
        switch signUpModel.code {
        case "0"?: // 报名失败
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        case "1"?: // 报名人数已满
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        case "5"?, "9"?: // 已报名本场直播/报名成功
            requestLiveJoinLiveData()
            break
        case "8"?: // 预报名成功，待支付
            showOnlyText(text: signUpModel.msg!)
            break
        case "-8"?: // 该场路演嘉宾有限制
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        case "-9"?: // 用户不在白名单中
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        case "-10"?: // 您的试听机会已经用完请登陆/注册/认证后，再参与本场路演（电话会议)
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        case "-11"?: // 本场路演（电话会议）仅对认证用户开放请登陆/注册/认证后，再参与
            showOnlyText(text: signUpModel.msg!)
            getCurrentController()?.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    private func joinLiveHandler(joinLiveModel: TYSLiveJoinLiveModel) {
        vodParam = VodParam()
        vodParam?.domain = joinLiveModel.domain
        vodParam?.vodID = joinLiveModel.back_id
        vodParam?.vodPassword = joinLiveModel.back_pwd
        vodParam?.serviceType = "webcast"
        vodParam?.customUserID = Int64(1000000000 + Int(kLoginModel.user_id!)!)
        vodParam?.nickName = kPersonalModel.userName
        voddownloader.addItem(vodParam)
    }
    
    /// 报名接口
    private func requestLiveSignUpData() {
        let param = [
            "requestCode" : "81000",
            "user_id" : kLoginModel.user_id ?? "",
            "live_id" : liveDetailModel.id ?? ""
        ]
        
        requestLiveSignUp(paramterDic: param, successCompletion: {[weak self] (signUpModel) in
            self?.signUpHandler(signUpModel: signUpModel)
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
    
    /// 加入直播
    private func requestLiveJoinLiveData() {
        let param = [
            "requestCode" : "82000",
            "user_id" : kLoginModel.user_id ?? "",
            "live_id" : liveDetailModel.id ?? ""
        ]
        
        requestLiveJoinLive(paramterDic: param, successCompletion: {[weak self] (joinModel) in
            self?.joinLiveHandler(joinLiveModel: joinModel)
            self?.joinLiveModel = joinModel
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
}

extension TYSLiveAudioBackViewController {
    private func addSubviews() {
        
        let liveDetailBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        liveDetailBtn.setTitleColor(tys_middleDarkColor, for: .normal)
        liveDetailBtn.titleLabel?.font = SystemFont(fontSize: 16)
        liveDetailBtn.setTitle("详情", for: .normal)
        liveDetailBtn.addTarget(self, action: #selector(liveDetailBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: liveDetailBtn)
        
        view.addSubview(scrollView)
        view.addSubview(headerView)
        view.addSubview(pageMenu)
        
        let chatVC = TYSLiveChatViewController()
        let questionVC = TYSLiveQuestionViewController()
        questionVC.liveDetailModel = liveDetailModel
        let fileVC = TYSLiveFileViewController()
        fileVC.liveDetailModel = liveDetailModel
        
        self.addChildViewController(chatVC)
        self.addChildViewController(questionVC)
        self.addChildViewController(fileVC)
        scrollView.addSubview(self.childViewControllers[0].view)
    }
}

// MARK:
extension TYSLiveAudioBackViewController {
    @objc private func liveDetailBtnClick() {
        let webVc = TYSCommonWebViewController()
        
        webVc.liveWebUrl = String(format:"%@%@/%@/%@/%@", webUrl, "Live/LiveDetail", kLoginModel.access_token ?? "", kLoginModel.user_id ?? "", liveDetailModel.id ?? "")
        printLog(webVc.liveWebUrl)
        navigationController?.pushViewController(webVc, animated: true)
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
        printLog("开始播放")
        if isVideoFinished {
            tys_setupVodPlayer(backId: joinLiveModel.back_id!)
        } else {
            if (joinLiveModel.back_id == nil) && !isOffLinePlay {
                showOnlyText(text: "该回听正在生成或回听数据被工作人员移除，请稍后重试")
                didPlay.isSelected = false
            } else {
                doPlay()
                didPlay.isSelected = true
            }
        }
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didPause: UIButton) {
        printLog("暂停播放")
        didPause.isSelected = false
        doPause()
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickBack: UIButton) {
        printLog("快退")
        if isPlayer {
            var pos = _position! - 15000
            if pos < 0 {
                pos = 0
            }
            onSeek(pos)
            vodplayer?.seek(to: pos)
        }
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickFoward: UIButton) {
        printLog("快进")
        if isPlayer {
            let pos = _position! + 15000
            if pos > allPosition! {
                onStop()
                doPause()
            } else {
                onSeek(pos)
                vodplayer?.seek(to: pos)
            }
            
        }
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickDownload: UIButton) {
        printLog("下载")
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoHold: UISlider) {
        printLog("按下")
        if !isVideoFinished {
            if isPlayer {
                doHold(slider: didSliderDoHold)
            }
        }
        
    }
    
    func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoSeek: UISlider) {
        printLog("滑动")
        if !isVideoFinished {
            if isPlayer {
                doSeek(slider: didSliderDoSeek)
            }
        }
    }
    
}

extension TYSLiveAudioBackViewController: VodPlayDelegate, VodDownLoadDelegate {
    // MARK: VodPlayDelegate
    // 初始化VodPlayer代理
    func onInit(_ result: Int32, haveVideo: Bool, duration: Int32, docInfos: [Any]!) {
        headerView.setSlider(maxValue: Int32(duration))
        headerView.setSlider(minValue: 0)
        headerView.changePlayState()
        isPlayer = true
        allPosition = duration
        if isVideoFinished {
            isVideoFinished = false
            vodplayer?.seek(to: videoRestartValue!)
        }
        vodTotalTime = formatTime(msec: duration)
    }
    
    // 进度条定位播放，如快进、快退、拖动进度条等操作回调方法
    func onSeek(_ position: Int32) {
        isDragging = false
        headerView.setSlider(value: position)
        if vodTotalTime == nil {
            vodTotalTime = "00:00:00"
        }
        
        headerView.setLeftTime(text: formatTime(msec: position))
        headerView.setRightTime(text: vodTotalTime!)
    }
    
    // 进度回调方法
    func onPosition(_ position: Int32) {
        printLog("position: \(position)")
        if (isDragging) {
            return
        }
        headerView.setSlider(value: position)
        if vodTotalTime == nil {
            vodTotalTime = "00:00:00"
        }
        headerView.setLeftTime(text: formatTime(msec: position))
        headerView.setRightTime(text: vodTotalTime!)
        _position = position
    }
    
    func onStop() {
        headerView.setSlider(value: allPosition!)
        isVideoFinished = true
        isPlayer = false
        _position = 0
        headerView.changePlayState()
        vodplayer?.seek(to: 0)
        showOnlyText(text: "当前播放已结束，点击以重新播放")
    }
    
    // MARK: VodDownLoadDelegate
    // 添加item的回调方法
    func onAddItemResult(_ resultType: RESULT_TYPE, voditem item: downItem!) {
        if resultType == RESULT_SUCCESS {
            tys_setupVodPlayer(backId: item.strDownloadID)
        } else {
            showFail(text: "加入错误")
        }
    }
    
    func onDLPosition(_ downloadID: String!, percent: Float) {
        
    }
    
    func onDLStart(_ downloadID: String!) {
        
    }
    
    func onDLStop(_ downloadID: String!) {
        
    }
    
    func onDLFinish(_ downloadID: String!) {
        
    }
    
    // MARK: VodPlayHandler
    // 初始化播放器
    private func tys_setupVodPlayer(backId: String) {
        isVideoFinished = false
        isPlayer = true
        videoRestartValue = 0
        
        let downitem: downItem = VodManage().findDownItem(backId)
        
        if (vodplayer != nil) {
            vodplayer?.stop()
            vodplayer = nil
        }
        
        if (vodplayer == nil) {
            vodplayer = VodPlayer()
        }
        
        vodplayer?.playItem = downitem
        vodplayer?.delegate = self
        
        if isOffLinePlay {
            vodplayer?.offlinePlay(true)
        } else {
            vodplayer?.onlinePlay(true, audioOnly: true)
        }
    }
    
    // 恢复播放
    private func doPlay() {
        if (vodplayer != nil) {
            vodplayer?.resume()
            isPlayer = true
        }
    }
    
    // 暂停播放
    private func doPause() {
        if (vodplayer != nil) {
            vodplayer?.pause()
            isPlayer = false
        }
    }
    
    private func doHold(slider: UISlider) {
        isDragging = true
    }
    
    // 滑动条监听方法
    private func doSeek(slider: UISlider) {
        if isVideoFinished {
            
            if isOffLinePlay {
                vodplayer?.onlinePlay(false, audioOnly: false)
            } else {
                vodplayer?.offlinePlay(false)
                vodplayer?.seek(to: 0)
                doPause()
            }
        }
        
        let duratino = slider.value
        videoRestartValue = Int32(slider.value)
        if isPlayer {
            vodplayer?.seek(to: Int32(duratino))
        }
    }
    
    private func formatTime(msec: Int32) -> String {
        let hours = msec / 1000 / 60 / 60
        let minutes = (msec / 1000 / 60) % 60
        let seconds = (msec / 1000) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


