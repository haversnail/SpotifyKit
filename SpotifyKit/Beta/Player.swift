//
//  Player.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 11/5/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Player Requests

public struct SKPlayer {
    
    // MARK: Get the Current User's Recently Played Tracks ✔︎
    
    /// Creates and returns the request used to get the current authenticated user's recent tracks.
    ///
    /// - Note: This method is used only to construct the `SKRequest` instance, and is kept private to avoid confusion regarding which parameters can be supplied, as the request cannot specify both `after` and `before` dates simultaneously.
    private static func _makeRecentTracksRequest(startAfterDate: Date?, endBeforeDate: Date?, limit: Int?) -> SKRequest {
        
        func string(from date: Date?) -> String? {
            guard let date = date else { return nil }
            return String(format: "%.0f", date.timeIntervalSince1970 * 1000)
        }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.after] = string(from: startAfterDate)
        parameters[Constants.QueryParameters.before] = string(from: endBeforeDate)
        parameters[Constants.QueryParameters.limit] = limit
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.recentlyPlayed, parameters: parameters)!
    }
    
    /// Creates and returns the request used to get the current authenticated user's recent tracks.
    ///
    /// - Parameters:
    ///   - startAfterDate: A date after which to request the tracks. The response will include any tracks within the limit that have been played after, but not including, the given date and time, with millisecond precision.
    ///   - limit: The number of items to return.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeRecentTracksRequest(startAfterDate: Date?, limit: Int?) -> SKRequest {
        return _makeRecentTracksRequest(startAfterDate: startAfterDate, endBeforeDate: nil, limit: limit)
    }
    
    /// Creates and returns the request used to get the current authenticated user's recent tracks.
    ///
    /// - Parameters:
    ///   - endBeforeDate: A date before which to request the tracks. The response will include any tracks within the limit that have been played up to, but not including, the given date and time, with millisecond precision.
    ///   - limit: The number of items to return.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeRecentTracksRequest(endBeforeDate: Date?, limit: Int?) -> SKRequest {
        return _makeRecentTracksRequest(startAfterDate: nil, endBeforeDate: endBeforeDate, limit: limit)
    }
    
    /// Gets the current authenticated user's recently played tracks.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Reading the current user's recently played tracks also requires authorization of the "`user-read-recently-played`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - date: A date after which to request the tracks. The response will include any tracks within the limit that have been played after, but not including, the given date and time, with millisecond precision. The default value is `nil`, which returns the most recent tracks.
    ///   - limit: The number of items to return. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///       - `tracks`: A cursor-based paginated list of recent artists, if any.
    ///       - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getRecentTracks(after date: Date? = nil, limit: Int? = nil, handler: @escaping (CursorPage<SKRecentTrack>?, Error?) -> Void) {
        makeRecentTracksRequest(startAfterDate: date, limit: limit).perform(handler: handler)
    }
    
    /// Gets the current authenticated user's recently played tracks.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Reading the current user's recently played tracks also requires authorization of the "`user-read-recently-played`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - date: A date before which to request the tracks. The response will include any tracks within the limit that have been played up to, but not including, the given date and time, with millisecond precision.
    ///   - limit: The number of items to return. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///       - `tracks`: A cursor-based paginated list of recent artists, if any.
    ///       - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getRecentTracks(before date: Date?, limit: Int? = nil, handler: @escaping (CursorPage<SKRecentTrack>?, Error?) -> Void) {
        makeRecentTracksRequest(endBeforeDate: date, limit: limit).perform(handler: handler)
    }
}
