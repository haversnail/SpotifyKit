//
//  Album.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Supporting Types

/// - SeeAlso: https://spotify.github.io/ios-sdk/Constants/SPTAlbumType.html
public enum SKAlbumType: String, Codable {
    case album
    case single
    case appearance = "appears_on"
    case compilation
}

extension SKAlbumType: URLEncodable {}

public struct SKCopyright: Decodable {
    
    /// The types of copyrights that are provided by an `SKCopyright` instance.
    public enum CopyrightType: String, Codable {
        /// The copyright.
        case copyright = "C"
        /// The sound recording (performance) copyright.
        case performance = "P"
    }
    
    /// The copyright text for this album.
    public let text: String
    /// The type of copyright. See `SKCopyright.CopyrightType` for possible values.
    public let type: CopyrightType
}

public enum DatePrecision: String, Codable {
    case year
    case month
    case day
}

// MARK: - Album Protocol

public protocol Album {
    
    /// The type of album. See `SKAlbumType` for possible values.
    var albumType: SKAlbumType { get }
    
    /// The artists of the album. Each artist includes a link in `url` to more detailed information about the artist.
    /// - Note: This property is not guaranteed to be included in every album, and thus may be `nil` when retrieving albums from particular API endpoints.
    var artists: [SKArtist]? { get }
    
    /// The markets in which the album is available: [ISO 3166-1 alpha-2 country codes](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
    ///
    /// This property may be `nil` if the API request already specified a specific market from which to retrieve the album.
    var availableMarkets: [String]? { get }
    
    /// Known external URLs for this album. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    var externalURLs: [String: URL] { get }
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    var id: String { get }
    
    /// The cover art for the album in various sizes, widest first.
    var images: [SKImage] { get }
    
    /// The name of the album. In case of an album takedown, the value may be an empty string.
    var name: String { get }
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    var uri: String { get }
    
    /// A link to the Web API endpoint providing full details of the album.
    var url: URL { get }
    
    /// The copyright statements of the album.
    var copyrights: [SKCopyright]? { get }
    
    /// Known external IDs for the album.
    var externalIDs: [String: String]? { get }
    
    /// A list of the genres used to classify the album. For example: `"Prog Rock"`, `"Post-Grunge"`. (If not yet classified, the array is empty.)
    var genres: [String]? { get }
    
    /// The label for the album.
    var label: String? { get }
    
    /// The popularity of the album. The value will be between 0 and 100, with 100 being the most popular. The popularity is calculated from the popularity of the album's individual tracks.
    var popularity: Int? { get }
    
    /// The date the album was first released, for example `"1981-12-15"`. Depending on the precision, the date may have been returned as `"1981"` or `"1981-12"`. The precision for this value is provided by the `releaseDatePrecision` property.
    var releaseDate: Date? { get }
    
    /// The precision with which `releaseDate` value is known. See `DatePrecision` for possible values.
    var releaseDatePrecision: DatePrecision? { get }
    
    /// The tracks of the album.
    var tracks: Page<SKTrack>? { get }
}

// MARK: - Album Type

public struct SKAlbum: Album, JSONDecodable {
    
    /// An enum representing the expected `type` value for an album object.
    private enum ResourceType: String, Codable { case album }
    
    // MARK: Properties (Simplified)
    
    /// The resource object type: `"album"`.
    private let type: ResourceType

    public let albumType: SKAlbumType
    public let artists: [SKArtist]?
    public let availableMarkets: [String]?
    public let externalURLs: [String: URL]
    public let url: URL
    public let id: String
    public let images: [SKImage]
    public let name: String
    public let uri: String
    
    // MARK: Properties (Full)

    public let copyrights: [SKCopyright]?
    public let externalIDs: [String: String]?
    public let genres: [String]?
    public let label: String?
    public let popularity: Int?
    public let releaseDate: Date?
    public let releaseDatePrecision: DatePrecision?
    public let tracks: Page<SKTrack>?
}

// MARK: Custom Decoding

extension SKAlbum: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case copyrights
        case externalIDs = "external_ids"
        case externalURLs = "external_urls"
        case genres
        case url = "href"
        case id
        case images
        case label
        case name
        case popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case tracks
        case type
        case uri
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Verify the type of JSON object we're decoding first:
        type = try values.decode(ResourceType.self, forKey: .type)
        
        // Properties (Simplified)
        albumType = try values.decode(SKAlbumType.self, forKey: .albumType)//, toCase: .lowercase)
        artists = try values.decodeIfPresent([SKArtist].self, forKey: .artists)
        availableMarkets = try values.decodeIfPresent([String].self, forKey: .availableMarkets)
        externalURLs = try values.decode([String: URL].self, forKey: .externalURLs)
        url = try values.decode(URL.self, forKey: .url)
        id = try values.decode(String.self, forKey: .id)
        images = try values.decode([SKImage].self, forKey: .images)
        name = try values.decode(String.self, forKey: .name)
        uri = try values.decode(String.self, forKey: .uri)
        
        // Properties (Full)
        copyrights = try values.decodeIfPresent([SKCopyright].self, forKey: .copyrights)
        externalIDs = try values.decodeIfPresent([String: String].self, forKey: .externalIDs)
        genres = try values.decodeIfPresent([String].self, forKey: .genres)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        popularity = try values.decodeIfPresent(Int.self, forKey: .popularity)
        releaseDatePrecision = try values.decodeIfPresent(DatePrecision.self, forKey: .releaseDatePrecision)
        tracks = try values.decodeIfPresent(Page<SKTrack>.self, forKey: .tracks)
        
        // Release Date
        guard let dateString = try values.decodeIfPresent(String.self, forKey: .releaseDate) else {
            releaseDate = nil
            return
        }
        let formatter = DateFormatter()
        switch releaseDatePrecision! {
        case .year: formatter.dateFormat = "yyyy"
        case .month: formatter.dateFormat = "yyyy-MM"
        case .day: formatter.dateFormat = "yyyy-MM-dd"
        }
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        releaseDate = formatter.date(from: dateString)
    }
}

// MARK: Expandable Conformance

extension SKAlbum: Expandable {
    
    public var isSimplified: Bool {
        return
            copyrights == nil &&
                externalIDs == nil &&
                genres == nil &&
                label == nil &&
                popularity == nil &&
                releaseDate == nil &&
                releaseDatePrecision == nil &&
                tracks == nil
    }
}

// MARK: - Saved Album Type

public struct SKSavedAlbum: Album, JSONDecodable {
    
    /// The date and time the album was saved.
    public let dateAdded: Date
    
    /// The nested album.
    private let album: SKAlbum
    
    // MARK: Album Properties
    
    public var albumType: SKAlbumType               { return album.albumType }
    public var artists: [SKArtist]?                 { return album.artists }
    public var availableMarkets: [String]?          { return album.availableMarkets }
    public var externalURLs: [String : URL]         { return album.externalURLs }
    public var id: String                           { return album.id }
    public var images: [SKImage]                    { return album.images }
    public var name: String                         { return album.name }
    public var uri: String                          { return album.uri }
    public var url: URL                             { return album.url }
    public var copyrights: [SKCopyright]?           { return album.copyrights }
    public var externalIDs: [String : String]?      { return album.externalIDs }
    public var genres: [String]?                    { return album.genres }
    public var label: String?                       { return album.label }
    public var popularity: Int?                     { return album.popularity }
    public var releaseDate: Date?                   { return album.releaseDate }
    public var releaseDatePrecision: DatePrecision? { return album.releaseDatePrecision }
    public var tracks: Page<SKTrack>?               { return album.tracks }
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case dateAdded = "added_at"
        case album
    }
}
