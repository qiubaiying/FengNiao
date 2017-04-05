import Foundation
import PathKit
import Rainbow

enum FileType {
    case swift
    case objc
    case xib
    
    init?(ext:String) {
        switch ext.lowercased() {
        case "swift": self = .swift
        case "mm", "m": self = .objc
        case "xib", "storybrod": self = .xib
        default: return nil
        }
    }
    
    func searcher(extensions: [String]) -> stringsSearcher {
        switch self {
        case .swift: return SwiftSearcher(extensions: extensions)
        case .objc: return ObjCSearcher(extensions: extensions)
        case .xib: return XibSearcher(extensions: extensions)

        }
    }
}

public struct FileInfo {
    let path: String
}

public struct FengNiao {
    
    let projectPath: Path
    let excludePaths: [Path]
    let resouceExtenions: [String]
    let fileExtenions: [String]
    
    public init(projectPath: String, excludePaths: [String],resouceExtenions: [String], fileExtenions: [String]) {
        
        let path = Path(projectPath).absolute()
        self.projectPath = path
        self.excludePaths = excludePaths.map{path + Path($0)}
        self.resouceExtenions = resouceExtenions
        self.fileExtenions = fileExtenions
    }
    
    public func unuserdResource() -> [FileInfo] {
        fatalError()
    }
    
    public func allStringsInUse() -> Set<String> {
        return stringsInUse(at: projectPath)
    }
    
    func stringsInUse(at path: Path) -> Set<String> {
        guard let subPaths = try? path.children() else {
            print("path reading error.\(path)".red)
            return []
        }
        
        var result = [String]()
        /// 过滤文件
        for subPath in subPaths{
            // 隐藏文件
            if subPath.lastComponent.hasPrefix(".") {
                continue
            }
            
            if excludePaths.contains(subPath) {
                continue
            }
            
            if subPath.isDirectory {
                result.append(contentsOf: stringsInUse(at: subPath))
            } else {
                let fileExt = subPath.extension ?? ""
                guard fileExtenions.contains(fileExt) else {
                    continue
                }
                
                let searcher: stringsSearcher
                if let fileType = FileType(ext: fileExt) {
                    searcher = fileType.searcher(extensions: fileExtenions)
                } else {
                    searcher = GeneralSearcher(extensions: fileExtenions)
                }
                
                let content = (try? subPath.read()) ?? ""
                result.append(contentsOf: searcher.search(in: content))
            }
        }
        
        return Set(result)
    }
    
    
    func resourcesInUse() -> [String: String] {
        let process = FindProcess(path: <#T##Path#>, extenstions: <#T##[String]#>, excludes: <#T##[Path]#>)
    }
    
    
    public func delete() -> () {
        fatalError()
        
    }
}
