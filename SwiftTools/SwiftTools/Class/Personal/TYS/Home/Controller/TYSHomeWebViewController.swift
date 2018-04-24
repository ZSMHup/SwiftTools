//
//  TYSHomeWebViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSHomeWebViewController: BaseViewController {

    var url: String = ""
    
    private var wkWebView: AYWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBtn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn1.setTitle("刷新", for: .normal)
        rightBtn1.setTitleColor(UIColor.black, for: .normal)
        rightBtn1.addTarget(self, action: #selector(rightBtn1Click), for: .touchUpInside)
        let rightBtn1Item = UIBarButtonItem(customView: rightBtn1)
        
        let rightBtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn2.setTitle("前进", for: .normal)
        rightBtn2.setTitleColor(UIColor.black, for: .normal)
        rightBtn2.addTarget(self, action: #selector(rightBtn2Click), for: .touchUpInside)
        let rightBtn2Item = UIBarButtonItem(customView: rightBtn2)
        
        let rightBtn3 = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn3.setTitle("后退", for: .normal)
        rightBtn3.setTitleColor(UIColor.black, for: .normal)
        rightBtn3.addTarget(self, action: #selector(rightBtn3Click), for: .touchUpInside)
        let rightBtn3Item = UIBarButtonItem(customView: rightBtn3)
        
        navigationItem.rightBarButtonItems = [rightBtn2Item, rightBtn1Item, rightBtn3Item]

        wkWebView = AYWKWebView.createWKWebView(frame: view.bounds)
        wkWebView?.loadRequest(urlString: url)
        wkWebView?.delegate = self
        wkWebView?.progressViewColor = UIColor.orange
        view.addSubview(wkWebView!)
    }

    deinit {
        printLog("deinit -- TYSHomeWebViewController")
    }
    
    @objc func rightBtn1Click() {
        wkWebView?.reloadData()
    }
    
    @objc func rightBtn2Click() {
        wkWebView?.goForward()
    }
    
    @objc func rightBtn3Click() {
        wkWebView?.goBack()
    }

}

extension TYSHomeWebViewController: AYWKWebViewDelegate {
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        navigationItem.title = wkWebView.navigationItemTitle
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {

        navigationItem.title = wkWebView.navigationItemTitle
    }
}
