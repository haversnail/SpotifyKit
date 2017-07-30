//
//  Errors.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var errorData: Data {
        return """
        {
          "error": {
            "status": 401,
            "message": "The access token expired"
          }
        }
        """.data(using: .utf8)!
    }
    
    var authenticationErrorData: Data {
        return """
        {
            "error": "invalid_client",
            "error_description": "Invalid client secret"
        }
        """.data(using: .utf8)!
    }
}
