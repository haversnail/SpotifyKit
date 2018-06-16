//
//  Recommendations.swift
//  SpotifyKit
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

// MARK: Recommendations Type

/// A structure representing a list of recommended tracks generated from a list of Spotify seed items.
///
/// - SeeAlso: The Web API [Recommendations](https://developer.spotify.com/documentation/web-api/reference/object-model/#recommendations-object) object.
public struct SKRecommendations: JSONDecodable {
    
    /// The seeds used to generate the list of recommended tracks.
    public let seeds: [SKSeed]
    
    /// An array of simplified tracks, ordered according to the parameters supplied.
    public let tracks: [SKTrack]
}

// MARK: - Recommendations Seed Type

/// A structure representing a Spotify media item used to generate a list of recommended tracks.
///
/// - SeeAlso: The Web API [Recommendations Seed](https://developer.spotify.com/documentation/web-api/reference/object-model/#recommendations-seed-object) object.
public struct SKSeed: JSONDecodable {
    
    public enum SeedType: String, Codable {
        case artist
        case genre
        case track
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
    
    /// A link to the full track or artist data for this seed. For tracks, this will be a link to a full track; for artists, a link to a full artist; for genre seeds, this value will be `nil`.
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
