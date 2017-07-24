//
//  Album.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKAlbum: JSONDecodable { // TODO: Make JSON Codable.
    
    // MARK: - Embedded Types
    
    public enum AlbumType: String, Codable {
        case album
        case single
        case compilation
    }
    
    public enum DatePrecision: String, Codable {
        case year
        case month
        case day
    }
    
    public struct Copyright: Codable {
        
        /// The types of copyrights that are provided by an `SKCopyright` object.
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
    
    // MARK: - Object Properties (Simplified)
    
    /// The type of album. See `SKAlbum.AlbumType` for possible values.
    public let albumType: AlbumType
    
    /// The artists of the album. Each artist object includes a link in `url` to more detailed information about the artist.
    public let artists: [SKArtist]
    
    /// The markets in which the album is available: [ISO 3166-1 alpha-2 country codes](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
    ///
    /// This property may be `nil` if the API request already specified a specific market from which to retrieve the album.
    public let availableMarkets: [String]? // String will only always hold two characters. TODO: Change to a more performant data type.
    
    /// Known external URLs for this album. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-id-object) for more details.
    public let externalURLs: [String: String] // FIXME: Change to [String: URL(?)] once JSONDecoder bug is fixed.
    
    /// A link to the Web API endpoint providing full details of the album.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    public let id: String
    
    /// The cover art for the album in various sizes, widest first.
    public let images: [SKImage]
    
    /// The name of the album. In case of an album takedown, the value may be an empty string.
    public let name: String
    
    // The object type: "album"
    //public let type: SKAlbum.Type
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    public let uri: String
    
    // MARK: - Object Properties (Full)

    /// The copyright statements of the album.
    public let copyrights: [Copyright]?
    
    /// Known external IDs for the album.
    public let externalIDs: [String: String]?
    
    /// A list of the genres used to classify the album. For example: `"Prog Rock"`, `"Post-Grunge"`. (If not yet classified, the array is empty.)
    public let genres: [String]?
    
    /// The label for the album.
    public let label: String?
    
    /// The popularity of the album. The value will be between 0 and 100, with 100 being the most popular. The popularity is calculated from the popularity of the album's individual tracks.
    public let popularity: Int?
    
    /// The date the album was first released, for example `"1981-12-15"`. Depending on the precision, it might be shown as `"1981"` or `"1981-12"`.
    /// - Note: Since this date string must be formatted conditionally, this property is maintained at the `private` scope and is used in conjunction with `releaseDatePrecision` to provide an accurate public `Date` object representation of this value.
    private let _releaseDate: String?
    
    /// The date the album was first released. The precision for this value is provided by the `releaseDatePrecision` property.
    public var releaseDate: Date? {
        get {
            guard _releaseDate != nil, releaseDatePrecision != nil else { return nil }
            
            let formatter = DateFormatter()
            switch releaseDatePrecision! {
                case .year: formatter.dateFormat = "yyyy"
                case .month: formatter.dateFormat = "yyyy-MM"
                case .day: formatter.dateFormat = "yyyy-MM-dd"
            }
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter.date(from: _releaseDate!)
        }
    }
    
    /// The precision with which `releaseDate` value is known. See `SKAlbum.DatePrecision` for possible values.
    public let releaseDatePrecision: DatePrecision?
    
    /// The tracks of the album.
    public let tracks: Paging<SKTrack>?
    
    /// A boolean value indicating whether this `SKAlbum` instance is a simplified version of the Spotify album object (i.e., it does *not* contain any of the values unique to the full version of the object).
    public var isSimplified: Bool {
        return
            copyrights == nil &&
            externalIDs == nil &&
            genres == nil &&
            label == nil &&
            popularity == nil &&
            _releaseDate == nil &&
            releaseDatePrecision == nil &&
            tracks == nil
    }
    
    // MARK: - Keys
    
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
        case _releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case tracks
        //case type
        case uri
    }
}