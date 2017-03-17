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
    
    /// 获取去掉后缀及@2x@3x的图片名
    func plainName(extensions: [String]) -> String {
        let p = Path(self.lowercased())// A -> a
        var result: String
        
        // 去掉扩展名
        if let ext = p.extension, extensions.contains(ext) {
            result = p.lastComponentWithoutExtension
        } else {
            result = p.lastComponent
        }
        
        if result.hasSuffix("@2x") || result.hasSuffix("@3x") {
            
            result = String(describing: result.utf16.dropLast(3))
        }
        return result
    }
    
    
}
