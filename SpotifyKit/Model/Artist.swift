//
//  Artist.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKArtist: JSONDecodable { // TODO: Make JSON Codable.
    
    // MARK: - Object Properties (Simplified)
    
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
    
    // MARK: - Object Properties (Full)
    
    /// Information about the followers of the artist.
    public let followers: SKFollowers?
    
    /// A list of the genres the artist is associated with. For example: `"Prog Rock"`, `"Post-Grunge"`. (If not yet classified, the array is empty.)
    public let genres: [String]?
    
    /// Images of the artist in various sizes, widest first.
    public let images: [SKImage]?
    
    /// The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks.
    public let popularity: Int?
    
    /// A boolean value indicating whether this `SKArtist` instance is a simplified version of the Spotify artist object (i.e., it does *not* contain any of the values unique to the full version of the object).
    public var isSimplified: Bool {
        return
            followers == nil &&
            genres == nil &&
            images == nil &&
            popularity == nil
    }
    
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
        //case type
        case uri
    }
}
