//
//  TYSLiveAudioBackWebViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSLiveAudioBackWebViewController: BaseViewController {
    
    private var wkWebView: AYWKWebView?
    
    var liveWebUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView = AYWKWebView.createWKWebView(frame: view.bounds)
        wkWebView?.loadRequest(urlString: liveWebUrl)
        wkWebView?.delegate = self
        wkWebView?.progressViewColor = UIColor.orange
        view.addSubview(wkWebView!)
    }



}

extension TYSLiveAudioBackWebViewController {
    
}
extension TYSLiveAudioBackWebViewController: AYWKWebViewDelegate {
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {
        
    }
}
