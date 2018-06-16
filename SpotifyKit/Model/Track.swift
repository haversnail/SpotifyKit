//
//  Track.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
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

// MARK: Supporting Types

/// An enum representing the expected `type` value for a track object.
fileprivate enum ResourceType: String, Codable { case track }

/// An enumeration value representing the content rating for a Spotify media item, such as a track.
public enum SKContentRating: Int {
    
    /// The item does not contain any explicit lyrics.
    case clean
    
    /// The item contains explicit lyrics.
    case explicit
    
    /// The item does not indicate whether it contains explicit lyrics.
    case unknown
}

/// A structure representing the links to a relinked Spotify track. See the API [Track Relinking](https://developer.spotify.com/documentation/general/guides/track-relinking-guide/) guide for more details.
///
/// - SeeAlso: The Web API [Track Link](https://developer.spotify.com/documentation/web-api/reference/object-model/#track-link) object.
public struct SKTrackLinks: Decodable {
    
    /// The resource object type: `"track"`.
    private let type: ResourceType

    /// Known external URLs for this track. See ["external URL object"](https://developer.spotify.com/documentation/web-api/reference/object-model/#external-url-object) for more details.
    public let externalURLs: [String: URL]
    
    /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    public let id: String
    
    /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    public let uri: String
    
    /// A link to the Web API endpoint providing full details of the track.
    public let url: URL
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case url = "href"
        case id
        case type
        case uri
    }
}

// MARK: - Track Protocol

/// A type representing a Spotify track.
///
/// The `Track` protocol serves as the base protocol to which all Spotify track types conform. Its requirements include properties for both "simplified" and "full" versions of a Spotify track. See the Spotify Web API [Object Model](https://developer.spotify.com/documentation/web-api/reference/object-model/#track-object-full) for more details.
public protocol Track {
    
    /// The artists who performed the track. Each artist includes a link in `url` to more detailed information about the artist.
    var artists: [SKArtist] { get }
    
    /// A list of the countries in which the track can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
    ///
    /// This property may be `nil` if the API request already specified a specific market from which to retrieve the track.
    var availableMarkets: [String]? { get }
    
    /// The content rating of the track, indicating whether the lyrics are explicit, clean, or unknown.
    var contentRating: SKContentRating { get }
    
    /// The disc number (usually `1` unless the album consists of more than one disc).
    var discNumber: Int { get }
    
    /// The track length in seconds, with millsecond precision.
    var duration: TimeInterval { get }
    
    /// Known external URLs for this track.
    var externalURLs: [String: URL] { get }
    
    /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    var id: String { get }
    
    /// A Boolean value that is available when [Track Relinking](https://developer.spotify.com/documentation/general/guides/track-relinking-guide/) is applied. If `true`, the track is playable in the given market. Otherwise `false`.
    var isPlayable: Bool? { get }
    
    /// The name of the track.
    var name: String { get }
    
    /// A URL to a 30-second preview (MP3 format) of the track. `nil` if not available.
    var previewURL: URL? { get }
    
    /// A value that is available when [Track Relinking](https://developer.spotify.com/documentation/general/guides/track-relinking-guide/) is applied and is only available if the track linking, in fact, exists (meaning that the requested track has been replaced with a different track). The resource identifiers and locators in the `TrackLink` instance contain information about the originally requested track.
    var trackLinks: SKTrackLinks? { get }
    
    /// The number of the track. If an album has several discs, the track number is the number on the specified disc.
    var trackNumber: Int { get }
    
    /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    var uri: String { get }
    
    /// A link to the Web API endpoint providing full details of the track.
    var url: URL { get }
    
    /// The album on which the track appears. The album includes a link in `url` to full information about the album.
    var album: SKAlbum? { get }
    
    /// Known external IDs for the track.
    var externalIDs: [String: String]? { get }
    
    /// The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.
    ///
    /// The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
    ///
    /// Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Duplicate tracks (e.g. the same track from a single and an album) are rated independently. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.
    var popularity: Int? { get }
}

// MARK: - Track Type

/// A Spotify track.
///
/// - SeeAlso: The Web API [Simplified](https://developer.spotify.com/documentation/web-api/reference/object-model/#track-object-simplified) and [Full](https://developer.spotify.com/documentation/web-api/reference/object-model/#track-object-full) Track objects.
public struct SKTrack: Track, JSONDecodable {
    
    // MARK: Simplified Track Properties
    
    /// The resource object type: `"track"`.
    private let type: ResourceType
    
    /// The track length in milliseconds.
    /// - Note: As most Apple frameworks and interfaces use the `TimeInterval` type for properties like this, and since most `TimeInterval` properties refer to seconds, this property is maintained at the `private` scope and is used to provide a more compatible public "duration" property.
    private let _duration: Int
    
    public var duration: TimeInterval { return TimeInterval(_duration) / 1000 }
    
