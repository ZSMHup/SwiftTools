//
//  TYSRequestModel.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import HandyJSON

class TYSRequestModel: HandyJSON {
    var statusCode: String?
    var msg: String?
    var responseResultList = [TYSRequestModel]()
    var object = [TYSRequestModel]()
    var responseResultString: String?
    
    required init() {
        
    }
}


