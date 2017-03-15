//
//  Extensions.swift
//  FengNiao
//
//  Created by Jack on 17/3/15.
//
//

import Foundation
import PathKit


extension String {
    /// 获取string range
    var fullRange: NSRange {
        return NSMakeRange(0, utf8.count)
    }
    
    /// 获取去掉后缀的图片名
    var plainName: String {
        let p = Path(self)
        // 去掉扩展名
        var result = p.lastComponentWithoutExtension
        
        if result.hasSuffix("@2x") || result.hasSuffix("@3x") {
        
            result = String(describing: result.utf16.dropLast(3))
        }
        return result
    }
    
}
