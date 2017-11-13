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
    
    // MARK: Get a User's Available Devices ✔︎
    
    /// Creates and returns the request used to get the current authenticated user's available devices.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeAvailableDevicesRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.devices)!
    }
    
    /// Gets a list of the current authenticated user's available devices.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Reading the list of the current user's available devices also requires authorization of the "`user-read-playback-state`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `devices`: An array of available devices, if any.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getAvailableDevices(handler: @escaping ([SKDevice]?, Error?) -> Void) {
        makeAvailableDevicesRequest().perform(handler: handler)
    }
    
    // MARK: Get Information About the Current User's Playback State ✔︎
    
    /// Creates and returns the request used to get the current authenticated user's available devices.
    ///
    /// - Parameter locale: The locale-specific storefront/market from which to request.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makePlaybackStateRequest(locale: Locale?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.player, parameters: parameters)!
    }
    
    /// Gets the active Spotify player's current playback state, including the currently playing track if applicable.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Reading the current Spotify player's playback information also requires authorization of the "`user-read-playback-state`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific storefront/market from which to request. The default value is the locale for the shared `SKCatalog` instance, which by default represents the user's region settings at the time the method is called.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///       - `state`: An `SKPlaybackState` instance.
    ///       - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getPlaybackState(for locale: Locale? = SKCatalog.local.locale, handler: @escaping (SKPlaybackState?, Error?) -> Void) {
        makePlaybackStateRequest(locale: locale).perform(handler: handler)
    }
    
    // MARK: Transfer Playback to Another Device ✔︎
    
    /// Creates and returns the request used to transfer playback to another device.
    ///
    /// - Parameters:
    ///   - deviceID: The ID of the device on which playback should be transferred.
    ///   - forcePlayback: A Boolean value indicating whether the new device should begin playback: `true` ensures playback happens on the new device; `false` keeps the current playback state. Note that providing `false` will not *pause* playback.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeTransferRequest(deviceID: String, forcePlayback: Bool) -> SKRequest {
        
        let request = SKRequest(method: .PUT, endpoint: Constants.Endpoints.player)!
        
        typealias RequestBody = Constants.RequestBodies.TransferPlaybackBody
        let data = try! RequestBody(deviceIDs: [deviceID], forcePlayback: forcePlayback).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Transfers playback to the given device.
    ///
    /// - Important: The given `SKDevice` instance **must** have an ID. If the device contains a `nil` ID value, then this method will immediately call the handler and provide an `SKError` instance denoting a bad request.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the playback state, to include the active device, also requires authorization of the "`user-modify-playback-state`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - device: The device on which playback should be transferred.
    ///   - forcePlayback: A Boolean value indicating whether the new device should begin playback: `true` ensures playback happens on the new device; `false` keeps the current playback state. The default value is `false`. Note that providing `false` will not *pause* playback.
    ///   - handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func transfer(to device: SKDevice, forcingPlayback forcePlayback: Bool = false, handler: @escaping SKErrorHandler) {
        
        guard let deviceID = device.id else {
            let error = SKError(status: .badRequest, message: "The device provided does not contain an ID.")
            handler(error)
            return
        }
        
        makeTransferRequest(deviceID: deviceID, forcePlayback: forcePlayback).perform(handler: handler)
    }
}
