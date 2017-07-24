//
//  TrackLink.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKTrackLink: JSONDecodable { // TODO: Make JSON Codable.

    /// Known external URLs for this track.
    public let externalURLs: [String: String] // FIXME: Change to [String: URL(?)] once JSONDecoder bug is fixed.
    
    /// A link to the Web API endpoint providing full details of the track.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    public let id: String
    
    // The object type: "track"
    //public let type: SKTrack.Type
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    public let uri: String
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case url = "href"
        case id
        //case type
        case uri
    }
}
