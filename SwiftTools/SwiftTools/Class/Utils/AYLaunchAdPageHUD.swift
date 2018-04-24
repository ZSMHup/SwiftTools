//
//  AYLaunchAdPageHUD.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/23.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let AYLaunchScreenW = UIScreen.main.bounds.size.width
let AYLaunchScreenH = UIScreen.main.bounds.size.height

class AYLaunchAdPageHUD: UIView {
    var launchAdClickBlock:(()->())?
    static let manager = AYLaunchAdPageHUD()
    private var aDFrame: CGRect!  /**< 广告图片frame */
    private var aDduration: Int = 0 /**< 广告停留时间 */
    private var aDImageUrl: String = "" /**< 广告图片的URL */
    private var aDhideSkipButton: Bool = false /**< 是否隐藏'倒计时/跳过'按钮 */
    private var launchImageView: UIImageView!  /**< APP启动图片 */
    private var aDImageView: UIImageView!       /**< APP广告图片 */
    private var skipButton: UIButton! /**< 跳过按钮 */
    
    func initWith(frame: CGRect, aDduration: Int, aDImageUrl: String, hideSkipButton: Bool, launchAdClickBlock: (()->())?) {
        self.aDFrame = frame
        self.aDduration = aDduration
        self.aDImageUrl = aDImageUrl
        self.aDhideSkipButton = hideSkipButton
        self.frame = UIScreen.main.bounds
//        self.addSubview(setUpLaunchImageView())
        self.addSubview(setUpAdImageView())
        self.addSubview(setUpSkipButton())
        self.launchAdPageStart()
        self.launchAdPageEnd()
        self.addInWindow()
        self.launchAdClickBlock = launchAdClickBlock
    }
    
    func showLaunch() {
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        let image = UserDefaults.standard.getCustomObject(forKey: "adImageName") ?? " " as AnyObject
        let filePath = NSHomeDirectory().appending("/Documents/\(image)")
        let isExist = isFileExist(withFilePath: filePath)
        if isExist {
            AYLaunchAdPageHUD.manager.initWith(frame: UIScreen.main.bounds, aDduration: 3, aDImageUrl: filePath, hideSkipButton: false) {}
        }
        getUrl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        printLog("deinit:\(self.classForCoder)")
    }
}

// MARK: UI
extension AYLaunchAdPageHUD {
    // 设置启动图片
    private func setUpLaunchImageView() -> UIImageView {
        if (launchImageView == nil) {
            launchImageView = UIImageView(frame: UIScreen.main.bounds)
            launchImageView.image = launchImage()
        }
        return launchImageView
    }
    
    private func launchImage() -> UIImage? {
        let viewSize = UIScreen.main.bounds.size
        let viewOrientation = "Portrait" /**< 横屏 @"Landscape" */
        let imageArray = Bundle.main.infoDictionary!["UILaunchImages"]
        if imageArray != nil { // 加这个判断是防止没加 启动图，导致的崩溃
            // 建议不这么做，而是让美工切图，底下那个图
            for dict : Dictionary <String, String> in imageArray as! Array {
                let imageSize = CGSizeFromString(dict["UILaunchImageSize"]!)
                if imageSize.equalTo(viewSize) && viewOrientation == dict["UILaunchImageOrientation"]! as String {
                    let image = UIImage(named: dict["UILaunchImageName"]!)
                    return image
                }
            }
        }
        printLog("[DHLaunchAdPageHUD]:请添加启动图片")
        return nil
    }
    
