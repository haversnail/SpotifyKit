//
//  Playback.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/31/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Supporting Types

public enum SKRepeatMode: String, Codable {
    case off
    case one = "track"
    case all = "context"
    
    public init(_ value: SPTRepeatMode) {
        switch value {
            case .off: self = .off
            case .one: self = .one
            case .context: self = .all
        }
    }
}

extension SPTRepeatMode {
    public init(_ value: SKRepeatMode) {
        switch value {
            case .off: self = .off
            case .one: self = .one
            case .all: self = .context
        }
    }
}

//public typealias SKRepeatMode = SPTRepeatMode
//
//extension SPTRepeatMode: Codable {
//    public init?(rawValue: String) {
//        switch rawValue {
//        case "off": self = .off
//        case "context": self = .context
//        case "track": self = .one
//        default: return nil
//        }
//    }
//}

// MARK: - Playback Context

public struct SKPlaybackContext: Decodable { // SKPlaybackSource
    
    public enum ContextType: String, Codable {
        case album
        case artist
        case playlist
    }
    
    /// The context in which  track . See `ContextType` for possible values.
    public let type: ContextType
    
    /// Known external URLs for this context. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    public let externalURLs: [String: URL]
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the context.
    public let uri: String
    
    /// A link to the Web API endpoint providing full details of the context object.
    public let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case url = "href"
        case type
        case uri
    }
}

// MARK: - Playback State (Currently Playing Context) (βeta)

public struct SKPlaybackState: JSONDecodable { // SPTPlaybackState
    
    /// The device that is currently active.
    // - Note: When retrieving the currently playing track, this property will be `nil`. // Just don't support that endpoint. It's redundant anyways.
    public let device: SKDevice?
    
    /// <#Description#>
    // - Note: When retrieving the currently playing track, this property will be `nil`.
    public let repeatMode: SKRepeatMode?
    
    /// <#Description#>
    // - Note: When retrieving the currently playing track, this property will be `nil`.
    public let isShuffling: Bool?
    
    /// <#Description#>...can be `nil`.
    public let context: SKPlaybackContext?
    
    /// The timestamp when the data was fetched.
    public let timestamp: Date // FIXME: Provided as Int... convert to Date.
    
    /// <#Description#>
    private let _progress: Int?
    
    /// The progress into the currently playing track. If no track is currently playing, this will be `nil`.
    public var progress: TimeInterval? {
        switch _progress {
            case .some(let t): return TimeInterval(t) / 1000
            case .none: return nil
        }
    }
    
    /// A Boolean value indicating whether a track is currently playing.
    public let isPlaying: Bool
    
    /// The currently playing track. If no track is currently playing, this will be `nil`.
    public let track: SKTrack?
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case device
        case repeatMode = "repeat_state"
        case isShuffling = "shuffle_state"
        case context
        case timestamp
        case _progress = "progress_ms"
        case isPlaying = "is_playing"
        case track = "item"
    }
}

//public protocol SPTConvertible { // SDKConvertible
//    associatedtype ReferenceType
//    func makeSPTInstance() -> ReferenceType
//    //var sptInstance: ReferenceType { get }
//}
//
//extension SKPlaybackState: SPTConvertible {
//    
//    public func makeSPTInstance() -> SPTPlaybackState? {
//        
//        guard let device = device, let repeatMode = repeatMode, let isShuffling = isShuffling, let progress = progress else {
//            return nil
//        }
//        
//        return SPTPlaybackState(isPlaying: isPlaying,
//                                isRepeating: repeatMode == .all || repeatMode == .one,
//                                isShuffling: isShuffling,
//                                isActiveDevice: device.type == .mobile, // No good... find a better way.
//                                position: TimeInterval(progress))!
//    }
//}

