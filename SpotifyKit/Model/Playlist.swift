//
//  Playlist.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKPlaylist: JSONDecodable { // TODO: Make JSON Codable.
    
    // MARK: - Embedded Types
    
    public struct PlaylistTrack: Decodable { // Rename to PlaylistItem? // TODO: Make Codable.
        
        /// The date and time the track was added.
        /// - Note: Some very old playlists may return `nil` in this field.
        public let dateAdded: Date?
        
        /// The Spotify user who added the track.
        /// - Note: Some very old playlists may return `nil` in this field.
        public let userAdded: SKUser?
        
        /// Whether this track is a [local file](https://developer.spotify.com/web-api/local-files-spotify-playlists/) or not.
        public let isLocal: Bool
        
        /// Information about the track.
        public let track: SKTrack
        
        // MARK: Keys
        
        private enum CodingKeys: String, CodingKey {
            case dateAdded = "added_at"
            case userAdded = "added_by"
            case isLocal = "is_local"
            case track
        }
    }

    // MARK: - Object Properties (Simplified)
    
    /// `true` if the owner allows other users to modify the playlist.
    public let isCollaborative: Bool
    
    /// Known external URLs for this playlist.
    public let externalURLs: [String: String] // FIXME: Change to [String: URL(?)] once JSONDecoder bug is fixed.

    /// A link to the Web API endpoint providing full details of the playlist.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the playlist.
    public let id: String
    
    /// Images for the playlist. The array may be empty or contain up to three images. The images are returned by size in descending order. See [Working with Playlists](https://developer.spotify.com/web-api/working-with-playlists/).
    /// - Note: If returned, the source URL for the image (`url`) is temporary and will expire in less than a day.
    public let images: [SKImage]
    
    /// The name of the playlist.
    public let name: String
    
    /// The user who owns the playlist.
    public let owner: SKUser
    
    /// The playlist's public/private status: `true` the playlist is public, `false` the playlist is private, `nil` the playlist status is not relevant. For more about public/private status, see [Working with Playlists](https://developer.spotify.com/web-api/working-with-playlists/).
    public let isPublic: Bool?
    
    /// The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version.
    public let snapshotID: String?
    
    /// A collection containing a link (`url`) to the Web API endpoint where full details of the playlist's tracks can be retrieved, along with the total number of tracks in the playlist.
    public let tracks: PagedCollection<PlaylistTrack> // Change to `playlistItems`? `tracks` seems like a bit of a misnomer. // TODO: Consider renaming.
    
    // The object type: "playlist"
    //public let type: SKPlaylist.Typem
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the playlist.
    public let uri: String
    
    // MARK: - Object Properties (Full)
    
    /// The playlist description. Only returned for modified, verified playlists, otherwise `nil`.
    public let userDescription: String?
    
    /// Information about the followers of the playlist.
    public let followers: SKFollowers?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case isCollaborative = "collaborative"
        case userDescription = "description"
        case externalURLs = "external_urls"
        case followers
        case url = "href"
        case id
        case images
        case name
        case owner
        case isPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks
        //case type
        case uri
    }
}