    // 设置广告图片
    private func setUpAdImageView() -> UIImageView {
        if (aDImageView == nil) {
            aDImageView = UIImageView.init(frame: aDFrame)
            aDImageView.isUserInteractionEnabled = true
            aDImageView.alpha = 0.2
            let idString = (aDImageUrl as NSString).substring(from: aDImageUrl.count - 3)
            if checkURL(url: aDImageUrl) {
                if idString == "gif" {
                    let urlData = NSData.init(contentsOf: NSURL.init(string: aDImageUrl)! as URL)
                    let gifView = AYGifImageOperation.init(frame: aDFrame, gifImageData: urlData! as Data)
                    aDImageView.addSubview(gifView)
                } else {
                    let aDimageData = NSData.init(contentsOf: NSURL.init(string: aDImageUrl)! as URL)
                    aDImageView.image = UIImage.init(data: aDimageData! as Data)
                }
            } else {
                if idString == "gif" {
                    
                    let localData = NSData.init(contentsOfFile: aDImageUrl)
                    let gifView = AYGifImageOperation.init(frame: aDFrame, gifImageData: localData! as Data)
                    aDImageView.addSubview(gifView)
                    
                } else {
                    aDImageView.image = UIImage.init(named: aDImageUrl)
                }
            }
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.adImageViewTapAction(tap:)))
            aDImageView.addGestureRecognizer(tap)
        }
        return aDImageView
    }
    
    // 设置跳过按钮
    private func setUpSkipButton() -> UIButton {
        if skipButton == nil {
            skipButton = UIButton.init(type: .custom)
            skipButton.frame = CGRect.init(x: AYLaunchScreenW-70, y: 30, width: 60, height: 30)
            skipButton.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
            skipButton.layer.cornerRadius = 15.0
            skipButton.layer.masksToBounds = true
            skipButton.isHidden = aDhideSkipButton
            var duration:Int = 3 /**< 默认停留时间 */
            if (aDduration != 0) { duration = aDduration }
            skipButton.setTitle("\(duration) 跳过", for: .normal)
            skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.5)
            skipButton.addTarget(self, action: #selector(skipButtonClick), for: .touchUpInside)
            dispath_timer()
        }
        return skipButton
    }
    
    private func removeLaunchAdPageHUD() {
        UIView.animate(withDuration: 0.8, animations: {
            UIView.setAnimationCurve(.easeOut)
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    private func dispath_timer() {
        
        let repeatCount = aDduration
        if repeatCount <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.schedule(wallDeadline: .now(), repeating: 1)
        timer.setEventHandler(handler: {
            count -= 1
            DispatchQueue.main.async {
                self.skipButton.setTitle("\(count) 跳过", for: .normal)
                printLog("\(count)")
            }
            if count == 0 {
                timer.cancel()
            }
        })
        timer.resume()
    }
    
    // 设置广告图片的开始
    private func launchAdPageStart() {
        UIView.animate(withDuration: 1) {
            self.aDImageView.alpha = 1.0
        }
    }
    // 设置广告图片的结束
    private func launchAdPageEnd() {
        var duration:Int = 3
        if aDduration != 0 {
            duration = self.aDduration
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(duration)) {
            self.removeLaunchAdPageHUD()
        }
    }
    
    // 添加至主窗口
    private func addInWindow() {
        /**< 等didFinishLaunchingWithOptions方法结束后,将其添加至window上(不然会检测是否有rootViewController) */
        DispatchQueue.main.async {
            UIApplication.shared.delegate?.window!?.addSubview(self)
        }
    }
    
    // 正则表达式验证URL
    private func checkURL(url: String) -> Bool {
        let regex = "[a-zA-z]+://[^\\s]*"
        let pred = NSPredicate(format: "SELF MATCHES %@",regex)
        return pred.evaluate(with:url)
    }
    
    
    // 判断文件是否存在
    private func isFileExist(withFilePath filePath: String) -> Bool {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        return fileManager.fileExists(atPath: filePath, isDirectory :  &isDirectory)
    }
    
    
    
    @objc private func adImageViewTapAction(tap: UITapGestureRecognizer) -> Void {
        if launchAdClickBlock != nil {
            launchAdClickBlock!()
        }
    }
    
    @objc private func skipButtonClick() {
        removeLaunchAdPageHUD()
    }
}

// MARK:
extension AYLaunchAdPageHUD {
    private func getUrl() {
        let param = [
            "requestCode" : "95000",
            "position" : "START_PAGE"]
        requestHomeAD(paramterDic: param, cacheCompletion: { (cacheValue) in
            
        }, successCompletion: { (valueArray) in
            let url = valueArray.first?.img_path ?? ""
            if self.checkURL(url: url) {
                let stringArr = url.components(separatedBy: "/")
                let imageName: String = stringArr.last ?? ""
                let filePath = NSHomeDirectory().appending("/Documents/\(imageName)")
                let isExist = self.isFileExist(withFilePath: filePath)
                if isExist == false {
                    self.downloadAdImage(withUrl: url, imageName: imageName)
                }
            } else {
                printLog("不是有效的链接")
            }
        }) { (failure) in
            showFail(text: "网络异常")
        }
    }
    
    // 下载新图片
    private func downloadAdImage(withUrl imageUrl: String, imageName: String) {
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            let url =  URL(string: imageUrl)
            let data :Data? = try? Data(contentsOf: url!)
            if data != nil {
                let filePath: String = NSHomeDirectory().appending("/Documents/\(imageName)")
                let fileManager = FileManager.default
                fileManager.createFile(atPath: filePath, contents: data , attributes: nil)
                self.deletOldImage()
                UserDefaults.standard.saveCustomObject(customObject: imageName as NSCoding, key: "adImageName")
                printLog("已下载")
            } else {
                printLog("链接已失效")
            }
        })
    }
    
    // 删除旧图片
    private func deletOldImage()  {
        let imageName = UserDefaults.standard.getCustomObject(forKey: "adImageName")
        if (imageName != nil) {
            let filePath = NSHomeDirectory().appending("/Documents/\(String(describing: imageName))")
            let fileManager:FileManager = FileManager.default
            try? fileManager.removeItem(atPath: filePath)
        }
    }
}


class AYGifImageOperation: UIView {
    private var gifProperties: NSDictionary!
    private var gif: CGImageSource!
    private var count: size_t = 0
    private var index: size_t = 0
    private var timer: Timer!
    
    /**
     *  自定义播放Gif图片(Data)(本地+网络)
     *
     *  @param frame        位置和大小
     *  @param gifImageData Gif图片Data
     *
     *  @return Gif图片对象
     */
    init(frame: CGRect, gifImageData: Data) {
        super.init(frame: frame)
        let temp = NSDictionary.init(object: NSNumber.init(value: 0), forKey: NSString(format: "%d", CFGetTypeID(kCGImagePropertyGIFLoopCount)))
        gifProperties = NSDictionary.init(object: temp, forKey: NSString(format: "%d", CFGetTypeID(kCGImagePropertyGIFDictionary)))
        gif = CGImageSourceCreateWithData(gifImageData as CFData, gifProperties as CFDictionary)
        count = CGImageSourceGetCount(gif)
        timer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(play), userInfo: nil, repeats: true) /**< 0.12->0.06 */
        timer.fire()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func play(){
        if (count > 0) {
            index = index + 1
            index = index%count
            let ref = CGImageSourceCreateImageAtIndex(gif, index, gifProperties as CFDictionary)
            layer.contents = ref
        } else {
            
        }
    }
}

