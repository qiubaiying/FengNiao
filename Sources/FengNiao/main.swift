import Foundation
import CommandLineKit
import Rainbow
import FengNiaoKit

let cli = CommandLineKit.CommandLine()

let prejectOption = StringOption(shortFlag: "p", longFlag: "project", required: true,
                                 helpMessage: "Path to the output file.")
let excludePathsOption = MultiStringOption(shortFlag: "e", longFlag: "exclude",
                                     helpMessage: "Excluded paths which should not search in.")
let resourceExtensionsOption = MultiStringOption(shortFlag: "r", longFlag: "resource-extensions",
                          helpMessage: "Extensions to search.")
let fileExtensionsOption = MultiStringOption(shortFlag: "f", longFlag: "file-extensions",
                                             helpMessage: "File extensions to search to with.")
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")


cli.addOptions(prejectOption, resourceExtensionsOption, fileExtensionsOption, help)

// 使用Rainbow设置shell输出颜色
cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.lightBlue
    default:
        str = s
    }
    
    return cli.defaultFormat(s: str, type: type)
}

// fix
do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if help.value {
    cli.printUsage()
    exit(EX_OK)
}

let project = prejectOption.value ?? "."

let resourceExtensions = resourceExtensionsOption.value ?? ["png", "jpg", "imageset"]

let fileExtenions = fileExtensionsOption.value ?? ["swift", "m", "mm", "xib", "stroyboard"]

let exculdedPaths = excludePathsOption.value ?? []







