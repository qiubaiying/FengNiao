import XCTest
@testable import FengNiaoKit

class FengNiaoKitTest: XCTestCase {
    
    func testFirstCase() {
        let a = 1 + 2
        XCTAssert(a == 3, "a = 3")
    }

    func testStringPlainNameExtensions() {

        let s1 = "image@2x.png"
        let s2 = "/usr/local/bin/find"
        
        XCTAssertEqual(s1.plainName, "image")
        XCTAssertEqual(s2.plainName, "find")
    }
}
