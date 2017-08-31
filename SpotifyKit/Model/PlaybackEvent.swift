//
//  PlaybackEvent.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/31/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A structure representing the recent playback of an audio track. See the [Play History](https://developer.spotify.com/web-api/object-model/#play-history-object) object for more details.
public struct SKPlaybackEvent {
    
    // MARK: - Embedded Types
    
    public struct PlaybackContext: Decodable {
        
        public enum ContextType: String, Codable {
            case album
            case artist
            case playlist
        }
        
        /// Known external URLs for this context. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
        public let externalURLs: [String: URL]
        
        /// A link to the Web API endpoint providing full details of the context object.
        public let url: URL
        
        /// The type of context from which this item was played back (e.g., `album`, `artist`, `playlist`). See `ContextType` for possible values.
        public let type: ContextType
        
        /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the context.
        public let uri: String
        
        private enum CodingKeys: String, CodingKey {
            case externalURLs = "external_urls"
            case url = "href"
            case type
            case uri
        }
    }
    
    // MARK: - Object Properties
    
    /// The track the user listened to.
    public let track: SKTrack
    
    /// The date and time the track was played, with millisecond precision.
    public let playbackDate: Date
    
    /// The context the track was played from.
    public let context: PlaybackContext
    
    private enum CodingKeys: String, CodingKey {
        case track
        case playbackDate = "played_at"
        case context
    }
}

// MARK: - Custom Decoding

extension SKPlaybackEvent: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        context = try values.decode(PlaybackContext.self, forKey: .context)
        track = try values.decode(SKTrack.self, forKey: .track)
        let dateString = try values.decode(String.self, forKey: .playbackDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Accounts for milliseconds returned in string.
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: values.codingPath + [CodingKeys.playbackDate], debugDescription: "Cannot initialize \(Date.self) from invalid \(String.self) value \(dateString)"))
        }
        
        playbackDate = date
    }
}
