//
//  TYSLiveAudioBackHeaderView.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/4.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

@objc protocol TYSLiveAudioBackHeaderViewDelegate: NSObjectProtocol {
    
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didPlay: UIButton)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didPause: UIButton)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickBack: UIButton)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickFoward: UIButton)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didClickDownload: UIButton)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoSeek: UISlider)
    @objc optional func liveRoomHeader(headerView: TYSLiveAudioBackHeaderView, didSliderDoHold: UISlider)
}

class TYSLiveAudioBackHeaderView: UIView {
    private var imgView: UIImageView?
    private var shadeView: UIView?
    private var otherBar: UIView?
    private var progressBar: UIView?
    
    private var backBtn: UIButton?
    private var fowardBtn: UIButton?
    private var downloadBtn: UIButton?
    
    private var playBtn: UIButton?
    private var leftTimeLabel: UILabel?
    private var slider: UISlider?
    private var rightTimeLabel: UILabel?
    
    weak var delegate: TYSLiveAudioBackHeaderViewDelegate?
    
    private var image: String?
    
    class func createHeaderView(frame: CGRect, image: String) -> TYSLiveAudioBackHeaderView {
        let headerView = TYSLiveAudioBackHeaderView()
        headerView.backgroundColor = UIColor.white
        headerView.frame = frame
        headerView.image = image
        headerView.addSubViews()
        return headerView
    }
    
}

