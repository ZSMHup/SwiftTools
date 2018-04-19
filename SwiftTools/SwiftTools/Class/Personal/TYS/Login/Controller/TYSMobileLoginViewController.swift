//
//  TYSMobileLoginViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/23.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit


class TYSMobileLoginViewController: BaseViewController {
    
    private var telNumTextField: TextField?
    private var captchaInput: TextField?
    private var getCaptchaBtn: UIButton?
    private var checkBox: UIButton?
    private var phoneLoginBtn: UIButton?
    
    private var mobile: String = ""
    private var vstatus: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        
        NTESVerifyCodeManager.sharedInstance().delegate = self
        NTESVerifyCodeManager.sharedInstance().frame = CGRect.null
        NTESVerifyCodeManager.sharedInstance().configureVerifyCode(kNetEaseCaptchaId, timeout: 8.0)
        
        telNumTextField?.addTextDidChangeHandler(tempChangeHandler: {[weak self] (textField) in
            self?.mobileLoginhandler()
            self?.mobile = textField.text!
        })
        
        captchaInput?.addTextDidChangeHandler(tempChangeHandler: {[weak self] (textField) in
            self?.mobileLoginhandler()
            self?.vstatus = textField.text!
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupUI () {
        let skipBtn = UIButton() //跳过
        skipBtn.setTitle("跳过", for: .normal)
        skipBtn.setTitleColor(tys_grayColor, for: .normal)
        skipBtn.titleLabel?.font = AdaptFont(fontSize: 16)
        skipBtn.addTarget(self, action: #selector(skipBtnClick), for: .touchUpInside)
        view.addSubview(skipBtn)
        skipBtn.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -22))
            make.top.equalTo(view.snp.top).offset(AdaptH(h: 31))
            make.size.equalTo(CGSize(width: AdaptW(w: 36), height: AdaptH(h: 22)))
        }
        
        let logImg = UIImageView() //log
        logImg.image = UIImage(named: "default_logo")
        view.addSubview(logImg)
        logImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(AdaptH(h: 181))
            make.size.equalTo(CGSize(width: AdaptW(w: 76), height: AdaptH(h: 76)))
        }
        
        let wechatLoginBtn = UIButton() // 微信登录
        wechatLoginBtn.setTitle("微信快捷登录", for: .normal)
        wechatLoginBtn.setTitleColor(tys_grayColor, for: .normal)
        wechatLoginBtn.titleLabel?.font = AdaptFont(fontSize: 16)
        wechatLoginBtn.backgroundColor = tys_whiteColor
        wechatLoginBtn.layer.borderWidth = 1
        wechatLoginBtn.layer.borderColor = hexString("#DDDDDD").cgColor
        wechatLoginBtn.addTarget(self, action: #selector(wechatBtnClick), for: .touchUpInside)
        view.addSubview(wechatLoginBtn)
        wechatLoginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(AdaptH(h: -66))
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.height.equalTo(AdaptH(h: 50))
        }
        
        phoneLoginBtn = UIButton() // 手机验证码登录
        phoneLoginBtn?.setTitle("手机验证码登录", for: .normal)
        phoneLoginBtn?.setTitleColor(tys_whiteColor, for: .normal)
        phoneLoginBtn?.titleLabel?.font = AdaptFont(fontSize: 16)
        phoneLoginBtn?.backgroundColor = tys_disabledBackgroundColor
        phoneLoginBtn?.isEnabled = false
        phoneLoginBtn?.addTarget(self, action: #selector(phoneLoginBtnClick), for: .touchUpInside)
        view.addSubview(phoneLoginBtn!)
        phoneLoginBtn?.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(wechatLoginBtn.snp.top).offset(AdaptH(h: -19))
            make.left.equalTo(wechatLoginBtn.snp.left)
            make.height.equalTo(AdaptH(h: 50))
        }
        
