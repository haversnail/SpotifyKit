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
    
    case readPrivatePlaylists = "playlist-read-private"
    /// Include collaborative playlists when requesting a user's playlists.
    
    case readCollaborativePlaylists = "playlist-read-collaborative"
    /// Write access to a user's public playlists.
    
    case modifyPublicPlaylists = "playlist-modify-public"
    /// Write access to a user's private playlists.
    
    case modifyPrivatePlaylists = "playlist-modify-private"
    /// Control playback of a Spotify track. This scope is currently only available to Spotify native SDKs (for example, the [iOS SDK](https://developer.spotify.com/technologies/spotify-ios-sdk/) and the [Android SDK](https://developer.spotify.com/technologies/spotify-android-sdk/)). The user must have a Spotify Premium account.
    case streaming
    
    /// Upload a playlist cover image.
    
    case uploadUGCImage = "ugc-image-upload"
    /// Write/delete access to the list of artists and other users that the user follows.
    
    case modifyUserFollows = "user-follow-modify"
    /// Read access to the list of artists and other users that the user follows.
    
    case readUserFollows = "user-follow-read"
    /// Read access to a user's "Your Music" library.
    
    case readUserLibrary = "user-library-read"
    /// Write/delete access to a user's "Your Music" library.
    
    case modifyUserLibrary = "user-library-modify"
    /// Read access to user’s subscription details (type of user account).
    
    case readUserPrivate = "user-read-private"
    // user-read-recently-played?
    
    /// Read access to the user's birthdate.
    
    /// Read access to user’s email address.
    
    case readUserEmail = "user-read-email"
    /// Read access to a user's top artists and tracks.
    case readUserTopContent = "user-top-read"
}



// MARK: SKRequestHandler

/// The callback handler for a request.
///
/// - Parameters:
///     - data: The data (typically an encoded JSON object) returned by the request, if any. If the data returned represents an API-specific error object, that object will be provided via the `error` parameter instead.
///     - error: An error object identifying if and why the request failed, or `nil` if the response was successful.
public typealias SKRequestHandler = (_ data: Data?, /*_ status: HTTPStatusCode?, */_ error: Error?) -> Void // or `SKRequest.ResponseHandler`?



// MARK: - Request Class

/// The `SKRequest` object encapsulates the properties of an HTTP request, providing a convenient template for you to make requests to the [Spotify Web API][API].
///
/// This class is inspired by the [Social] Framework's [SLRequest] class, and aims to mimic its structure and functionality in order to provide a comparable service for interacting with the Spotify [Web API].
///
/// [API]: https://developer.spotify.com/web-api/
/// [Social]: apple-reference-documentation://cssocial
/// [SLRequest]: apple-reference-documentation://hsp4_7YsJD
public class SKRequest { // Inheriting from NSObject causes buildtime error: class conflicts with StoreKit's `SKRequest` class.
    
    private struct Constants {
        private init() {}
        static let baseURL = URL(string: "https://api.spotify.com")!
        static let accountsURL = URL(string: "https://accounts.spotify.com")!
        static let tokenType = "Bearer"
        struct HeaderKeys {
            private init() {}
            static let authorization = "Authorization"
            static let contentType = "Content-Type"
            //static let matchETag = "If-None-Match"
        }
        //struct ContentTypes {
        //    private init() {}
        //    static let json = "application/json"
        //    static let jpeg = "image/jpeg"
        //}
    }
    
    /// The MIME content types available for sending multipart requests to the [Spotify Web API][API].
    ///
    /// - Note: The only content types currently accepted by the [Spotify Web API][API] are "`application/json`" and "`image/jpeg`" for all PUT, POST, or DELETE requests. If/when more content types become part of the API, they will be made available here.
    ///
    /// [API]: https://developer.spotify.com/web-api/
    public enum ContentType: String {
        
        /// Represents UTF-8 encoded JSON data. This is the format for nearly all PUT, POST, and DELETE requests to the API.
        case json = "application/json"
        
        /// Represents Base64 encoded JPEG image data. This is the format used when uploading images to the API (e.g., when uploading a [custom playlist cover image](https://developer.spotify.com/web-api/upload-a-custom-playlist-cover-image/)).
        case jpeg = "image/jpeg"
    }
    
    // MARK: - Request Properties

    /// The method to use for this request.
    public let method: HTTPRequestMethod

    /// The destination URL for this request.
    public let url: URL

    /// The parameters for this request, if any. If no parameters are supplied, this will be an empty dictionary.
    public let parameters: [String: Any] // or `[AnyHashable : URLEncodable]`?

