//
//  RecentTrack.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 11/6/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A recently played Spotify track.
///
/// - SeeAlso: The Web API [Play History](https://developer.spotify.com/web-api/object-model/#play-history-object) object.
public struct SKRecentTrack: Track, Decodable {
    
    /// The date and time the track was last played, with millisecond precision.
    public let datePlayed: Date // playbackDate // dateLastPlayed
    
    /// The context from which the track was played, such as an album or playlist.
    public let context: SKPlaybackContext
    
    /// The track the user listened to.
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
    public var trackLink: SKTrackLink?          { return track.trackLink }
    public var name: String                     { return track.name }
    public var previewURL: URL?                 { return track.previewURL }
    public var trackNumber: Int                 { return track.trackNumber }
    public var album: SKAlbum?                  { return track.album }
    public var externalIDs: [String : String]?  { return track.externalIDs }
    public var popularity: Int?                 { return track.popularity }
    
    private enum CodingKeys: String, CodingKey {
        case track
        case datePlayed = "played_at"
        case context
    }
}

// MARK: - Custom Decoding

extension SKRecentTrack {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try values.decode(String.self, forKey: .datePlayed)
        context = try values.decode(SKPlaybackContext.self, forKey: .context)
        track = try values.decode(SKTrack.self, forKey: .track)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Accounts for milliseconds returned in string.
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: values.codingPath + [CodingKeys.datePlayed], debugDescription: "Cannot initialize \(Date.self) from invalid \(String.self) value \(dateString)"))
        }
        
        datePlayed = date
    }
}

// MARK: - Savable Conformance

extension SKRecentTrack: Savable {}

// MARK: - Cursor Pageable Conformance

extension SKRecentTrack: CursorPageable {
    public typealias CursorType = Date
}
