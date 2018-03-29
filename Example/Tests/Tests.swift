// https://github.com/Quick/Quick

import XCTest
@testable import ReSwiftConsumer

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSample() {
        XCTAssertTrue("test".lengthOfBytes(using: String.Encoding.utf8) == 4)
    }
}
