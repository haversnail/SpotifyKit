//
//  Constants.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 9/17/17.
//  Copyright © 2017 Alex Havermale.
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

internal struct Constants {
    private init() {}
    static let baseURL = URL(string: "https://api.spotify.com")!
    static let accountsURL = URL(string: "https://accounts.spotify.com")!
    static let tokenType = "Bearer"
    static let maxImageSize = 256000 // 256 KB
    
    // MARK: - HTTP Header Fields
    
    struct HeaderFields {
        private init() {}
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        //static let matchETag = "If-None-Match"
    }
    
    // MARK: - URL Query Parameters
    
    struct QueryParameters {
        private init() {}
        static let ids = "ids"
        static let uris = "uris"
        static let query = "q"
        static let country = "country"
        static let market = "market"
        static let locale = "locale"
        static let limit = "limit"
        static let offset = "offset"
        static let before = "before"
        static let after = "after"
        static let position = "position"
        static let type = "type"
        static let albumType = "album_type"
        static let timeRange = "time_range"
        static let timestamp = "timestamp"
        static let seedArtists = "seed_artists"
        static let seedGenres = "seed_genres"
        static let seedTracks = "seed_tracks"
        static let minPrefix = "min_"
        static let maxPrefix = "max_"
        static let targetPrefix = "target_"
    }
    
    // MARK: URL Request Bodies
    
    struct RequestBodies {
        private init() {}
        
        struct PlaylistDetailsBody: JSONCodable {
            let name: String?
            let description: String?
            let isPublic: Bool?
            let isCollaborative: Bool?

            private enum CodingKeys: String, CodingKey {
                case name
                case description
                case isPublic = "public"
                case isCollaborative = "collaborative"
            }
        }
        
        struct PlaylistFollowBody: JSONCodable {
            let isPublic: Bool
            
            private enum CodingKeys: String, CodingKey {
                case isPublic = "public"
            }
        }
        
        struct RemoveTracksBody: JSONCodable {
            struct Track: Codable {
                let uri: String
                //let positions: [Int]? // Not supporting this.
            }
            
            let tracks: [Track]?
            let positions: [Int]?
            let snapshotID: String?
            
            private enum CodingKeys: String, CodingKey {
                case tracks
                case positions
                case snapshotID = "snapshot_id"
            }
        }
        
        struct ReorderTracksBody: JSONCodable {
            let startIndex: Int
            let rangeLength: Int?
            let newIndex: Int
            let snapshotID: String?
            
            private enum CodingKeys: String, CodingKey {
                case startIndex = "range_start"
                case rangeLength = "range_length"
                case newIndex = "insert_before"
                case snapshotID = "snapshot_id"
            }
        }
        
        struct TransferPlaybackBody: JSONCodable {
            let deviceIDs: [String]
            let forcePlayback: Bool?
            
            private enum CodingKeys: String, CodingKey {
                case deviceIDs = "device_ids"
                case forcePlayback = "play"
            }
        }
    }
    
    // MARK: - API Endpoints
    
    struct Endpoints {
        private init() {}
        private static let version = "v1"
        
        static var albums: String             { return version/"albums" }
        static var artists: String            { return version/"artists" }
        static var audioAnalysis: String      { return version/"audio-analysis" }
        static var audioFeatures: String      { return version/"audio-features" }
        static var featuredPlaylists: String  { return version/"browse/featured-playlists" }
        static var newReleases: String        { return version/"browse/new-releases" }
        static var categories: String         { return version/"browse/categories" }
        static var me: String                 { return version/"me" }
        static var recommendations: String    { return version/"recommendations" }
        static var search: String             { return version/"search" }
        static var tracks: String             { return version/"tracks" }
        static var users: String              { return version/"users" }
        
        static var myFollows: String          { return me/"following" }
        static var mySavedAlbums: String      { return me/"albums" }
        static var mySavedTracks: String      { return me/"tracks" }
        static var myTopArtists: String       { return me/"top/artists" }
        static var myTopTracks: String        { return me/"top/tracks" }
        static var myPlaylists: String        { return me/"playlists" }
        static var player: String             { return me/"player" }
        
        static var checkIfFollowing: String   { return myFollows/"contains" }
        static var checkIfAlbumsSaved: String { return mySavedAlbums/"contains" }
        static var checkIfTracksSaved: String { return mySavedTracks/"contains" }
        
        static var recentlyPlayed: String     { return player/"recently-played" }
        static var currentlyPlaying: String   { return player/"currently-playing" }
        static var devices: String            { return player/"devices" }
        static var play: String               { return player/"play" }
        static var pause: String              { return player/"pause" }
        static var next: String               { return player/"next" }
        static var previous: String           { return player/"previous" }
        static var seek: String               { return player/"seek" }
        static var volume: String             { return player/"volume" }
        static var shuffle: String            { return player/"shuffle" }
        static var `repeat`: String           { return player/"repeat" }
        
        static var genres: String             { return recommendations/"available-genre-seeds" }
        
        static func album(id: String) -> String                   { return albums/id }
        static func tracksForAlbum(id: String) -> String          { return albums/id/"tracks" }
        static func artist(id: String) -> String                  { return artists/id }
        static func albumsForArtist(id: String) -> String         { return artists/id/"albums" }
        static func topTracksForArtist(id: String) -> String      { return artists/id/"top-tracks" }
        static func relatedArtistsForArtist(id: String) -> String { return artists/id/"related-artists" }
        static func audioAnalysisForTrack(id: String) -> String   { return audioAnalysis/id }
        static func audioFeaturesForTrack(id: String) -> String   { return audioFeatures/id }
        static func category(id: String) -> String                { return categories/id }
        static func playlistsForCategory(id: String) -> String    { return categories/id/"playlists" }
        static func track(id: String) -> String                   { return tracks/id }
        static func user(id: String) -> String                    { return users/id }
        
        private static let playlists = "playlists"
        static func playlistsForUser(id: String) -> String                            { return users/id/playlists }
        static func playlist(id: String, ownerID: String) -> String                   { return users/ownerID/playlists/id }
        static func imageForPlaylist(id: String, ownerID: String) -> String           { return users/ownerID/playlists/id/"images" }
        static func tracksForPlaylist(id: String, ownerID: String) -> String          { return users/ownerID/playlists/id/"tracks" }
        static func followsForPlaylist(id: String, ownerID: String) -> String         { return users/ownerID/playlists/id/"followers" }
        static func checkIfUsersFollowPlaylist(id: String, ownerID: String) -> String { return users/ownerID/playlists/id/"followers/contains" }
    }
}

extension String {
    fileprivate static func /(lhs: String, rhs: String) -> String {
        return lhs + "/" + rhs
    }
}

//extension RawRepresentable where RawValue == String {
//    fileprivate static func /(lhs: Self, rhs: Self) -> String {
//        return lhs.rawValue + "/" + rhs.rawValue
//    }
//
//    fileprivate static func /(lhs: String, rhs: Self) -> String {
//        return lhs + "/" + rhs.rawValue
//    }
//
//    fileprivate static func /(lhs: Self, rhs: String) -> String {
//        return lhs.rawValue + "/" + rhs
//    }
//}
