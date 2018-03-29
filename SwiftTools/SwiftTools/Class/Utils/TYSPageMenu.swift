//
//  TYSPageMenu.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

enum AYPageMenuTrackerStyle: Int {
    case line = 0               // 下划线,默认与item等宽
    case lineLongerThanItem     // 下划线,比item要长(长度为item的宽+间距)
    case lineAttachment         // 下划线依恋样式
    case textZoom               // 文字缩放
    case roundedRect            // 圆角矩形
    case rect                   // 矩形
}

enum AYPageMenuPermutationWay: Int {
    case scrollAdaptContent = 0     // 自适应内容,可以左右滑动
    case notScrollEqualWidths       // 等宽排列,不可以滑动,整个内容被控制在pageMenu的范围之内,等宽是根据pageMenu的总宽度对每个item均分
    case notScrollAdaptContent      // 自适应内容,不可以滑动,整个内容被控制在pageMenu的范围之内,这种排列方式下,自动计算item之间的间距,itemPadding属性设置无效
}

enum AYItemImagePosition {
    case `default`    // 默认图片在左边
    case left       // 图片在左边
    case top        // 图片在上面
    case right      // 图片在右边
    case bottom     // 图片在下面
}

class TYSPageMenu: UIView {

    var trackerStyle: AYPageMenuTrackerStyle?
    var _items: [String]?
    var _selectedItemIndex: Int?
    var insert: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func pageMenu(trackerStyle: AYPageMenuTrackerStyle) -> TYSPageMenu {
        let pageMenu = TYSPageMenu()
        pageMenu.frame = frame
        pageMenu.backgroundColor = UIColor.red
        pageMenu.trackerStyle = trackerStyle
        return pageMenu
    }
    
    /// 传递数组(数组元素只能是String)
    ///
    /// - Parameters:
    ///   - items: 数组
    ///   - selectedItemIndex: 选中哪个item
    func setItems(items: [String], selectedItemIndex: Int) {
        _items = items
        _selectedItemIndex = selectedItemIndex
        
        for item in items {
            print(item)
            
        }
        
    }
    
    

}

extension TYSPageMenu {
    private func addButton(index: Int, object: String, animated: Bool) {
        
    }
}



















