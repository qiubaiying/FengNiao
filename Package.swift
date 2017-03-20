import PackageDescription

let package = Package(
    name: "FengNiao",
    targets:[
        Target(name: "FengNiaoKit", dependencies: []),
        Target(name: "FengNiao", dependencies: ["FengNiaoKit"])
        
    ],
    dependencies: [
        .Package(url:"https://github.com/jatoben/CommandLine", "3.0.0-pre1"),
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2),
        .Package(url: "https://github.com/kylef/PathKit", majorVersion: 0, minor: 8),
        .Package(url: "https://github.com/kylef/Spectre.git", majorVersion: 0, minor: 7)
    ],

    // TestDependencies: [] 测试依赖库,不参与 release 的编译,暂时被去掉了, swift4 应该可以修复
    
    exclude: ["Tests/Fixtures"]
)
