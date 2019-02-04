//
//  CocoaCutterTests.swift
//  CocoaCutterTests
//
//  Created by Thomas Bonk on 02.02.19.
//  Copyright © 2019 Thomas Bonk Softwareentwicklung. All rights reserved.
//

import XCTest

class CocoaCutterTests: XCTestCase {
    private var otrEmail: String!
    private var otrPassword: String!

    override func setUp() {
        otrEmail = ProcessInfo.processInfo.environment["OTR_EMAIL"]
        otrPassword = ProcessInfo.processInfo.environment["OTR_PASSWORD"]
    }

    override func tearDown() {
    }

    func testOtrDecoderCreation() {
        let _ = OtrDecoder(email: otrEmail, password: otrPassword)
            
        XCTAssert(true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
