//
//  Errors.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2018 Alex Havermale.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

let errorData = """
{
  "error": {
    "status": 401,
    "message": "The access token expired"
  }
}
""".data(using: .utf8)!
    
let authenticationErrorData = """
{
    "error": "invalid_client",
    "error_description": "Invalid client secret"
}
""".data(using: .utf8)!