        checkBox = UIButton()
        checkBox?.setImage(UIImage(named:"login_checkbox_normal"), for: .normal)
        checkBox?.setImage(UIImage(named:"login_checkbox_selected"), for: .selected)
        checkBox?.addTarget(self, action: #selector(chechboxClick(button:)), for: .touchUpInside)
        checkBox?.isSelected = true
        view.addSubview(checkBox!)
        checkBox?.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.bottom.equalTo((phoneLoginBtn?.snp.top)!).offset(AdaptH(h: -37))
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        let disclaimerBtn = UIButton() // 免责
        disclaimerBtn.setTitle("登录即表示您已阅读并遵守《投研社用户免责声明》", for: .normal)
        disclaimerBtn.setTitleColor(tys_grayColor, for: .normal)
        disclaimerBtn.titleLabel?.font = AdaptFont(fontSize: 12)
        disclaimerBtn.addTarget(self, action: #selector(disclaimerBtnClick), for: .touchUpInside)
        view.addSubview(disclaimerBtn)
        disclaimerBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo((checkBox?.snp.centerY)!)
            make.left.equalTo((checkBox?.snp.right)!).offset(AdaptW(w: 5))
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = hexString("#FFDDDDDD")
        view.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -39))
            make.bottom.equalTo((checkBox?.snp.top)!).offset(AdaptH(h: -20))
            make.height.equalTo(0.5)
        }
        
        captchaInput = TextField() // 验证码
        captchaInput?.tintColor = tys_inputTintColor
        captchaInput?.placeholder = "请输入验证码"
        captchaInput?.textColor = tys_titleColor
        captchaInput?.clearButtonMode = .whileEditing
        captchaInput?.keyboardType = .numberPad
        captchaInput?.font = AdaptFont(fontSize: 16)
        captchaInput?.borderStyle = .none
        captchaInput?.maxLength = 6
        view.addSubview(captchaInput!)
        captchaInput?.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.bottom.equalTo(lineView2.snp.top).offset(AdaptH(h: -10))
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -150))
            make.height.equalTo(AdaptH(h: 25))
        }
        
        getCaptchaBtn = UIButton()
        getCaptchaBtn?.setTitle("| 获取验证码", for: .normal)
        getCaptchaBtn?.setTitleColor(tys_titleColor, for: .normal)
        getCaptchaBtn?.titleLabel?.font = AdaptFont(fontSize: 15)
        getCaptchaBtn?.contentHorizontalAlignment = .right
        getCaptchaBtn?.addTarget(self, action: #selector(getCaptchaBtnClick(button:)), for: .touchUpInside)
        view.addSubview(getCaptchaBtn!)
        getCaptchaBtn?.snp.makeConstraints { (make) in
            make.centerY.equalTo((captchaInput?.snp.centerY)!)
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -39))
            make.size.equalTo(CGSize(width: AdaptW(w: 100), height: AdaptH(h: 30)))
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = hexString("#FFDDDDDD")
        view.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.equalTo((captchaInput?.snp.left)!)
            make.right.equalTo(lineView2.snp.right)
            make.bottom.equalTo((captchaInput?.snp.top)!).offset(AdaptH(h: -30))
            make.height.equalTo(0.5)
        }
        
        telNumTextField = TextField() // 手机号码
        telNumTextField?.tintColor = tys_inputTintColor
        telNumTextField?.placeholder = "请输入手机号码"
        telNumTextField?.textColor = tys_titleColor
        telNumTextField?.clearButtonMode = .whileEditing
        telNumTextField?.keyboardType = .numberPad
        telNumTextField?.font = AdaptFont(fontSize: 16)
        telNumTextField?.borderStyle = .none
        telNumTextField?.maxLength = 11
        telNumTextField?.text = UserDefaults.standard.getCustomObject(forKey: "phoneNumber") as? String
        view.addSubview(telNumTextField!)
        telNumTextField?.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(AdaptW(w: 39))
            make.bottom.equalTo(lineView1.snp.top).offset(AdaptH(h: -10))
            make.right.equalTo(view.snp.right).offset(AdaptW(w: -39))
            make.height.equalTo(AdaptH(h: 25))
        }
    }
    
    private func requestMoblieLoginData() {
        let deviceID: String = AYKeychain.getDeviceIDInKeychain()
        
        let param = [
            "requestCode" : "10000",
            "mobile" : mobile,
            "vstatus" : vstatus,
            "eq_number" : deviceID
        ]
        
        requestMobileLogin(paramterDic: param, successCompletion: { (successValue) in
            UserDefaults.standard.saveCustomObject(customObject: self.mobile as NSCoding, key: "phoneNumber")
            UserDefaults.standard.saveCustomObject(customObject: successValue, key: "loginModel")
            
            let loginModel = TYSLoginModel()
            loginModel.insertData(_userId: successValue.user_id ?? "", _mobileState: successValue.mobile_state ?? "", _accessToken: successValue.access_token ?? "")
            
            
            let homeVc = TYSHomeViewController()
            self.navigationController?.pushViewController(homeVc, animated: true)
        }) { (failure) in
            showOnlyText(text: failure as! String)
        }
    
    }
    
    private func requestGetCaptchaData(
        validate: String,
        success: @escaping ()->()) {
        let param = [
            "requestCode" : "V210005",
            "mobile" : mobile,
            "type" : "1",
            "validate" : validate,
        ]
        requestGetCaptcha(paramterDic: param, successCompletion: { (successValue) in
            success()
        }) { (failure) in
            showOnlyText(text: failure as! String)
        }
    }
    
    func mobileLoginhandler() {
        if !isTelNumber(num: (telNumTextField?.text)!) {
            phoneLoginBtn?.backgroundColor = tys_disabledBackgroundColor
            phoneLoginBtn?.isEnabled = false
            return
        }
        
        if (captchaInput?.text?.count)! < 4 {
            phoneLoginBtn?.backgroundColor = tys_disabledBackgroundColor
            phoneLoginBtn?.isEnabled = false
            return
        }
        
        if !(checkBox?.isSelected)! {
            phoneLoginBtn?.backgroundColor = tys_disabledBackgroundColor
            phoneLoginBtn?.isEnabled = false
            return
        }
        
        phoneLoginBtn?.backgroundColor = tys_backgroundColor
        phoneLoginBtn?.isEnabled = true
        mobile = (telNumTextField?.text)!
    }
}

