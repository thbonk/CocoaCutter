//
//  OtrDecoder.swift
//  CocoaCutter
//
//  Created by Thomas Bonk on 02.02.19.
//  Copyright 2019 Thomas Bonk <thomas@meandmymac.de>
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

/**
 This class wraps the otrdecoder executable to decode .otrkey files.
 */
@objc class OtrDecoder: NSObject {
    
    // MARK: - Properties
    
    private var email: String
    private var password: String
    
    private var decoderBinaryPath: String {
        return Bundle.main.path(forResource: "otrdecoder", ofType: nil)!
    }
    
    
    // MARK: - Initialization
    
    public convenience init(credentials: Credentials) {
        self.init(email: credentials.otrEmail!, password: credentials.otrPassword!)
    }

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    
    // MARK: - Decoding
    
    public func decode(
        _ movie: Movie,
        verifyOtrKeys: Bool = false,
        forceOverwritingOfFiles: Bool = false,
        progress: ((Int) -> ())? = nil,
        completion: ((Bool) -> ())? = nil) {
        
        DispatchQueue(label: "decode_\(movie.fileName)", qos: .background).async {
            let process = Process()
            let pipe = Pipe()
            
            process.standardOutput = pipe
            process.standardError = process.standardOutput
            process.launchPath = self.decoderBinaryPath
            process.arguments = self.argumentsFor(
                movie: movie,
                verifyOtrKeys: verifyOtrKeys,
                forceOverwritingOfFiles: forceOverwritingOfFiles)
            
            NotificationCenter
                .default
                .addObserver(
                    forName: FileHandle.readCompletionNotification,
                    object: pipe.fileHandleForReading,
                    queue: OperationQueue.main,
                    using: { notification in
                        self.readStandardOutput(notification, progress: progress)
                })
            pipe.fileHandleForReading.readInBackgroundAndNotify()
            
            process.terminationHandler = { process in
                DispatchQueue.main.async {
                    completion?(
                        process.terminationReason == .exit && process.terminationStatus == 0)
                }
            }
            
            process.launch()
        }
    }
    
    @objc public func readStandardOutput(
        _ notification: Notification, progress: ((Int) -> ())? = nil) {
        
        if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? Data {
            if data.count > 0 {
                if let progressStr = String(data: data, encoding: .utf8) {
                    let digitsSet = CharacterSet(charactersIn: "0123456789")
                    let percent = "%"
                    let scanner = Scanner(string: progressStr)
                    var progressPercent: Int = 0
                    
                    while !scanner.isAtEnd {
                        let prefixDecoding = progressStr.hasPrefix("Decoding...")
                        var rc = true
                        
                        rc = rc && scanner.scanUpToCharacters(from: digitsSet, into: nil)
                        rc = rc && (scanner.scanInt(&progressPercent) || prefixDecoding)
                        rc = rc && (scanner.scanString(percent, into: nil) || prefixDecoding)
                        
                        if rc {
                            progress?(progressPercent)
                        }
                    }
                }
            }
        }
    }
    
    private func argumentsFor(
        movie: Movie, verifyOtrKeys: Bool, forceOverwritingOfFiles: Bool) -> [String] {
        
        var arguments = [
            "-i", movie.qualifiedFilename!,
            "-o", movie.targetPath!,
            "-e", email,
            "-p", password
        ]
        
        if verifyOtrKeys {
            arguments.append("-q")
        }
        
        if forceOverwritingOfFiles {
            arguments.append("-f")
        }
        
        return arguments
    }
}
