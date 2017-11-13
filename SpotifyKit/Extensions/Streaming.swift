//
//  Streaming.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 11/6/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Streaming Convenience Methods

extension SPTAudioStreamingController {
    
    /// Plays a Spotify track.
    ///
    /// - Parameters:
    ///   - track: The SpotifyKit track to play.
    ///   - position: The position, in seconds, from which to begin playback. The default value is `0`, playing the track from the beginning.
    ///   - handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    public func play<T: Track>(_ track: T, from position: TimeInterval = 0, handler: @escaping SKErrorHandler) {
        
        playSpotifyURI(track.uri, startingWith: 0, startingWithPosition: position, callback: handler)
    }
    
    /// Plays a Spotify album.
    ///
    /// - Parameters:
    ///   - album: The SpotifyKit album to play.
    ///   - index: The index of the track within the album to begin playing. The default value is `0`, beginning with the first track in the album.
    ///   - position: The position, in seconds, from which to begin playback of the given track. The default value is `0`, playing the track from the beginning.
    ///   - handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    public func play<T: Album>(_ album: T, at index: Int = 0, from position: TimeInterval = 0, handler: @escaping SKErrorHandler) {
        
        playSpotifyURI(album.uri, startingWith: UInt(index), startingWithPosition: position, callback: handler)
    }
    
    /// Plays a Spotify playlist.
    ///
    /// - Parameters:
    ///   - playlist: The SpotifyKit playlist to play.
    ///   - index: The index of the track within the playlist to begin playing. The default value is `0`, beginning with the first track in the playlist.
    ///   - position: The position, in seconds, from which to begin playback of the given track. The default value is `0`, playing the track from the beginning.
    ///   - handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    public func play(_ playlist: SKPlaylist, at index: Int = 0, from position: TimeInterval = 0, handler: @escaping SKErrorHandler) {
        
        playSpotifyURI(playlist.uri, startingWith: UInt(index), startingWithPosition: position, callback: handler)
    }
    
    /// Queues a Spotify track.
    ///
    /// - Parameters:
    ///   - track: The SpotifyKit track to add to the playback queue.
    ///   - handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    public func queue<T: Track>(_ track: T, handler: @escaping SKErrorHandler) {
        
        queueSpotifyURI(track.uri, callback: handler)
    }
}

// MARK: - Playable & Queueable Protocols

/// A type that can be streamed with the [Spotify Audio Playback](https://github.com/spotify/ios-sdk) framework.
///
/// Types that conform to this protocol implement a convenience method that calls the shared `SPTAudioStreamingController` instance's `play` method, beginning playback of the item that performed the method,
public protocol Playable {
    
    /// Plays the item from the beginning.
    ///
    /// If the item represents a collection of tracks, such as an album or playlst, this method begins playing the first track in the context.
    ///
    /// - Note: This method uses the shared `SPTAudioStreamingController` instance to play the item. If the controller has not been initialized, started on its own thread, or logged into the Spotify service, then his method will do nothing.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    func play(handler: @escaping SKErrorHandler)
}

/// A type that can be added to the streaming queue with the [Spotify Audio Playback](https://github.com/spotify/ios-sdk) framework.
///
/// Types that conform to this protocol implement a convenience method that calls the shared `SPTAudioStreamingController` instance's `queue` method, adding the item that performed the method to the streaming controller's playback queue.
public protocol Queueable {
    
    /// Queues the item for playback.
    ///
    /// - Note: This method uses the shared `SPTAudioStreamingController` instance to queue the item. If the controller has not been initialized, started on its own thread, or logged into the Spotify service, then his method will do nothing.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    func queue(handler: @escaping SKErrorHandler)
}

extension SKPlaylist: Playable {
    public func play(handler: @escaping SKErrorHandler/* = { _ in }*/) {
        SPTAudioStreamingController.sharedInstance()?.play(self, handler: handler)
    }
}

extension Playable where Self: Album {
    public func play(handler: @escaping SKErrorHandler) {
        SPTAudioStreamingController.sharedInstance()?.play(self, handler: handler)
    }
}

extension SKAlbum: Playable {}
extension SKSavedAlbum: Playable {}

extension Playable where Self: Track {
    public func play(handler: @escaping SKErrorHandler) {
        SPTAudioStreamingController.sharedInstance()?.play(self, handler: handler)
    }
}

extension SKTrack: Playable {}
extension SKSavedTrack: Playable {}
extension SKRecentTrack: Playable {}
extension SKPlaylistTrack: Playable {}

extension Queueable where Self: Track {
    public func queue(handler: @escaping SKErrorHandler) {
        SPTAudioStreamingController.sharedInstance()?.queue(self, handler: handler)
    }
}

extension SKTrack: Queueable {}
extension SKSavedTrack: Queueable {}
extension SKRecentTrack: Queueable {}
extension SKPlaylistTrack: Queueable {}
