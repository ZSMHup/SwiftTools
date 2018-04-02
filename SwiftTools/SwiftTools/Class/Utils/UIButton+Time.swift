//
//  UIButton+Time.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

extension UIButton {
    public func buttonTimer(sec: Double) {
        var tempSecond = sec
        let queue = DispatchQueue.global(qos: .default)
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(wallDeadline: .now(), repeating: 1)
        timer.setEventHandler {
            if tempSecond <= 0.5 {
                timer.cancel()
                DispatchQueue.main.async {
                    self.isEnabled = true
                }
            } else {
                tempSecond -= 0.5
                DispatchQueue.main.async {
                    self.isEnabled = false
                }
            }
        }
        timer.resume()
    }
}
