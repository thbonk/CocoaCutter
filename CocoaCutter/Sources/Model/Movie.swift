//
//  Movie.swift
//  CocoaCutter
//
//  Created by Thomas Bonk on 07.02.19.
//  Copyright © 2019 Thomas Bonk Softwareentwicklung. All rights reserved.
//

import Cocoa

@objc class Movie: NSObject {
    
    // MARK: - Enums
    
    enum FileType {
        case Unknown
        case OtrKey
        case Avi
        case HqAvi
        case Mp4
    }
    
    enum Status {
        case NoError
        case NotAMovie
        case DecodeError
        case NoCutlists
        case ErrorLoadingCutlist
    }
    
    
    // MARK: - Properties
    
    @objc dynamic public private(set) var qualifiedFilename: String!
    
    @objc dynamic public var fileName: String {
        return NSString(string: qualifiedFilename).lastPathComponent
    }
    
    @objc dynamic public var targetPath: String!
    
    public var fileSize: UInt64? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: qualifiedFilename)
            return (attributes[FileAttributeKey.size] as! UInt64)
        } catch {
            return nil
        }
    }
    
    public var fileType: FileType {
        var fileType: FileType = .Unknown
        let fn = fileName.uppercased()
        
        if fn.hasSuffix(".MP4") {
            fileType = .Mp4
        } else if fn.hasSuffix(".HQ.AVI") {
            fileType = .HqAvi;
        } else if fn.hasSuffix(".AVI") {
            fileType = .Avi;
        } else if fn.hasSuffix(".OTRKEY") {
            fileType = .OtrKey;
        }
        
        return fileType;
    }
    
    public var status: Status!
    
    
    // MARK: - Initialization
    
    public init(withQualifiedFilename qualifiedFilename: String) {
        super.init()
        
        self.qualifiedFilename = qualifiedFilename
        self.status = self.fileType == .Unknown ? .NotAMovie : .NoError
        self.targetPath = NSString(string: qualifiedFilename).deletingLastPathComponent
    }

}
