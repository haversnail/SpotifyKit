//
//  Category.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/26/17.
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

/// A Spotify category representing the genres and moods available in the Spotify catalog.
///
/// - SeeAlso: The Web API [Category](https://developer.spotify.com/documentation/web-api/reference/object-model/#category-object) object.
public struct SKCategory: JSONDecodable {

    /// A link to the Web API endpoint returning full details of the category.
    public let url: URL
    
    /// The category icon, in various sizes.
    public let icons: [SKImage]
    
    /// The [Spotify category ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) of the category.
    public let id: String
    
    /// The name of the category.
    public let name: String
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case icons
        case id
        case name
    }
}
