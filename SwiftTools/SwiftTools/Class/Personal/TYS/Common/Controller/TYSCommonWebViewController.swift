//
//  TYSCommonWebViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import WebKit

class TYSCommonWebViewController: BaseViewController {

    private var wkWebView: AYWKWebView?
    
    var liveWebUrl = ""
    private var dataSource = [Dictionary<String, Any>]()
    private var urlArray = [String : String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: NSURL = Bundle.main.url(forResource: "WebViewConfig", withExtension: "plist")! as NSURL
        let configDic: NSMutableDictionary = NSMutableDictionary(contentsOf: url as URL)!
        
        configDic.enumerateKeysAndObjects { (key, obj, stop) in
            dataSource.append(obj as! [String : Any])
        }
        
        addSubViews()
    }
}

extension TYSCommonWebViewController {
    private func addSubViews() {
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
        
        if dataSource.count > 0 {
            for index in 0..<dataSource.count {
                config.userContentController.add(self as WKScriptMessageHandler, name: dataSource[index]["name"] as! String)
                urlArray[dataSource[index]["name"] as! String] = dataSource[index]["url"] as? String
            }
        }
        wkWebView = AYWKWebView.createWKWebView(frame: view.bounds, configuration: config)
        wkWebView?.loadRequest(urlString: liveWebUrl)
        wkWebView?.delegate = self
        wkWebView?.progressViewColor = UIColor.orange
        view.addSubview(wkWebView!)
    }
    
    @objc private func leftBtnClick() {
        if wkWebView?.wkCanGoBack() ?? false {
            wkWebView?.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension TYSCommonWebViewController: AYWKWebViewDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let webVc = TYSCommonWebViewController()
        webVc.liveWebUrl = webUrl + urlArray[message.name]!
        navigationController?.pushViewController(webVc, animated: true)
    }
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        navigationItem.title = wkWebView.navigationItemTitle
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {
        navigationItem.title = wkWebView.navigationItemTitle
    }
}
