//
//  OtrDecoderTests.swift
//  CocoaCutterTests
//
//  Created by Thomas Bonk on 02.02.19.
//  Copyright © 2019 Thomas Bonk Softwareentwicklung. All rights reserved.
//

import XCTest

class OtrDecoderTests: XCTestCase {
    private var otrEmail: String!
    private var otrPassword: String!

    override func setUp() {
        // OTREMAIL and OTRPASSWORD needs to be in environment variables,
        // e.g. locally in /etc/launchd.conf:
        // setenv OTREMAIL email
        // setenv OTRPASSWORD password
        otrEmail = ProcessInfo.processInfo.environment["OTREMAIL"]
        otrPassword = ProcessInfo.processInfo.environment["OTRPASSWORD"]
    }

    override func tearDown() {
    }

    func testOtrDecoderCreation() {
        let _ = OtrDecoder(email: otrEmail, password: otrPassword)
            
        XCTAssert(true)
    }
    
    func testDecodeFile() {
        let decoder = OtrDecoder(email: otrEmail, password: otrPassword)
        
        //decoder.decode(file: "/Users/thomas/Projects/macOS/CocoaCutter/CocoaCutterTests/testdata/Tagesschau_19.02.01_20-00_ard_15_TVOON_DE.mpg.mp4.otrkey")
    }

}
