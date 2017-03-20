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
import PathKit

public func specFengNiaoKit() {

    describe("FengNiao") {
        
        let fixtures = Path(#file).parent().parent() + "Fixtures"
        
        // 测试 String 处理
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
        
        // 测试 String Searchers
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
        
        $0.describe("FengNiaoKit Function") {
            
            let path = fixtures + "StringSearcher"
            
            $0.it("should find used string in swift") {
                
                let fengniao = FengNiao(projectPath: path.string, excludePaths: [], resouceExtenions: ["png", "jpg"], fileExtenions: ["swift"])
                let result = fengniao.allStringsInUse()

                let expectd: Set<String> = ["common.login",
                                            "common.logout",
                                            "live_btn_connect",
                                            "live_btn_connect",
                                            "name_key",
                                            "无法支持"]
                try expect(result) == expectd
            }
            
            $0.it("should find used string in objc") {
                let fengniao = FengNiao(projectPath: path.string, excludePaths: [], resouceExtenions: ["png", "jpg"], fileExtenions: ["m", "mm"])
                let result = fengniao.allStringsInUse()
                
                let expectd: Set<String> = ["image",
                                            "image-from-mm.jpg",
                                            "c",
                                            "name-of-mm",
                                            "info.error.memory.full.confirm",
                                            "info.error.memory.full.ios"]
                try expect(result) == expectd
            }
        }
    }
}
