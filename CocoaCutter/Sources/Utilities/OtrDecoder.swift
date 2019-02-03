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
class OtrDecoder {
    
    // MARK: - Properties
    
    private var email: String
    private var password: String
    
    
    // MARK: - Initialization
    
    /**
     Initializer that receives the email and the password to decode files.
     - Parameters
        - email     the email address registered at OnlineTVReceorder
        - password  the password
     */
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
