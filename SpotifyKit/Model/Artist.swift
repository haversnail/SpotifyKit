//
//  Artist.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
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

public struct SKArtist: JSONDecodable {
    
    // MARK: - Embedded Types
    
    /// An enum representing the expected `type` value for an artist object.
    private enum ResourceType: String, Codable { case artist }
    
    // MARK: - Properties (Simplified)
    
    /// Known external URLs for this artist. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    public let externalURLs: [String: URL]
    
    /// A link to the Web API endpoint providing full details of the artist.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artist.
    public let id: String
    
    /// The name of the artist.
    public let name: String
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    public let uri: String
    
    /// The resource object type: `"artist"`.
    private let type: ResourceType
    
    // MARK: - Properties (Full)
    
    /// Information about the followers of the artist.
    public let followers: SKFollowers?
    
    /// A list of the genres the artist is associated with. For example: `"Prog Rock"`, `"Post-Grunge"`. (If not yet classified, the array is empty.)
    public let genres: [String]?
    
    /// Images of the artist in various sizes, widest first.
    public let images: [SKImage]?
    
    /// The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks.
    public let popularity: Int?
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case followers
        case genres
        case url = "href"
        case id
        case images
        case name
        case popularity
        case type
        case uri
    }
}

// MARK: - Expandable Conformance

extension SKArtist: Expandable {
    
    public var isSimplified: Bool {
        return
            followers == nil &&
            genres == nil &&
            images == nil &&
            popularity == nil
    }
}

// MARK: - Cursor Pageable Conformance

extension SKArtist: CursorPageable {
    public typealias CursorType = String
}