    /// The URL session used to perform the request.
    ///
    /// Set this property if you wish to provide a custom URL session object with which to perform the underlying network request. The default value is a URL session instance with the [default configuration](apple-reference-documentation://hs7s_hgSaq).
    /// - Important: The session will be invalidated upon deinitialization of this `SKRequest` instance (except if this session references the [shared singleton URLSession](apple-reference-documentation://hswpyQK_SL)).
    public var urlSession: URLSession = URLSession(configuration: .`default`) // or `URLSession.shared`?

    /// The authenticated Spotify API session used to authorize the request.
    ///
    /// Setting this property with your active `SPTSession` instance ensures your API request is accompanied by the appropriate OAuth access token.
    ///
    /// The default value is the current `session` object referenced by the [SPTAuth](https://spotify.github.io/ios-sdk/Classes/SPTAuth.html) class's default instance.
    public weak var apiSession: SPTSession? = SPTAuth.defaultInstance()?.session // or `nil`?
    
    /// A tuple value storing multipart request body data and its associated MIME content type.
    fileprivate var requestBody: (data: Data, type: ContentType)? = nil

    /// The prepared URL used by the URL request, comprised of the initial URL and the query containing the URL-encodable elements in `parameters`.
    private var preparedURL: URL {
        get {
            if parameters.isEmpty {
                return url
            }
            
            // Imperative, stateful approach:
//            var items: [URLQueryItem] = []
//            let encoder = URLEncoder()
//            for (key, value) in parameters {
//                guard value is URLEncodable else { continue }
//                let encodedValue = (value as! URLEncodable).urlEncodedString(using: encoder)
//                items.append(URLQueryItem(name: key, value: encodedValue))
//            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            
            // Create the array of query items by:
            // 1. filtering out those values that aren't URL-encodable,
            // 2. mapping the remaining key/value pairs to a new `URLQueryItem`, encoding the value as a URL-compatible string.
            components?.queryItems = parameters
                .filter { $0.value is URLEncodable }
                .map { return URLQueryItem(name: $0.key, value: ($0.value as! URLEncodable).urlEncodedString(using: .`default`)) }
            
            return components?.url ?? url // Return our new composed URL, or our original one if we couldn't create the components object.
        }
    }

    /// The authorized URL request.
    ///
    /// - Important: Set the API session property beforehand to ensure this request is accompanied by the appropriate OAuth access token.
    public var preparedURLRequest: URLRequest {
        get {
            var request = URLRequest(url: preparedURL)
            request.httpMethod = method.rawValue

            // Add the OAuth access token to the request header:
            if let token = apiSession?.accessToken {
                request.addValue("\(Constants.tokenType) \(token)", forHTTPHeaderField: Constants.HeaderKeys.authorization)
            }
            
            // Add any multipart content, if provided:
            if let body = requestBody {
                request.httpBody = body.data
                request.addValue(body.type.rawValue, forHTTPHeaderField: Constants.HeaderKeys.contentType)
            }
            
            // TODO: Handle Conditional Requests.
            //if let eTag = entityTag {
            //    request.addValue(eTag, forHTTPHeaderField: Constants.HeaderKeys.matchETag)
            //}

            return request
        }
    }

    // MARK: - Initializing Requests

    /// Initializes a newly created request object with the specified properties.
    ///
    /// If the URL provided does not contain either the Web API base URL (`https://api.spotify.com`), or the Web API accounts service URL (`https://accounts.spotify.com`), this initializer will fail.
    ///
    /// - Parameters:
    ///     - method: The HTTP verb to use for this API request. For possible values, see `HTTPRequestMethod`.
    ///     - url: The full destination URL for this API request, comprised of either the Web API base URL (`https://api.spotify.com`) or the accounts service URL (`https://accounts.spotify.com`) and the specific endpoint from which to request data.
    ///     - parameters: The parameters to send along with the API request, if any. The values are encoded as a URL query string and appended to the destination URL.
    /// - Note: If the URL provided already contains a query string, those query items will be removed from the stored `url` property and made available through the `parameters` property instead. When both a `parameters` argument and a URL with existing query items are supplied, both are stored in the `parameters` property. Values supplied by the `parameters` argument will overwrite any conflicting values supplied by the URL query.
    public init?(method: HTTPRequestMethod, url: URL, parameters: [String: Any] = [:]) {
        
        guard url.host == Constants.baseURL.host || url.host == Constants.accountsURL.host else { return nil }

        var parameters = parameters // Make a mutable copy.

        if let queryItems = URLComponents(string: url.absoluteString)?.queryItems { // If the url already contains a string of queries,
            for item in queryItems {                                                // then for each query item,
                guard parameters[item.name] == nil else { continue }                // if that item wasn't already specified in the `parameters` argument,
                parameters[item.name] = item.value                                  // add that query item to our set of parameters.
            }
        }

        self.method = method
        self.url = url.deletingQuery()
        self.parameters = parameters
    }

