//
//  TYSRecReadDetailViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSRecReadDetailViewController: BaseViewController {

    var recReadModel = TYSRecReadModel()
    var recReadDetailModel = TYSRecReadDetailModel()
    
    private lazy var headerView: TYSRecReadDetailHeaderView = {
        let tempHeaderView = TYSRecReadDetailHeaderView()
        return tempHeaderView
    }()
    private lazy var wkWebView: AYWKWebView = {
        
        let headerViewH = ay_getHeight(string: recReadModel.title ?? "", fontSize: 20, width: kScreenW - AdaptW(w: 46), maxHeight: 72.0)
        
        let tempWkWebView = AYWKWebView.createWKWebView(frame: CGRect(x: 0, y: headerViewH + 80 + kNavigationBarHeight, width: kScreenW, height: kScreenH - (headerViewH + 80 + kNavigationBarHeight + 60)))
        tempWkWebView.delegate = self
        tempWkWebView.isNavigationBarOrTranslucent = false
        return tempWkWebView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        requestRecReadDetailData()
    }

    
    private func requestRecReadDetailData() {
        let param = [
            "requestCode" : "V240003",
            "login_user_id" : loginModel.user_id ?? "",
            "id" : recReadModel.id ?? ""
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
            contents = model.title ?? ""
            let tempContents = model.title?.replacingOccurrences(of: "\n", with: "<br />")
            
            contents = htmlTemplate.replacingOccurrences(of: "</body>", with:String(format: "<p>%@<br /></p>\n</body>", tempContents!))
            
            contents = contents.replacingOccurrences(of: "</body>", with: String(format: "<p class=\"declaration\"><span class=\"declaration\">* 免责声明 · 本文内容不代表投研社的观点和立场，不构成任何投资建议。<br/></span></p> </body>"))
            
            wkWebView.loadHtmlString(htmlString: contents)
        }
        
        
        
        
    }

}

extension TYSRecReadDetailViewController {
    private func addSubView() {
        let headerViewH = ay_getHeight(string: recReadModel.title ?? "", fontSize: 20, width: kScreenW - AdaptW(w: 46), maxHeight: 72.0)
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(kNavigationBarHeight)
            make.left.right.equalTo(view)
            make.height.equalTo(headerViewH + 80)
        }
        
        view.addSubview(wkWebView)

        
        
        
    }
    
    
}

// MARK: delegate
extension TYSRecReadDetailViewController: AYWKWebViewDelegate {
    
    func wkWebView(wkWebView: AYWKWebView, didCommitWithURL: URL) {
        
    }
    
    func wkWebView(wkWebView: AYWKWebView, didFinishLoadWithURL: URL) {
        
        
    }
    
}






