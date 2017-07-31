//
//  Recommendations.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Recommendations Object

public struct SKRecommendations: JSONDecodable { // TODO: Make JSON Codable.
    
    /// An array of recommendation seed objects.
    public let seeds: [SKSeed]
    
    /// An array of simplified tracks, ordered according to the parameters supplied.
    public let tracks: [SKTrack]
}

// MARK: - Recommendations Seed Object

public struct SKSeed: JSONDecodable { // TODO: Make JSON Codable.
    
    public enum SeedType: String, Codable {
        case artist// = "ARTIST"
        case genre// = "GENRE"
        case track// = "TRACK"
    }

    /// The number of tracks available after `min*` and `max*` filters have been applied.
    public let afterFilteringSize: Int
    
    /// The number of tracks available after relinking for regional availability.
    public let afterRelinkingSize: Int
    
    /// The number of recommended tracks available for this seed.
    public let initialPoolSize: Int
    
    /// The id used to select this seed. This will be the same as the string used in the `seed_artists`, `seed_tracks` or `seed_genres` request parameter.
    public let id: String
    
    /// The entity type of this seed. One of `artist`, `track` or `genre`.
    public let type: SeedType
    
    /// A link to the full track or artist data for this seed. For tracks, this will be a link to a full track object; for artists, a link to a full artist object; for genre seeds, this value will be `nil`.
    public let url: URL?
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case afterFilteringSize
        case afterRelinkingSize
        case url = "href"
        case id
        case initialPoolSize
        case type
    }
}