    /// Initializes a newly created request by specifying the API endpoint from which to request data.
    ///
    /// If a valid API URL cannot be derived from the given endpoint, this initializer will fail.
    ///
    /// - Parameters:
    ///     - method: The HTTP verb to use for this API request. For possible values, see `HTTPRequestMethod`.
    ///     - endpoint: The destination endpoint for this API request, relative to the Web API base URL (`https://api.spotify.com`).
    ///     - parameters: The parameters to send along with the API request, if any. The values are encoded as a URL query string and appended to the destination URL.
    public convenience init?(method: HTTPRequestMethod, endpoint: String, parameters: [String: Any] = [:]) {
        
        guard let url = URL(string: endpoint, relativeTo: Constants.baseURL) else { return nil }
        
        self.init(method: method, url: url, parameters: parameters)
    }

    deinit {
        if urlSession !== URLSession.shared {       // As long as `urlSession` isn't the shared instance,
            urlSession.finishTasksAndInvalidate()   // invalidate the session once this SKRequest is deinitialized.
        }
    }
    
    // MARK: - Sending Requests
    
    /// Specifies a multipart request body for a PUT, POST, or DELETE request.
    ///
    /// - Parameters:
    ///     - data: The data for the request body, typically an encoded JSON object.
    ///     - type: The MIME content type of the request body. The default value is "`application/json`."
    public func addMultipartData(_ data: Data, type: ContentType = .json) { // or `_ body: JSONEncodable`?
        requestBody = (data: data, type: type)
    }

    /// Performs the request, handling API-specific responses and calling the specified handler when complete.
    ///
    /// - Parameter handler: The callback handler for this request. The parameters for this handler are:
    ///     - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the response was successful.
    public func perform(handler: @escaping SKRequestHandler) {

        //let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: preparedURLRequest) { (data, response, error) in

            //var handlerError: Error? = nil
            //var status: HTTPStatusCode? = nil
            //defer { handler(data, handlerError) }

            // Assert that we received a non-nil data object, and handle any errors returned by the data task:
            guard data != nil, response != nil, error == nil else { // Are these two mutually exclusive?
                handler(nil, error)
                return
            }

            // Make sure the response is in fact an HTTP URL response:
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Performing any request to the Spotify Web API is an HTTPS request and should therefore always return an HTTPURLResponse object.") //fatalError()?
                return
            }

            // Make sure the status code of that response matches one of the expected HTTP status codes:
            guard let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) else {
                // TODO: Return an "unknown status code" error.
                return
            }
            print(statusCode)

            // Handle any error objects returned by the Web API:
            if let apiError = try? SKError(from: data!) {
                handler(nil, apiError)
                return
            }

            // Handle any authentication error objects returned by the web API:
            if let authError = try? SKAuthenticationError(from: data!) {
                handler(nil, authError)
                return
            }

            // TODO: Handle Conditional Requests.

            handler(data, nil)
        }

        task.resume()
        //urlSession.finishTasksAndInvalidate()
    }
}



// MARK: - SpotifyAuthentication Extensions

extension SPTSession {

    /// A convenience method that performs an authorized request to the [Spotify Web API](https://developer.spotify.com/web-api/).
    ///
    /// - Parameters:
    ///     - method: The HTTP request method: `GET`, `PUT`, `POST`, or `DELETE`.
    ///     - url: The destination URL for this request.
    ///     - parameters: The parameters for this request, if any.
    ///     - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    ///     - handler: The callback handler for this request. The parameters for this handler are:
    ///         - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///         - `error`: An error object identifying if and why the request failed, or `nil` if the response was successful.
    public func performRequest(_ method: HTTPRequestMethod, url: URL, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil, handler: @escaping SKRequestHandler) {
        
        let request = SKRequest(method: method, url: url, parameters: parameters)
        request?.apiSession = self
        request?.requestBody = requestBody
        request?.perform(handler: handler)
    }

    /// A convenience method that performs an authorized request to the [Spotify Web API](https://developer.spotify.com/web-api/).
    ///
    /// - Parameters:
    ///     - method: The HTTP request method: `GET`, `PUT`, `POST`, or `DELETE`.
    ///     - endpoint: The destination endpoint for this request.
    ///     - parameters: The parameters for this request, if any.
    ///     - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    ///     - handler: The callback handler for this request. The parameters for this handler are:
    ///         - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///         - `error`: An error object identifying if and why the request failed, or `nil` if the response was successful.
    public func performRequest(_ method: HTTPRequestMethod, endpoint: String, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil, handler: @escaping SKRequestHandler) {
        
        let request = SKRequest(method: method, endpoint: endpoint, parameters: parameters)
        request?.apiSession = self
        request?.requestBody = requestBody
        request?.perform(handler: handler)
    }
}
