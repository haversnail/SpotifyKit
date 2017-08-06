//
//  Request.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// The HTTP [REST] verbs used for API requests. See [Requests] for more details.
///
/// [REST]: http://en.wikipedia.org/wiki/Representational_state_transfer
/// [Requests]: https://developer.spotify.com/web-ai/user-guide/#requests
public enum HTTPRequestMethod: String {
    
    /// Used for retrieving resources.
    case GET
    
    /// Used for creating resources.
    case POST
    
    /// Used for changing/replacing resources or collections.
    case PUT
    
    /// Used for deleting resources.
    case DELETE
}



/// The [Response Status Codes] used by the API, as defined in the [RFC 2616] and [RFC 6585].
///
/// [Response Status Codes]: https://developer.spotify.com/web-api/user-guide/#response-status-codes
/// [RFC 2616]: https://www.ietf.org/rfc/rfc2616.txt
/// [RFC 6585]: https://www.ietf.org/rfc/rfc6585.txt
public enum HTTPStatusCode: Int, Codable {
    
    /// The request has succeeded. The client can read the result of the request in the body and the headers of the response.
    case ok = 200
    
    /// The request has been fulfilled and resulted in a new resource being created.
    case created = 201
    
    /// The request has been accepted for processing, but the processing has not been completed.
    case accepted = 202
    
    /// The request has succeeded but returns no message body.
    case noContent = 204
    
    /// See [Conditional requests](https://developer.spotify.com/web-api/user-guide/#conditional-requests).
    case notModified = 304
    
    /// The request could not be understood by the server due to malformed syntax. The message body will contain more information; see [Error Details](https://developer.spotify.com/web-api/user-guide/#error-details).
    case badRequest = 400
    
    /// The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials.
    case unauthorized = 401
    
    /// The server understood the request, but is refusing to fulfill it.
    case forbidden = 403
    
    /// The requested resource could not be found. This error can be due to a temporary or permanent condition.
    case notFound = 404
    
    /// [Rate limiting](https://developer.spotify.com/web-api/user-guide/#rate-limiting) has been applied.
    case tooManyRequests = 429
    
    /// Although unlikely, if you receieve this error, please report it [here](https://github.com/spotify/web-api/issues).
    case internalServerError = 500
    
    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502
    
    /// The server is currently unable to handle the request due to a temporary condition which will be alleviated after some delay. You can choose to resend the request again.
    case serviceUnavailable = 503
}



/// The access scopes used to request data from the Spotify Web API. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for all possible scopes, their prompts during authentication, and more details.
public enum SKScope: String, Codable {
    
    /// Read access to user's private playlists.
    case playlistReadPrivate = "playlist-read-private"
    
    /// Include collaborative playlists when requesting a user's playlists.
    case playlistReadCollaborative = "playlist-read-collaborative"
    
    /// Write access to a user's public playlists.
    case playlistModifyPublic = "playlist-modify-public"
    
    /// Write access to a user's private playlists.
    case playlistModifyPrivate = "playlist-modify-private"
    
    /// Control playback of a Spotify track. This scope is currently only available to Spotify native SDKs (for example, the [iOS SDK](https://developer.spotify.com/technologies/spotify-ios-sdk/) and the [Android SDK](https://developer.spotify.com/technologies/spotify-android-sdk/)). The user must have a Spotify Premium account.
    case streaming
    
    /// Upload a playlist cover image.
    case ugcImageUpload = "ugc-image-upload"
    
    /// Write/delete access to the list of artists and other users that the user follows.
    case userFollowModify = "user-follow-modify"
    
    /// Read access to the list of artists and other users that the user follows.
    case userFollowRead = "user-follow-read"
    
    /// Read access to a user's "Your Music" library.
    case userLibraryRead = "user-library-read"
    
    /// Write/delete access to a user's "Your Music" library.
    case userLibraryModify = "user-library-modify"
    
    /// Read access to user’s subscription details (type of user account).
    case userReadPrivate = "user-read-private"
    
    // user-read-recently-played?
    
    /// Read access to the user's birthdate.
    case userReadBirthdate = "user-read-birthdate"
    
    /// Read access to user’s email address.
    case userReadEmail = "user-read-email"
    
    /// Read access to a user's top artists and tracks.
    case userTopRead = "user-top-read"
}

// MARK: - Request Class

public class SKRequest { // Inheriting from NSObject causes buildtime error: class conflicts with StoreKit's `SKRequest` class.
    
}
