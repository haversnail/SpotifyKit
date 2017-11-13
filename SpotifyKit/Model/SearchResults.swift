//
//  SearchResults.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 9/20/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Search Results

/// A structure containing paged results for any albums, artists, tracks, or playlists returned by a search request.
public struct SKSearchResults: JSONDecodable {
    public let albums: Page<SKAlbum>?
    public let artists: Page<SKArtist>?
    public let tracks: Page<SKTrack>?
    public let playlists: Page<SKPlaylist>?
}

// MARK: - Search Result Types

/// An enumeration representing the types of SpotifyKit items returned by a search request.
public enum SKSearchResultType: String {
    case albums = "album"
    case artists = "artist"
    case tracks = "track"
    case playlists = "playlist"
}

extension SKSearchResultType: URLEncodable {}

extension Set where Element == SKSearchResultType {
    
    /// A convenience property containing all possible search result types: `.album`, `.artist`, `.track`, and `.playlist`.
    public static let all: Set<SKSearchResultType> = [.albums, .artists, .tracks, .playlists] // Consider using an OptionSet instead.
}

// MARK: - Search Filters

/// The fields by which a search request can be filtered.
public enum SKSearchFieldFilter {
    case album(String)
    case artist(String)
    case track(String)
    case genre(String)
    case year(DateInterval)
    case tag(SKSearchTag)
    case isrc(String)
    case upc(String)
}

// MARK: URLEncodable Properties

extension SKSearchFieldFilter {
    
    /// A makeshift `rawValue`.
    internal var key: String {
        switch self {
        case .album:  return "album"
        case .artist: return "artist"
        case .track:  return "track"
        case .genre:  return "genre"
        case .year:   return "year"
        case .tag:    return "tag"
        case .isrc:   return "isrc"
        case .upc:    return "upc"
        }
    }

    /// The associated value for the given case, returned as a URL-encodable type.
    internal var value: URLEncodable {
        switch self {
            case let .artist(keywords),
                 let .album(keywords),
                 let .track(keywords),
                 let .genre(keywords): return keywords.isEmpty ? "" : "\"" + keywords + "\""
            case let .isrc(code),
                 let .upc(code):       return code
            case let .tag(tag):        return tag
            case let .year(interval):  return interval
        }
    }
}

// MARK: Hashable Conformance

extension SKSearchFieldFilter: Hashable {
    public var hashValue: Int {
        return key.hashValue
    }
    
    /// - Note: Filters of the same type will be considered equal even if they contain different associated values.
    public static func ==(lhs: SKSearchFieldFilter, rhs: SKSearchFieldFilter) -> Bool {
        return lhs.key == rhs.key // Only compares keys; otherwise, set collections would ignore duplicated filters with different associated values.
    }
}

// MARK: - Search Tags

/// The tags available when filtering a search request.
public enum SKSearchTag: String {
    
    /// Retrieves albums released within the last two weeks.
    case new
    
    /// Retrieves albums with the lowest 10% popularity.
    case hipster
}

extension SKSearchTag: URLEncodable {}
