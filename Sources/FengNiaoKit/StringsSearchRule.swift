//
//  StringsSearch.swift
//  FengNiao
//
//  Created by Jack on 17/3/15.
//
//

import Foundation

protocol stringsSearcher {
    func search(in comtent: String) -> Set<String>
}

/// 正则表达式搜索
protocol RegexStringsSearcher: stringsSearcher {
    var extensions: [String] { get }
    var patterns: [String] { get }
}

extension RegexStringsSearcher {
    
     func search(in content: String) -> Set<String> {
        
        var result = Set<String>()
        
        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)")
                continue
            }
            
            let metches = regex.matches(in: content, options: [], range: content.fullRange)
            for checkingResult in metches {
                let renge = checkingResult.rangeAt(1)
                let extracted = NSString(string: content).substring(with: renge)
                result.insert(extracted.plainName(extensions: extensions))
                
            }
            
        }
        
        return result
    }
}

struct SwiftSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["\"(.+?)\""]
}

struct ObjCSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["@\"(.+?)\"", "\"(.+?)\""]
}

struct XibSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["image name=\"(.+?)\""]
}

struct GeneralSearcher: RegexStringsSearcher {
    let extensions: [String]
    var patterns: [String] {
        if extensions.isEmpty {
            return []
        }
        
        let joined = extensions.joined(separator: "|")
        return ["\"(.+?)\\.(\(joined))\""]
    }
}
