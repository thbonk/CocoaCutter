//
//  MovieTests.swift
//  CocoaCutterTests
//
//  Created by Thomas Bonk on 09.02.19.
//  Copyright © 2019 Thomas Bonk Softwareentwicklung. All rights reserved.
//

import XCTest

class MovieTests: XCTestCase {

    /*Unknown
     case OtrKey
     case Avi
     case HqAvi
     case Mp4*/
    
    func test_filetype_is_Unknown() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.mov")
        
        XCTAssert(movie.fileType == .Unknown, "Movie has rong fileType")
    }
    
    func test_filetype_is_OtrKey() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.avi.otrkey")
        
        XCTAssert(movie.fileType == .OtrKey, "Movie has rong fileType")
    }
    
    func test_filetype_is_Avi() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.avi")
        
        XCTAssert(movie.fileType == .Avi, "Movie has rong fileType")
    }
    
    func test_filetype_is_HqAvi() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.hq.avi")
        
        XCTAssert(movie.fileType == .HqAvi, "Movie has rong fileType")
    }
    
    func test_filetype_is_Mp4() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.mp4")
        
        XCTAssert(movie.fileType == .Mp4, "Movie has rong fileType")
    }
    
    func test_initial_status_is_NoError() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.mp4")
        
        XCTAssert(movie.status == .NoError, "Movie status is wrong")
    }
    
    func test_initial_status_with_unknown_filetype_is_NotAMovie() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.mov")
        
        XCTAssert(movie.status == .NotAMovie, "Movie status is wrong")
    }
    
    func test_initial_targetpath_is_correct() {
        let movie = Movie(withQualifiedFilename: "/Media/movie.mp4.otrkey")
        
        XCTAssert(movie.targetPath == "/Media", "target path is wrong")
    }

}
