//
//  Playlist.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKPlaylist: JSONDecodable {
    
    /// An enum representing the expected `type` value for a playlist object.
    private enum ObjectType: String, Codable { case playlist }

    // MARK: - Object Properties (Simplified)
    
    /// `true` if the owner allows other users to modify the playlist.
    public let isCollaborative: Bool
    
    /// Known external URLs for this playlist.
    public let externalURLs: [String: URL]

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
    public let snapshotID: String
    
    /// A link to the Web API endpoint where full details of the playlist's tracks can be retrieved.
    public let tracksURL: URL
    
    /// The total number of tracks in the playlist.
    public let totalTracks: Int
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the playlist.
    public let uri: String
    
    /// The object type: `"playlist"`.
    private let type: ObjectType
    
    // MARK: - Object Properties (Full)
    
    /// A collection containing information about the tracks of the playlist.
    public let tracks: Page<SKPlaylistTrack>?
    
    /// The playlist description. Only returned for modified, verified playlists, otherwise `nil`.
    public let userDescription: String?
    
    /// Information about the followers of the playlist.
    public let followers: SKFollowers?
}

// MARK: - Custom Decoding

extension SKPlaylist: Decodable {
    
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
        case type
        case uri
    }
    
    /// Used for simplified playlist objects, when the entire collection of tracks is not returned.
    private struct SimplifiedTracks: Decodable {
        
        /// A link to the Web API endpoint where full details of the playlist's tracks can be retrieved.
        public let url: URL
        
        /// The total number of tracks in the playlist.
        public let total: Int
        
        private enum CodingKeys: String, CodingKey {
            case url = "href"
            case total
        }
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Verify the type of object we're decoding first:
        type = try values.decode(ObjectType.self, forKey: .type)

        isCollaborative = try values.decode(Bool.self, forKey: .isCollaborative)
        externalURLs = try values.decode([String: URL].self, forKey: .externalURLs)
        url = try values.decode(URL.self, forKey: .url)
        uri = try values.decode(String.self, forKey: .uri)
        id = try values.decode(String.self, forKey: .id)
        images = try values.decode([SKImage].self, forKey: .images)
        name = try values.decode(String.self, forKey: .name)
        owner = try values.decode(SKUser.self, forKey: .owner)
        isPublic = try values.decodeIfPresent(Bool.self, forKey: .isPublic)
        snapshotID = try values.decode(String.self, forKey: .snapshotID)
        userDescription = try values.decodeIfPresent(String.self, forKey: .userDescription)
        followers = try values.decodeIfPresent(SKFollowers.self, forKey: .followers)
        
        // Handle both simplified and full "tracks" objects:
        tracks = try? values.decode(Page<SKPlaylistTrack>.self, forKey: .tracks)
        tracksURL = try tracks?.url ?? values.decode(SimplifiedTracks.self, forKey: .tracks).url
        totalTracks = try tracks?.total ?? values.decode(SimplifiedTracks.self, forKey: .tracks).total
    }
}

// MARK: - Expandable Conformance

extension SKPlaylist: Expandable {
    
    public var isSimplified: Bool {
        return
            userDescription == nil &&
            followers == nil &&
            tracks == nil
    }
}

// MARK: - Featured Playlists

/// An object containing a paginated collection of featured playlists, accompanied by a localized message from Spotify.
public struct SKFeaturedPlaylists: JSONDecodable {
    public let localizedMessage: String
    public let playlists: Page<SKPlaylist>
    
    private enum CodingKeys: String, CodingKey {
        case localizedMessage = "message"
        case playlists
    }
}
