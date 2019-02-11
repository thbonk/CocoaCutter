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
    
    func test_decoding_file_is_successful() {
        let decoder = OtrDecoder(email: otrEmail, password: otrPassword)
        let movie = Movie(withQualifiedFilename: "")
        let decodingFinished = XCTestExpectation(description: "Decode file")
        var progress: Int = 0
        var successful: Bool = true
        
        decoder.decode(
            movie,
            progress: { percentage in
                progress = percentage
            },
            completion: { success in
                successful = success
                decodingFinished.fulfill()
            })
        
        wait(for: [decodingFinished], timeout: 240.0)
        
        XCTAssert(progress == 100, "Progress is 100%")
        XCTAssert(successful, "Decoding was successful")
    }

}
