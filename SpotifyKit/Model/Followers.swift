//
//  Followers.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale.
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

public struct SKFollowers: JSONDecodable {
    
    /// A link to the Web API endpoint providing full details of the followers; `nil` if not available. Please note that this will always be set to `nil`, as the Web API does not support it at the moment.
    public let url: URL?
    
    /// The total number of followers.
    public let total: Int

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case total
    }
}