extension TYSLiveAudioBackHeaderView {
    private func addSubViews() {
        imgView = UIImageView()
        guard let iconURL = URL(string: image ?? "") else { return }
        imgView?.kf.setImage(with: iconURL, placeholder:UIImage(named: "default_live_cover"))
        imgView?.isUserInteractionEnabled = true
        self.addSubview(imgView!)
        imgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(23.0)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right).offset(-23.0)
            make.bottom.equalTo(self.snp.bottom)
        })
        
        shadeView = UIView()
        shadeView?.backgroundColor = RGBA(46, 49, 50, 0.5)
        self.addSubview(shadeView!)
        shadeView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(23.0)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right).offset(-23.0)
            make.bottom.equalTo(self.snp.bottom)
        })
        
        otherBar = UIView()
        otherBar?.backgroundColor = UIColor.clear
        self.addSubview(otherBar!)
        otherBar?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((imgView?.snp.centerX)!)
            make.centerY.equalTo((imgView?.snp.centerY)!)
            make.size.equalTo(CGSize(width: kScreenW - 46.0, height: 100.0))
        })
        
        fowardBtn = UIButton()
        fowardBtn?.setImage(UIImage(named: "live_liveRoom_forward_15s"), for: .normal)
        fowardBtn?.setImage(UIImage(named: "live_liveRoom_forward_15s"), for: .highlighted)
        fowardBtn?.addTarget(self, action: #selector(fowardBtnClick(sender:)), for: .touchUpInside)
        otherBar?.addSubview(fowardBtn!)
        fowardBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((otherBar?.snp.centerX)!)
            make.centerY.equalTo((otherBar?.snp.centerY)!)
        })
        
        backBtn = UIButton()
        backBtn?.setImage(UIImage(named: "live_liveRoom_playback_15s"), for: .normal)
        backBtn?.setImage(UIImage(named: "live_liveRoom_playback_15s"), for: .highlighted)
        backBtn?.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        otherBar?.addSubview(backBtn!)
        backBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((otherBar?.snp.centerX)!).offset(-(kScreenW - 46.0) / 4)
            make.centerY.equalTo((otherBar?.snp.centerY)!)
        })
        
        downloadBtn = UIButton()
        downloadBtn?.setImage(UIImage(named: "live_liveRoom_audioDL_enable"), for: .normal)
        downloadBtn?.setImage(UIImage(named: "live_liveRoom_audioDL_enable"), for: .highlighted)
        downloadBtn?.addTarget(self, action: #selector(downloadBtnClick(sender:)), for: .touchUpInside)
        otherBar?.addSubview(downloadBtn!)
        downloadBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((otherBar?.snp.centerX)!).offset((kScreenW - 46.0) / 4)
            make.centerY.equalTo((otherBar?.snp.centerY)!)
        })
        
        progressBar = UIView()
        progressBar?.backgroundColor = RGBA(0, 0, 0, 0.5)
        self.addSubview(progressBar!)
        progressBar?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((imgView?.snp.centerX)!)
            make.bottom.equalTo((imgView?.snp.bottom)!)
            make.size.equalTo(CGSize(width: kScreenW - 46.0, height: 40.0))
        })
        
        playBtn = UIButton()
        playBtn?.setImage(UIImage(named: "live_liveroom_audience_play"), for: .normal)
        playBtn?.setImage(UIImage(named: "live_liveroom_audience_pause"), for: .selected)
        playBtn?.addTarget(self, action: #selector(playBtnClick(sender:)), for: .touchUpInside)
        progressBar?.addSubview(playBtn!)
        playBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((progressBar?.snp.centerY)!)
            make.left.equalTo((progressBar?.snp.left)!).offset(10.0)
        })
        
        leftTimeLabel = UILabel()
        leftTimeLabel?.text = "00:00:00"
        leftTimeLabel?.textColor = UIColor.white
        leftTimeLabel?.font = SystemFont(fontSize: 10)
        progressBar?.addSubview(leftTimeLabel!)
        leftTimeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((progressBar?.snp.centerY)!)
            make.left.equalTo((playBtn?.snp.right)!).offset(5.0)
        })
        
        rightTimeLabel = UILabel()
        rightTimeLabel?.text = "00:00:00"
        rightTimeLabel?.textColor = UIColor.white
        rightTimeLabel?.font = SystemFont(fontSize: 10)
        progressBar?.addSubview(rightTimeLabel!)
        rightTimeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((progressBar?.snp.centerY)!)
            make.right.equalTo((progressBar?.snp.right)!).offset(-5.0)
        })
        
        slider = UISlider()
        slider?.minimumTrackTintColor = hexString("#F52B34")
        slider?.maximumTrackTintColor = RGBA(255, 255, 255, 0.2)
        slider?.setThumbImage(UIImage(named: "live_liveRoom_progressPoint"), for: .normal)
        slider?.addTarget(self, action: #selector(doSeek(slider:)), for: .touchUpInside)
        slider?.addTarget(self, action: #selector(doHold(slider:)), for: .touchDown)
        progressBar?.addSubview(slider!)
        slider?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftTimeLabel?.snp.right)!).offset(5.0)
            make.right.equalTo((rightTimeLabel?.snp.left)!).offset(-5.0)
            make.centerY.equalTo((progressBar?.snp.centerY)!)
            make.height.equalTo(20.0)
        })
    }
}

extension TYSLiveAudioBackHeaderView {
    
    @objc private func fowardBtnClick(sender: UIButton) {
        delegate?.liveRoomHeader?(headerView: self, didClickFoward: sender)
    }
    
    @objc private func backBtnClick(sender: UIButton) {
        delegate?.liveRoomHeader?(headerView: self, didClickBack: sender)
    }
    
    @objc private func downloadBtnClick(sender: UIButton) {
        delegate?.liveRoomHeader?(headerView: self, didClickDownload: sender)
    }
    
    @objc private func playBtnClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            delegate?.liveRoomHeader?(headerView: self, didPlay: sender)
        } else {
            delegate?.liveRoomHeader?(headerView: self, didPause: sender)
        }
    }
    
    @objc private func doSeek(slider: UISlider) {
        delegate?.liveRoomHeader?(headerView: self, didSliderDoSeek: slider)
    }
    
    @objc private func doHold(slider: UISlider) {
        delegate?.liveRoomHeader?(headerView: self, didSliderDoHold: slider)
    }
}

extension TYSLiveAudioBackHeaderView {
    
}