// MARK: event response
extension TYSMobileLoginViewController {
    
    @objc private func skipBtnClick() {
        let homeVc = TYSHomeViewController()
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    @objc private func wechatBtnClick() {
        let homeVc = TYSHomeViewController()
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    @objc private func phoneLoginBtnClick() {
        requestMoblieLoginData()
        
    }
    
    @objc private func getCaptchaBtnClick(button: UIButton) {
        if !isTelNumber(num: (telNumTextField?.text)!) {
            showOnlyText(text: "请输入正确的手机号码")
            return
        }
        
        NTESVerifyCodeManager.sharedInstance().openVerifyCodeView()
    }
    
    @objc private func chechboxClick(button: UIButton) {
        button.isSelected = !button.isSelected
        mobileLoginhandler()
    }
    
    @objc private func disclaimerBtnClick() {
        print("免责声明")
    }
}

extension TYSMobileLoginViewController: NTESVerifyCodeManagerDelegate {
    func verifyCodeInitFinish() {
        view.endEditing(true)
    }
    
    func verifyCodeInitFailed(_ error: String!) {
        showOnlyText(text: error)
    }
    
    func verifyCodeValidateFinish(_ result: Bool, validate: String!, message: String!) {
        if result {
            requestGetCaptchaData(validate: validate) {  [weak self] in
                self?.getCaptchaBtn?.countdownWithSec(sec: 60)
                self?.captchaInput?.text = self?.vstatus
            }
        } else {
            showOnlyText(text: "验证错误，请再试一次")
        }
    }
    
    func verifyCodeNetError(_ error: Error!) {
        showOnlyText(text: error as! String)
    }
}
