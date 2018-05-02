//
//  TYSRecReadDetailViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import WebKit
import IQKeyboardManagerSwift

class TYSRecReadDetailViewController: BaseViewController {

    var recReadModel = TYSRecReadModel()
    var readTitle: String = ""
    var readId: String = ""
    
    var recReadDetailModel = TYSRecReadDetailModel()
    
    private lazy var headerView: TYSRecReadDetailHeaderView = {
        let tempHeaderView = TYSRecReadDetailHeaderView()
        return tempHeaderView
    }()
    
    private lazy var inputViews: TYSRecReadDetailInputView = {
        let tempInputView = TYSRecReadDetailInputView()
        return tempInputView
    }()
    
    private lazy var wkWebView: AYWKWebView = {
        
        var javascript = String()
        javascript.append("var meta = document.createElement('meta');meta.name = 'viewport';meta.content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";document.getElementsByTagName('head')[0].appendChild(meta);")
        javascript.append("document.documentElement.style.webkitTouchCallout='none';")
        javascript.append("document.documentElement.style.webkitUserSelect='none';")
        javascript.append("document.getElementsByTagName('body')[0].style.background='#FFFFFF'")
        let userScript = WKUserScript(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentCtrl = WKUserContentController()
        userContentCtrl.addUserScript(userScript)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentCtrl
        
        let headerViewH = ay_getHeight(string: readTitle, fontSize: 20, width: kScreenW - AdaptW(w: 46), maxHeight: 72.0)
        
        let tempWkWebView = AYWKWebView.createWKWebView(frame: CGRect(x: 0, y: headerViewH + 80 + kNavigationBarHeight, width: kScreenW, height: kScreenH - (headerViewH + 80 + kNavigationBarHeight + 60)), configuration: configuration)
        tempWkWebView.delegate = self
        tempWkWebView.isNavigationBarOrTranslucent = false
        return tempWkWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        addSubView()
        requestRecReadDetailData()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let userInfo = sender.userInfo
        let frame: CGRect = userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let duration: CGFloat = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.inputViews.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.view.snp.bottom).offset(-frame.size.height)
            })
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let userInfo = sender.userInfo
        let duration: CGFloat = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.inputViews.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.view.snp.bottom)
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: requestData
extension TYSRecReadDetailViewController {
    private func requestRecReadDetailData() {
        let param = [
            "requestCode" : "V240003",
            "login_user_id" : kLoginModel.user_id ?? "",
            "id" : readId
        ]
        requestRecReadDetail(paramterDic: param, successCompletion: { (successValue) in
            self.recReadDetailHandler(model: successValue)
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
    
    private func recReadDetailHandler(model: TYSRecReadDetailModel) {
        self.recReadDetailModel = model
        self.headerView.setModel(model: model)
        
        let littleArticleTemplateFilePath = Bundle.main.path(forResource: "littleArticleTemplate", ofType: "html") ?? ""
        let htmlTemplate = try! String(contentsOfFile: littleArticleTemplateFilePath, encoding: .utf8)
        var contents = model.contents ?? ""
        
        if model.type == "1" {
            
            let tempContents = model.title?.replacingOccurrences(of: "\n", with: "<br />")
            contents = htmlTemplate.replacingOccurrences(of: "</body>", with:String(format: "<p class=\"p\">%@</p><br /></body>", tempContents!))
            contents = contents.replacingOccurrences(of: "</body>", with: "<p class=\"declaration\">* 免责声明 · 本文内容不代表投研社的观点和立场，不构成任何投资建议。<br/></p> </body>")
            wkWebView.loadHtmlString(htmlString: contents)
            
        } else if model.type == "3" {
            if (model.path == nil) {
                wkWebView.loadRequest(urlString: "https://www.baidu.com/search/error.html")
            } else {
                wkWebView.loadRequest(urlString: model.path!)
            }
        } else {
            if model.contents?.contains("<!DOCTYPE html") == false {
                contents = htmlTemplate.replacingOccurrences(of: "</body>", with: String(format: "<div style=\"margin-left: 23px;margin-right: 23px;\">%@</div></body>", model.contents ?? ""))
            }
            
            wkWebView.loadHtmlString(htmlString: contents)
        }
    }
}

extension TYSRecReadDetailViewController {
    private func addSubView() {
        let headerViewH = ay_getHeight(string: readTitle, fontSize: 20, width: kScreenW - AdaptW(w: 46), maxHeight: 72.0)
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(kNavigationBarHeight)
            make.left.right.equalTo(view)
            make.height.equalTo(headerViewH + 80)
        }
        
        view.addSubview(wkWebView)
        
        view.addSubview(inputViews)
        inputViews.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(60)
        }
        
    }
}

// MARK: delegate
extension TYSRecReadDetailViewController: AYWKWebViewDelegate {
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {
        
        
    }
    
}






