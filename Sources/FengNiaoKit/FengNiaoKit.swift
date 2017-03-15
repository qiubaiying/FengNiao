import Foundation
import PathKit


public struct FileInfo {
    let path: String
}

public struct FengNiao {
    
    let projectPath: Path
    let exculudePaths: [Path]
    let resouceExtenions: [String]
    let fileExtenions: [String]
    
    public init(projectPath: String, exculudePaths: [String],resouceExtenions: [String], fileExtenions: [String]) {
        
        let path = Path(projectPath).absolute()
        self.projectPath = path
        self.exculudePaths = exculudePaths.map{path + Path($0)}
        self.resouceExtenions = resouceExtenions
        self.fileExtenions = fileExtenions
    }
    
    public func unuserdResource() -> [FileInfo] {
        fatalError()
    }
    
    
    func stringInUse() -> [String]{
        
        
        return []
    }
    
    func resourcesInUse() -> [String: String] {
        fatalError()
    }
    
    public func delete() -> () {
        fatalError()
    }
}
