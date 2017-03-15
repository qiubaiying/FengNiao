//
//  StringsSearch.swift
//  FengNiao
//
//  Created by Jack on 17/3/15.
//
//

import Foundation

protocol sreingsSearcher {
    func search(in comtent: String) -> Set<String>
}

protocol RegexStringsSearcher: sreingsSearcher {
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
                result.insert(extracted.plainName)
                
            }
            
        }
        
        return result
    }
}


