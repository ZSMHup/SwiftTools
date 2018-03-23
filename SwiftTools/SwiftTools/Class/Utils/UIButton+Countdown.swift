//
//  UIButton+Countdown.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

extension UIButton {
    /** 倒计时，s倒计 */
    public func countdownWithSec(sec: Int) {
        var tempSecond = sec
        let queue = DispatchQueue.global(qos: .default)
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(wallDeadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            if tempSecond <= 1 {
                timer.cancel()
                DispatchQueue.main.async {
                    self.isEnabled = true
                    self.setTitle("| 重新获取", for: .normal)
                }
            } else {
                tempSecond -= 1
                DispatchQueue.main.async {
                    self.isEnabled = false
                    self.setTitle("| \(tempSecond)s后重获取", for: .normal)
                }
            }
        }
        timer.resume()
    }
}

