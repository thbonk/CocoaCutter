//
//  Credentials.swift
//  CocoaCutter
//
//  Created by Thomas Bonk on 09.02.19.
//  Copyright © 2019 Thomas Bonk Softwareentwicklung. All rights reserved.
//

import Foundation
import KeychainAccess

@objc class Credentials: NSObject {
    
    // MARK: - Private Properties
    
    private var keychain = Keychain(accessGroup: "CocoaCutter")
    
    
    // MARK: - Properties
    
    private let otrEmailKey = "OTR_EMAIL"
    @objc public var otrEmail: String? {
        set {
            willChangeValue(for: \.otrEmail)
            keychain[otrEmailKey] = newValue
            didChangeValue(for: \.otrEmail)
        }
        get {
            return keychain[otrEmailKey] as String?
        }
    }
    
    private let otrPasswordKey = "OTR_PASSWORD"
    @objc public var otrPassword: String? {
        set {
            willChangeValue(for: \.otrPassword)
            keychain[otrPasswordKey] = newValue
            didChangeValue(for: \.otrPassword)
        }
        get {
            return keychain[otrPasswordKey] as String?
        }
    }
    
    private let cutlistAtKeyKey = "CUTLISTAT_KEY"
    @objc public var cutlistAtKey: String? {
        set {
            willChangeValue(for: \.cutlistAtKey)
            keychain[cutlistAtKeyKey] = newValue
            didChangeValue(for: \.cutlistAtKey)
        }
        get {
            return keychain[cutlistAtKeyKey] as String?
        }
    }
}
