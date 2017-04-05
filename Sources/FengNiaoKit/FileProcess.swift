//
//  FileProcess.swift
//  FengNiao
//
//  Created by BaiYing on 2017/3/20.
//
//

import Foundation
import PathKit

struct FindProcess {
    
    let p: Process
    init?(path: Path, extenstions: [String], excludes: [Path]) {
        p = Process()
        p.launchPath = "/usr/bin/find"
        
        guard !extenstions.isEmpty else {
          return nil
        }
        
        var args = [String]()
        args.append(path.string)
        
        for (i, ext) in extenstions.enumerated() {
            if i == 0 {
                args.append("(")
            } else {
                args.append("-or")
            }
            args.append("-name")
            args.append("*.\(ext)")
            
            if i == extenstions.count - 1 {
                args.append(")")
            }
        }
        
        for excludePath in excludes{
            args.append("-not")
            args.append("-path")
            
            let filePath = path + excludePath
            
            guard filePath.exists else {
                continue
            }
            
            if filePath.isDirectory {
                args.append("\(filePath.string)")
            } else {
                args.append(filePath.string)
            }
        }
        
        p.arguments = args
        
    }
    
    
    func execute() -> Set<String> {
        let pipe = Pipe()
        p.standardOutput = pipe
        
        let fileHandler = pipe.fileHandleForReading
        p.launch()
        
        let data = fileHandler.readDataToEndOfFile()
        if let string = String(data: data, encoding: .utf8) {
            return Set(string.components(separatedBy: "\n").dropLast())
        } else {
            return []
        }
    }
    
}
