//
//  TYSPersonalWebViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/5/15.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import WebKit

class TYSPersonalWebViewController: BaseViewController {

    private var wkWebView: AYWKWebView?
    
    var personalUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printLog(personalUrl)
        addSubViews()
    }
}

// MARK: setup ui
extension TYSPersonalWebViewController {
    private func addSubViews() {
        let rightBtn = UIButton()
        rightBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightBtn.setImage(UIImage(named: "default_nav_msg"), for: .normal)
        rightBtn.addTarget(self, action: #selector(navRightBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        leftBtn.setImage(UIImage(named:"default_nav_back"), for: .normal)
        leftBtn.setTitleColor(UIColor.black, for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        var javascript = String()
        javascript.append("var meta = document.createElement('meta');meta.name = 'viewport';meta.content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";document.getElementsByTagName('head')[0].appendChild(meta);")
        javascript.append("document.documentElement.style.webkitTouchCallout='none';")
        javascript.append("document.documentElement.style.webkitUserSelect='none';")
        let userScript = WKUserScript(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentCtrl = WKUserContentController()
        userContentCtrl.addUserScript(userScript)
        let config = WKWebViewConfiguration()
        config.userContentController = userContentCtrl
        
        config.userContentController.add(self as WKScriptMessageHandler, name: "PersonalCell")
        
        wkWebView = AYWKWebView.createWKWebView(frame: view.bounds, configuration: config)
        wkWebView?.loadRequest(urlString: personalUrl)
        wkWebView?.delegate = self
        wkWebView?.progressViewColor = UIColor.orange
        view.addSubview(wkWebView!)
    }
}
// MARK: event response
extension TYSPersonalWebViewController {
    @objc private func navRightBtnClick() {
        printLog("msg")
    }
    
    @objc private func leftBtnClick() {
        if wkWebView?.wkCanGoBack() ?? false {
            wkWebView?.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension TYSPersonalWebViewController: AYWKWebViewDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let body = message.body
        
        if message.name == "PersonalCell" {
            let index: String = String(describing: body)
            
            switch (index) {
                case "0":
                    break;
                case "1":
                    break
                case "2":
                    break
                case "3":
                    break
                case "4":
                    break
                case "5":
                    navigationController?.pushViewController(TYSSettingViewController(), animated: true)
                    break
                default:
                    break
            }
        }
    }
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        navigationItem.title = wkWebView.navigationItemTitle
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {
        navigationItem.title = wkWebView.navigationItemTitle
    }
}
