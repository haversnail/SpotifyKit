//
//  RecentTrack.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 11/6/17.
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

/// A recently played Spotify track.
///
/// - SeeAlso: The Web API [Play History](https://developer.spotify.com/documentation/web-api/reference/object-model/#play-history-object) object.
public struct SKRecentTrack: Track, Decodable {
    
    /// The date and time the track was last played, with millisecond precision.
    public let datePlayed: Date
    // public let playbackDate: Date
    // public let dateLastPlayed: Date
    
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
    public var trackLinks: SKTrackLinks?          { return track.trackLinks }
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
