//
//  FengNiaoKitSpec.swift
//  FengNiao
//
//  Created by BaiYing on 2017/3/17.
//
//

import Foundation
import Spectre
@testable import FengNiaoKit

public func specFengNiaoKit() {

    describe("FengNiao") {
        
        
        $0.describe("String Extenion") {
            
            $0.it("should return plain name") {
                let s1 = "image@2x.tmp"
                let s2 = "/usr/local/bin/find"
                let s3 = "image@3X.png"
                let s4 = "local.host"
                let s5 = "local.host.png"
                
                let exts = ["png"]
                
                try expect(s1.plainName(extensions: exts)) == "image@2x.tmp"
                try expect(s2.plainName(extensions: exts)) == "find"
                try expect(s3.plainName(extensions: exts)) == "image"
                try expect(s4.plainName(extensions: exts)) == "local.host"
                try expect(s5.plainName(extensions: exts)) == "local.host"
            }

        }
        
        $0.describe("String Searchers") {
            $0.it("Swift searcher works") {
                let s1 = "UIImage(named:\"my_image\")"
                let s2 = "adfsasd \"aa\" sdfsd\"_ksdf\""
                let s3 = "let name = \"close_button@2x\"/nlet image = UIImage(named: name)"
                let s4 = "test String: \"local.png\""
                let s5 = "test String: \"local.host\""
                
                let exts = ["png"]
                
                let seacher = SwiftSearcher(extensions: exts)
                let result = [s1, s2, s3, s4, s5].map { seacher.search(in: $0) }
                
                try expect(result[0]) == Set(["my_image"])
                try expect(result[1]) == Set(["aa", "_ksdf"])
                try expect(result[2]) == Set(["close_button"])
                try expect(result[3]) == Set(["local"])
                try expect(result[4]) == Set(["local.host"])
            }
        }
    }
}
