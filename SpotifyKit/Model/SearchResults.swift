//
//  SearchResults.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 9/20/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Search Results

/// An object containing paged results for any albums, artists, tracks, or playlists returned by a search request.
public struct SKSearchResults: JSONDecodable {
    public let albums: Page<SKAlbum>?
    public let artists: Page<SKArtist>?
    public let tracks: Page<SKTrack>?
    public let playlists: Page<SKPlaylist>?
}

// MARK: - Search Result Types

/// An enumeration representing the types of SpotifyKit objects returned by a search request.
public enum SKSearchResultType: String, URLEncodable {
    case albums = "album"
    case artists = "artist"
    case tracks = "track"
    case playlists = "playlist"
}

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
    
    internal var key: String { // a makeshift "rawValue"
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
}

// MARK: - Search Tags

/// The tags available when filtering a search request.
public enum SKSearchTag: String {
    
    /// Retrieves albums released within the last two weeks.
    case new
    
    /// Retrieves albums with the lowest 10% popularity.
    case hipster
}
