//
//  Category.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/26/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKCategory: JSONDecodable { // TODO: Make JSON Codable.

    /// A link to the Web API endpoint returning full details of the category.
    public let url: URL
    
    /// The category icon, in various sizes.
    public let icons: [SKImage]
    
    /// The [Spotify category ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) of the category.
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
