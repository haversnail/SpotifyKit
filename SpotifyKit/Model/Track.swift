//
//  Track.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKTrack: JSONDecodable {
    
    // MARK: - Embedded Types
    
    private enum ObjectType: String, Codable { case track }
    
    public enum ContentRating: Int {
        case explicit
        case clean
        case unknown
    }
    
    public struct TrackLink: Decodable {
        
        /// Known external URLs for this track. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
        public let externalURLs: [String: URL]
        
        /// A link to the Web API endpoint providing full details of the track.
        public let url: URL
        
        /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
        public let id: String
        
        /// The object type: `"track"`.
        private let type: ObjectType
        
        /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
        public let uri: String
        
        // MARK: Keys
        
        private enum CodingKeys: String, CodingKey {
            case externalURLs = "external_urls"
            case url = "href"
            case id
            case type
            case uri
        }
    }
    
    // MARK: - Object Properties (Simplified)

    /// The artists who performed the track. Each artist object includes a link in `url` to more detailed information about the artist.
    public let artists: [SKArtist]
    
    /// A list of the countries in which the track can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
    ///
    /// This property may be `nil` if the API request already specified a specific market from which to retrieve the track.
    public let availableMarkets: [String]? // String will only always hold two characters. TODO: Change to a more performant data type.
    
    /// The disc number (usually `1` unless the album consists of more than one disc).
    public let discNumber: Int
    
    /// The track length in milliseconds.
    /// - Note: As most Apple frameworks and interfaces use the `TimeInterval` type for properties like this, and since most `TimeInterval` properties refer to seconds, this property is maintained at the `private` scope and is used to provide a more compatible public "duration" property.
    private let _duration: Int
    
    /// The track length in seconds, with millsecond precision.
    public var duration: TimeInterval { return TimeInterval(_duration) / 1000 }
    
    /// From the [Web API](https://developer.spotify.com/web-api/object-model/#track-object-simplified) docs: "Whether or not the track has explicit lyrics (`true` = yes it does; `false` = no it does not OR unknown)."
    /// - Note: Because this property's respective JSON value could be `NULL` or "unknown," an optionally-wrapped Boolean type for this attribute seems confusing. Instead, this property is maintained at the `private` scope and is used to provide a more expressive, type-safe "Content Rating" property. See `SKTrack.ContentRating` for possible values.
    private let _isExplicit: Bool? // TODO: Test for "unknown" values.
    
    /// The content rating of the track, indicating whether the lyrics are explicit. See `SKTrack.ContentRating` for possible values.
    public var contentRating: ContentRating {
        switch _isExplicit {
            case .some(true): return .explicit
            case .some(false): return .clean
            case .none: return .unknown
        }
    }
    
    /// Known external URLs for this track.
    public let externalURLs: [String: URL]
    
    /// A link to the Web API endpoint providing full details of the track.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    public let id: String
    
    /// Part of the object when [Track Relinking](https://developer.spotify.com/web-api/track-relinking-guide/) is applied. If `true`, the track is playable in the given market. Otherwise `false`.
    public let isPlayable: Bool?
    
    /// Part of the object when [Track Relinking](https://developer.spotify.com/web-api/track-relinking-guide/) is applied and is only part of the object if the track linking, in fact, exists (meaning that the requested track has been replaced with a different track). The resource identifiers and locators in the `TrackLink` object contain information about the originally requested track.
    public let linkedTrack: TrackLink?
    
    /// The name of the track.
    public let name: String
    
    /// A URL to a 30-second preview (MP3 format) of the track. `nil` if not available.
    public let previewURL: URL?
    
    /// The number of the track. If an album has several discs, the track number is the number on the specified disc.
    public let trackNumber: Int
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    public let uri: String
    
    /// The object type: `"track"`.
    private let type: ObjectType
    
    // MARK: - Object Properties (Full)
    
    /// The album on which the track appears. The album object includes a link in `url` to full information about the album.
    public let album: SKAlbum?
    
    /// Known external IDs for the track.
    public let externalIDs: [String: String]?
    
    /// The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.
    ///
    /// The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
    ///
    /// Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Duplicate tracks (e.g. the same track from a single and an album) are rated independently. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.
    public let popularity: Int?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case _duration = "duration_ms"
        case _isExplicit = "explicit"
        case externalIDs = "external_ids"
        case externalURLs = "external_urls"
        case url = "href"
        case id
        case isPlayable = "is_playable"
        case linkedTrack = "linked_from"
        case name
        case popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
    }
}

// MARK: - Expandable Conformance

extension SKTrack: Expandable {
    
    public var isSimplified: Bool {
        return
            album == nil &&
            externalIDs == nil &&
            popularity == nil
    }
}

// MARK: - User Savable Extension

extension SKTrack: UserSavable {}