    /// From the [Web API](https://developer.spotify.com/documentation/web-api/reference/object-model/#track-object-simplified) docs: "Whether or not the track has explicit lyrics (`true` = yes it does; `false` = no it does not OR unknown)."
    /// - Note: Because this property's respective JSON value could be `NULL` or "unknown," an optionally-wrapped Boolean type for this attribute seems confusing. Instead, this property is maintained at the `private` scope and is used to provide a more expressive, type-safe "Content Rating" property. See `SKTrack.ContentRating` for possible values.
    private let _isExplicit: Bool?
    
    public var contentRating: SKContentRating {
        switch _isExplicit {
            case .some(true): return .explicit
            case .some(false): return .clean
            case .none: return .unknown
        }
    }
    
    public let artists: [SKArtist]
    public let availableMarkets: [String]?
    public let discNumber: Int
    public let externalURLs: [String: URL]
    public let id: String
    public let isPlayable: Bool?
    public let name: String
    public let previewURL: URL?
    public let trackLinks: SKTrackLinks?
    public let trackNumber: Int
    public let uri: String
    public let url: URL
    
    // MARK: Full Track Properties
    
    public let album: SKAlbum?
    public let externalIDs: [String: String]?
    public let popularity: Int?

    // MARK: Keys
    
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
        case trackLinks = "linked_from"
        case name
        case popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
    }
}

// MARK: Expandable Conformance

extension SKTrack: Expandable {
    
    public var isSimplified: Bool {
        return
            album == nil &&
            externalIDs == nil &&
            popularity == nil
    }
}

// MARK: - Playlist Track Type

/// A Spotify track that has been added to a Spotify playlist.
///
/// - SeeAlso: The Web API [Playlist Track](https://developer.spotify.com/documentation/web-api/reference/object-model/#playlist-track-object) object.
public struct SKPlaylistTrack: Track, JSONDecodable {
    
    /// The date and time the track was added.
    /// - Note: Some very old playlists may return `nil` in this field.
    public let dateAdded: Date?
    
    /// The Spotify user who added the track.
    /// - Note: Some very old playlists may return `nil` in this field.
    public let userAdded: SKUser?
    
    /// Whether this track is a [local file](https://developer.spotify.com/documentation/general/guides/local-files-spotify-playlists/) or not.
    public let isLocal: Bool
    
    /// The nested track.
    private let track: SKTrack
    
    // MARK: Track Properties
    
    public var artists: [SKArtist]              { return track.artists }
    public var availableMarkets: [String]?      { return track.availableMarkets }
    public var contentRating: SKContentRating   { return track.contentRating }
    public var discNumber: Int                  { return track.discNumber }
    public var duration: TimeInterval           { return track.duration }
    public var externalURLs: [String : URL]     { return track.externalURLs }
    public var isPlayable: Bool?                { return track.isPlayable }
    public var id: String                       { return track.id }
    public var uri: String                      { return track.uri }
    public var url: URL                         { return track.url }
    public var trackLinks: SKTrackLinks?          { return track.trackLinks }
    public var name: String                     { return track.name }
    public var previewURL: URL?                 { return track.previewURL }
    public var trackNumber: Int                 { return track.trackNumber }
    public var album: SKAlbum?                  { return track.album }
    public var externalIDs: [String : String]?  { return track.externalIDs }
    public var popularity: Int?                 { return track.popularity }
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case dateAdded = "added_at"
        case userAdded = "added_by"
        case isLocal = "is_local"
        case track
    }
}

// MARK: - Saved Track Type

/// A Spotify track that has been saved to the current authenticated user's music library.
///
/// - SeeAlso: The Web API [Saved Track](https://developer.spotify.com/documentation/web-api/reference/object-model/#saved-track-object) object.
public struct SKSavedTrack: Track, JSONDecodable {
    
    /// The date and time the track was saved.
    public let dateAdded: Date
    
    /// The nested track.
    private let track: SKTrack
    
    // MARK: Track Properties
    
    public var artists: [SKArtist]              { return track.artists }
    public var availableMarkets: [String]?      { return track.availableMarkets }
    public var contentRating: SKContentRating   { return track.contentRating }
    public var discNumber: Int                  { return track.discNumber }
    public var duration: TimeInterval           { return track.duration }
    public var externalURLs: [String : URL]     { return track.externalURLs }
    public var isPlayable: Bool?                { return track.isPlayable }
    public var id: String                       { return track.id }
    public var uri: String                      { return track.uri }
    public var url: URL                         { return track.url }
    public var trackLinks: SKTrackLinks?          { return track.trackLinks }
    public var name: String                     { return track.name }
    public var previewURL: URL?                 { return track.previewURL }
    public var trackNumber: Int                 { return track.trackNumber }
    public var album: SKAlbum?                  { return track.album }
    public var externalIDs: [String : String]?  { return track.externalIDs }
    public var popularity: Int?                 { return track.popularity }
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case dateAdded = "added_at"
        case track
    }
}
