//
//  AYWKWebView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import WebKit
import MJRefresh

@objc protocol AYWKWebViewDelegate: NSObjectProtocol {
    
    /// 页面开始加载时调用
    ///
    /// - Parameter webView: AYWKWebView
    @objc optional func wkWebViewDidStartLoad(wkWebView: AYWKWebView)
    
    /// 内容开始返回时调用
    ///
    /// - Parameters:
    ///   - webView: AYWKWebView
    ///   - didCommitWithURL: URL
    @objc optional func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL)
    
    /// 页面加载完成之后调用
    ///
    /// - Parameters:
    ///   - webView: AYWKWebView
    ///   - didFinishLoadWithURL: URL
    @objc optional func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL)
    
    /// 页面加载失败时调用
    ///
    /// - Parameters:
    ///   - webView: AYWKWebView
    ///   - didFailLoadWithError: 返回错误信息
    @objc optional func wkWebView(wkWebView: AYWKWebView, didFailLoadWithError: Error)
}

class AYWKWebView: UIView {
    private let ay_kNavigationBarHeight = UIApplication.shared.statusBarFrame.size.height + 44.0
    private let progressViewHeight: CGFloat = 2.0
    
    weak var delegate: AYWKWebViewDelegate?
    /// 进度条颜色(默认蓝色)
    var progressViewColor: UIColor = UIColor.green {
        willSet {
            progressView.tintColor = newValue
        }
    }
    /// 导航栏标题
    var navigationItemTitle: String?
    
    /// 是否使用MJRefresh下拉刷新
    var isUserMJRefresh: Bool = false {
        willSet {
            if newValue == true {
                wkWebView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
                    self?.reloadData()
                })
            }
        }
    }
    
    
    /// 导航栏存在且有穿透效果(默认导航栏存在且有穿透效果)
    var isNavigationBarOrTranslucent: Bool = true {
        willSet {
            if newValue == true {
                progressView.frame = CGRect(x: 0, y: ay_kNavigationBarHeight, width: self.frame.size.width, height: progressViewHeight)
            } else {
                progressView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: progressViewHeight)
            }
        }
    }
 
    
    private lazy var wkWebView: WKWebView = {
        let tempWkWebView = WKWebView(frame: self.bounds)
        tempWkWebView.uiDelegate = self
        tempWkWebView.navigationDelegate = self
        tempWkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        return tempWkWebView
    }()
    
    private lazy var progressView: UIProgressView = {
        let tempProgressView = UIProgressView(progressViewStyle: .default)
        tempProgressView.frame = CGRect(x: 0, y: ay_kNavigationBarHeight, width: self.frame.size.width, height: progressViewHeight)
        tempProgressView.trackTintColor = UIColor.clear
        tempProgressView.tintColor = progressViewColor
        return tempProgressView
    }()
    
    deinit {
        print("deinit -- AYWKWebView")
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    public class func createWKWebView(frame: CGRect) -> AYWKWebView {
        let webView = AYWKWebView(frame: frame)
        webView.addSubViews()
        return webView
    }
    
}

extension AYWKWebView {
    private func addSubViews() {
        addSubview(wkWebView)
        addSubview(progressView)
    }
}

extension AYWKWebView {
    
    /// 根据url加载
    ///
    /// - Parameter urlString: url(String)
    func loadRequest(urlString: String) {
        if !urlString.isEmpty {
            wkWebView.load(URLRequest(url: URL(string: urlString)!))
        } else {
            print("url为空")
        }
    }
    
    func loadHtmlString(htmlString: String) {
        wkWebView.loadHTMLString(htmlString, baseURL: nil)
        
    }
    
    
    
    /// 刷新数据
    func reloadData() {
        wkWebView.reload()
    }
    
    /// 返回
    func goBack() {
        if wkWebView.canGoBack {
            wkWebView.goBack()
        }
    }
    
    /// 前进
    func goForward() {
        if wkWebView.canGoForward {
            wkWebView.goForward()
        }
    }
}

extension AYWKWebView {
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "estimatedProgress") {
            progressView.alpha = 1.0;
            
            let animated: Bool = wkWebView.estimatedProgress > Double(progressView.progress)
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: animated)
            
            if wkWebView.estimatedProgress >= 0.97 {
                UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }, completion: { (finished) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
            
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension AYWKWebView: WKNavigationDelegate, WKUIDelegate {
    /// 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate?.wkWebViewDidStartLoad?(wkWebView: self)
    }
    
    /// 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        navigationItemTitle = webView.title
        delegate?.wkWebView?(wkWebView: self, didCommitWithURL: webView.url!)
    }
    
    /// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItemTitle = webView.title
        delegate?.wkWebView?(wkWebView: self, didFinishLoadWithURL: webView.url!)
        progressView.alpha = 0.0;
        if isUserMJRefresh {
            if wkWebView.scrollView.mj_header.isRefreshing {
                wkWebView.scrollView.mj_header.endRefreshing()
            }
        }
        
    }
    
    /// 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.wkWebView?(wkWebView: self, didFailLoadWithError: error)
        progressView.alpha = 0.0;
        if isUserMJRefresh {
            if wkWebView.scrollView.mj_header.isRefreshing {
                wkWebView.scrollView.mj_header.endRefreshing()
            }
        }
    }
}


