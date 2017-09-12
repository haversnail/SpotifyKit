//
//  Request.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// The HTTP [REST] verbs used for API requests. See the API [Requests] guide for more details.
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
    case readUserBirthdate = "user-read-birthdate"
    
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
///     - error: An error object identifying if and why the request failed, or `nil` if the request was successful.
public typealias SKRequestHandler = (_ data: Data?, /*_ status: HTTPStatusCode?, */_ error: Error?) -> Void // or `SKRequest.ResponseHandler`?

/// The callback handler for a request.
///
/// - Parameters:
///     - object: The object decoded from the JSON data returned by the request. If the object could not be decoded from the data received, the `error` parameter will provide details.
///     - error: An error object identifying if and why the request or decoding failed, or `nil` if the request was successful.
public typealias SKDecodedRequestHandler<T: JSONDecodable> = (_ object: T?, _ error: Error?) -> Void



// MARK: - Request Class

/// The `SKRequest` object encapsulates the properties of an HTTP request, providing a convenient template for you to make requests to the [Spotify Web API].
///
/// This class is inspired by the [Social] Framework's [SLRequest] class, and aims to mimic its structure and functionality in order to provide a comparable service for interacting with the [Spotify Web API].
///
/// [Spotify Web API]: https://developer.spotify.com/web-api/
/// [Social]: apple-reference-documentation://cssocial
/// [SLRequest]: apple-reference-documentation://hsp4_7YsJD
public class SKRequest { // Inheriting from NSObject causes buildtime error: class conflicts with StoreKit's `SKRequest` class.
    
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

    /// The HTTP method used for this request.
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
    ///
    /// - Complexity: O(*n*), where *n* is the number of elements in `parameters`.
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
                .lazy
                .filter { $0.value is URLEncodable }
                .map { return URLQueryItem(name: $0.key, value: ($0.value as! URLEncodable).urlEncodedString(using: .`default`)) }
            
            return components?.url ?? url // Return our new composed URL, or our original one if we couldn't create the components object.
        }
    }

    /// The authorized URL request.
    ///
    /// - Important: Set the API session property beforehand to ensure this request is accompanied by the appropriate OAuth access token.
    ///
    /// - Complexity: O(*n*), where *n* is the number of elements in `parameters`.
    public var preparedURLRequest: URLRequest {
        get {
            var request = URLRequest(url: preparedURL)
            request.httpMethod = method.rawValue

            // Add the OAuth access token to the request header:
            if let token = apiSession?.accessToken {
                request.addValue("\(Constants.tokenType) \(token)", forHTTPHeaderField: Constants.HeaderFields.authorization)
            }
            
            // Add any multipart content, if provided:
            if let body = requestBody {
                request.httpBody = body.data
                request.addValue(body.type.rawValue, forHTTPHeaderField: Constants.HeaderFields.contentType)
            }
            
            // TODO: Handle Conditional Requests.
            //if let eTag = entityTag {
            //    request.addValue(eTag, forHTTPHeaderField: Constants.HeaderFields.matchETag)
            //}

            return request
        }
    }

    // MARK: - Initializing Requests

    /// Creates a new request with the specified properties.
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

    /// Creates a new request by specifying the API endpoint from which to request.
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
    ///     - `error`: An error object identifying if and why the request or decoding failed, or `nil` if the request was successful.
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
    
    /// Performs the request, decoding the JSON data returned by the request to the given type and calling the specified handler when complete.
    ///
    /// - Parameter handler: The callback handler for this request. The parameters for this handler are:
    ///     - `object`: The object decoded from the JSON data returned by the request.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func perform<T: JSONDecodable>(handler: @escaping SKDecodedRequestHandler<T>) {

        perform { (data, error) in
            guard data != nil, error == nil else {
                handler(nil, error)
                return
            }
            
            do {
                let object = try T.init(from: data!)
                handler(object, nil)
                return
            } catch {
                handler(nil, error)
                return
            }
        }
    }
}



// MARK: - Search Requests

/// The callback handler for a search request.
///
/// - Parameters:
///     - results: An `SKSearchResults` object containing paged results for any albums, artists, tracks, or playlists returned by the search.
///     - error: An error object identifying if and why the request failed, or `nil` if the request was successful.
public typealias SKSearchResultsHandler = (_ results: SKSearchResults?, _ error: Error?) -> Void

/// An object containing paged results for any albums, artists, tracks, or playlists returned by a search request.
public struct SKSearchResults: JSONDecodable {
    public let albums: PagedCollection<SKAlbum>?
    public let artists: PagedCollection<SKArtist>?
    public let tracks: PagedCollection<SKTrack>?
    public let playlists: PagedCollection<SKPlaylist>?
}

/// An enumeration representing the types of SpotifyKit objects returned by a search request.
public enum SKSearchResultType: String, URLEncodable {
    case albums = "album"
    case artists = "artist"
    case tracks = "track"
    case playlists = "playlist"
}

extension Array where Element == SKSearchResultType {

    /// A convenience property containing all possible search result types: `.album`, `.artist`, `.track`, and `.playlist`.
    public static let all: [SKSearchResultType] = [.albums, .artists, .tracks, .playlists] // Consider using an OptionSet instead.
}

/// The fields by which a search request can be filtered.
public enum SKSearchFieldFilter { // Convert this to a struct? Store string conversion as a closure-typed var?
    case album(String)
    case artist(String)
    case track(String)
    case genre(String)
    case year(DateInterval)
    case tag(SKSearchTag)
    case isrc(String)
    case upc(String)
}

/// The tags available when filtering a search request.
public enum SKSearchTag: String {
    
    /// Retrieves albums released within the last two weeks.
    case new
    
    /// Retrieves albums with the lowest 10% popularity.
    case hipster
}

extension SKRequest {
    
    /// Creates an API request for searching the Spotify catalog.
    ///
    /// - Parameters:
    ///   - types: The types of objects to filter results by. Possible values are `.album`, `.artist`, `.track`, and `.playlist`, and can be provided individually or as an array. The static constant `.all` can also be used to represent an array containing all search result types.
    ///   - keywords: The search term against which to match results. **Note**: Keyword matching is *not* case-sensitive.
    ///   - alternate: An alternate search term used to broaden the search. The default value is an empty string.
    ///   - unwanted: Unwanted keywords to exclude from the search. The default value is an empty string.
    ///   - inOrder: When `false`, keywords will be matched in any order; when `true`, the search will maintain exact keyword order. The default value is `false`.
    ///   - filters: An optional list of field filters by which to narrow the search. For available filters, see `SKSearchFieldFilter`. The default value is an empty array.
    ///   - locale: The locale-specific catalog in which to search. The default value is `Locale.current`, which represents the user's region settings at the time the method is called.
    ///   - page: A page value containing parameters for pagingating the results. The default value is `nil`, with the default limit returning 20 items per page.
    ///
    /// - Returns: an `SKRequest` object containing the prepared URL request.
    public static func searchRequest(for types: [SKSearchResultType],
                                     matching keywords: String,
                                     or alternate: String = "",
                                     excluding unwanted: String = "",
                                     inOrder: Bool = false,
                                     filteredBy filters: [SKSearchFieldFilter] = [],
                                     in locale: Locale? = Locale.current,
                                     page: Page? = nil) -> SKRequest {
        
        var query: String = inOrder ? "\"" + keywords.lowercased() + "\"" : keywords.lowercased()
        
        if !alternate.isEmpty {
            query.append(" OR \(alternate.lowercased())")
        }
        
        if !unwanted.isEmpty {
            query.append(" NOT \(unwanted.lowercased())")
        }
        
        if !filters.isEmpty {
            
            for filter in filters {
                
                switch filter {
                case let .album(keywords):
                    query.append(" album:\"\(keywords)\"")
                    
                case let .artist(keywords):
                    query.append(" artist:\"\(keywords)\"")
                    
                case let .track(keywords):
                    query.append(" track:\"\(keywords)\"")
                    
                case let .genre(keywords):
                    guard types.contains(.artists) || types.contains(.tracks) else { break }
                    query.append(" genre:\"\(keywords)\"")
                    
                case let .tag(tag):
                    guard types.contains(.albums) else { break }
                    query.append(" tag:\(tag.rawValue)")
                    
                case let .upc(code):
                    guard types.contains(.albums) else { break }
                    query.append(" upc:\(code)")
                    
                case let .isrc(code):
                    guard types.contains(.tracks) else { break }
                    query.append(" isrc:\(code)") // .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                    
                case let .year(range):
                    let encoder = URLEncoder()
                    encoder.rangeSeparator = "-"
                    encoder.dateFormatter = {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy"
                        return formatter
                    }()
                    query.append(" year:\(range.urlEncodedString(using: encoder))")
                }
            }
        }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.query] = query
        parameters[Constants.QueryParameters.itemType] = types
        parameters[Constants.QueryParameters.market] = locale?.regionCode // TODO: Find a way to include the "from_token" value.
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.search, parameters: parameters)!
    }
    
    /// Performs a search request to the [Spotify Web API](https://developer.spotify.com/web-api/).
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying API request. If the session does not contain a valid access token, this request will result in an error.
    ///
    /// - Parameters:
    ///   - types: The types of objects to filter results by. Possible values are `.album`, `.artist`, `.track`, and `.playlist`, and can be provided individually or as an array. The static constant `.all` can also be used to represent an array containing all search result types.
    ///   - keywords: The search term against which to match results. **Note**: Keyword matching is *not* case-sensitive.
    ///   - alternate: An alternate search term used to broaden the search. The default value is an empty string.
    ///   - unwanted: Unwanted keywords to exclude from the search. The default value is an empty string.
    ///   - inOrder: When `false`, keywords will be matched in any order; when `true`, the search will maintain exact keyword order. The default value is `false`.
    ///   - filters: An optional list of field filters by which to narrow the search. For available filters, see `SKSearchFieldFilter`. The default value is an empty array.
    ///   - locale: The locale-specific catalog in which to search. The default value is `Locale.current`, which represents the user's region settings at the time the method is called.
    ///   - page: A page value containing parameters for pagingating the results. The default value is `nil`, with the default limit returning 20 items per page.
    ///   - resultsHandler: The callback handler for this request. The parameters for this handler are:
    ///       - `results`: An `SKSearchResults` object containing paged results for any albums, artists, tracks, or playlists returned by the search.
    ///       - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func search(for types: [SKSearchResultType],
                              matching keywords: String,
                              or alternate: String = "",
                              excluding unwanted: String = "",
                              inOrder: Bool = false,
                              filteredBy filters: [SKSearchFieldFilter] = [],
                              in locale: Locale? = Locale.current,
                              page: Page? = nil,
                              resultsHandler: @escaping SKSearchResultsHandler) {
        
        SKRequest.searchRequest(for: types,
                                matching: keywords,
                                or: alternate,
                                excluding: unwanted,
                                inOrder: inOrder,
                                filteredBy: filters,
                                in: locale,
                                page: page)
            .perform(handler: resultsHandler)
    }
}



// MARK: - SpotifyAuthentication Extensions

extension SPTSession {
    
    /// A convenience factory that creates a [Spotify Web API](https://developer.spotify.com/web-api/) request authenticated by the given session.
    ///
    /// - Parameters:
    ///   - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///   - url: The destination URL for this request.
    ///   - parameters: The parameters for this request, if any.
    ///   - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    /// - Returns: An authorized `SKRequest` instance, or `nil` if a request cannot be instantiated with the given parameters.
    public func makeRequest(method: HTTPRequestMethod, url: URL, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil) -> SKRequest? {
        
        let request = SKRequest(method: method, url: url, parameters: parameters)
        request?.apiSession = self
        request?.requestBody = requestBody
        return request
    }
    
    /// A convenience factory that creates a [Spotify Web API](https://developer.spotify.com/web-api/) request authenticated by the given session.
    ///
    /// - Parameters:
    ///   - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///   - url: The destination URL for this request.
    ///   - parameters: The parameters for this request, if any.
    ///   - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    /// - Returns: An authorized `SKRequest` instance, or `nil` if a request cannot be instantiated with the given parameters.
    public func makeRequest(method: HTTPRequestMethod, endpoint: String, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil) -> SKRequest? {
        
        let request = SKRequest(method: method, endpoint: endpoint, parameters: parameters)
        request?.apiSession = self
        request?.requestBody = requestBody
        return request
    }

    /// A convenience method that performs an authorized request to the [Spotify Web API](https://developer.spotify.com/web-api/) using the given session.
    ///
    /// If a request cannot be instantiated with the given parameters, this method will do nothing, and the provided callback handler will not be executed.
    ///
    /// - Parameters:
    ///     - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///     - url: The destination URL for this request.
    ///     - parameters: The parameters for this request, if any.
    ///     - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    ///     - handler: The callback handler for this request. The parameters for this handler are:
    ///         - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///         - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func performRequest(method: HTTPRequestMethod, url: URL, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil, handler: @escaping SKRequestHandler) {
        
        makeRequest(method: method, url: url, parameters: parameters, requestBody: requestBody)?.perform(handler: handler)
    }

    /// A convenience method that performs an authorized request to the [Spotify Web API](https://developer.spotify.com/web-api/) using the given session.
    ///
    /// If a request cannot be instantiated with the given parameters, this method will do nothing, and the provided callback handler will not be executed.
    ///
    /// - Parameters:
    ///     - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///     - endpoint: The destination endpoint for this request.
    ///     - parameters: The parameters for this request, if any.
    ///     - requestBody: A tuple value comprised of multipart data and its respective content type, if any.
    ///     - handler: The callback handler for this request. The parameters for this handler are:
    ///         - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///         - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func performRequest(method: HTTPRequestMethod, endpoint: String, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil, handler: @escaping SKRequestHandler) {
        
        makeRequest(method: method, endpoint: endpoint, parameters: parameters, requestBody: requestBody)?.perform(handler: handler)
    }
}



// MARK: - Expandable Objects

/// A type that is represented in the [Spotify Web API](https://developer.spotify.com/web-api/) by both "simplified" and "full" versions of the object, and that can be expanded from a simplified instance to a detailed one.
public protocol Expandable {
    
    /// **Required**. A link to the [Web API endpoint](https://developer.spotify.com/web-api/endpoint-reference/) providing full details of the object.
    var url: URL { get }
    
    /// A boolean value indicating whether this instance represents a "simplified" version of the "full" Spotify object (i.e., all values unique to the full object are `nil`).
    var isSimplified: Bool { get }
    
    /// Performs a request for the detailed "full" version of the given object.
    ///
    /// If the given object already contains the requested properties, this method will do nothing, and the provided callback handler will not be executed.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying API request. If the session does not contain a valid access token, this request will result in an error.
    ///
    /// - Parameter handler: The callback handler for this request, providing the detailed object if successful, and an error object identifying if and why the request or decoding failed if unsuccessful.
    func getFullObject(handler: @escaping (Self?, Error?) -> Void)
}

extension Expandable where Self: JSONDecodable {
    
    /// Creates and returns the request used to retrieve the full version of the given object.
    ///
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal func makeFullObjectRequest() -> SKRequest {
        return SKRequest(method: .GET, url: url)!
    }
    
    public func getFullObject(handler: @escaping (Self?, Error?) -> Void) {
        guard isSimplified else { return }
        makeFullObjectRequest().perform(handler: handler)
    }
}

// MARK: - Web API Constants

internal struct Constants {
    private init() {}
    static let baseURL = URL(string: "https://api.spotify.com")!
    static let accountsURL = URL(string: "https://accounts.spotify.com")!
    static let tokenType = "Bearer"
    struct HeaderFields {
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
    struct QueryParameters {
        private init() {}
        static let ids = "ids"
        static let query = "q"
        static let country = "country"
        static let market = "market"
        static let limit = "limit"
        static let offset = "offset"
        static let itemType = "type"
        static let albumType = "album_type"
    }
    struct Endpoints {
        private init() {}
        private static let version = "v1"
        
        static var albums: String             { return version/"albums" }
        static var artists: String            { return version/"artists" }
        static var audioAnalysis: String      { return version/"audio-analysis" }
        static var audioFeatures: String      { return version/"audio-features" }
        static var featuredPlaylists: String  { return version/"browse/featured-playlists" }
        static var newReleases: String        { return version/"browse/new-releases" }
        static var categories: String         { return version/"browse/categories" }
        static var me: String                 { return version/"me" }
        static var recommendations: String    { return version/"recommendations" }
        static var search: String             { return version/"search" }
        static var tracks: String             { return version/"tracks" }
        static var users: String              { return version/"users" }
        
        static var myFollows: String          { return me/"following" }
        static var mySavedAlbums: String      { return me/"albums" }
        static var mySavedTracks: String      { return me/"tracks" }
        static var myTopArtists: String       { return me/"top/artists" }
        static var myTopTracks: String        { return me/"top/tracks" }
        static var myPlaylists: String        { return me/"playlists" }
        static var player: String             { return me/"player" }
        
        static var checkIfFollowing: String   { return myFollows/"contains" }
        static var checkIfAlbumsSaved: String { return mySavedAlbums/"contains" }
        static var checkIfTracksSaved: String { return mySavedTracks/"contains" }
        
        static var recentlyPlayed: String     { return player/"recently-played" }
        static var currentlyPlaying: String   { return player/"currently-playing" }
        static var availableDevices: String   { return player/"devices" }
        static var play: String               { return player/"play" }
        static var pause: String              { return player/"pause" }
        static var next: String               { return player/"next" }
        static var previous: String           { return player/"previous" }
        static var seek: String               { return player/"seek" }
        static var volume: String             { return player/"volume" }
        static var shuffle: String            { return player/"shuffle" }
        static var `repeat`: String           { return player/"repeat" }
        
        static func album(id: String) -> String                   { return albums/id }
        static func tracksForAlbum(id: String) -> String          { return albums/id/"tracks" }
        static func artist(id: String) -> String                  { return artists/id }
        static func albumsForArtist(id: String) -> String         { return artists/id/"albums" }
        static func topTracksForArtist(id: String) -> String      { return artists/id/"top-tracks" }
        static func relatedArtistsForArtist(id: String) -> String { return artists/id/"related-artists" }
        static func audioAnalysisForTrack(id: String) -> String   { return audioAnalysis/id }
        static func audioFeaturesForTrack(id: String) -> String   { return audioFeatures/id }
        static func category(id: String) -> String                { return categories/id }
        static func playlistsForCategory(id: String) -> String    { return categories/id/"playlists" }
        static func track(id: String) -> String                   { return tracks/id }
        static func user(id: String) -> String                    { return users/id }
        
        private static let playlists = "playlists"
        static func playlistsForUser(id: String) -> String                            { return users/id/playlists }
        static func playlist(id: String, ownerID: String) -> String                   { return users/ownerID/playlists/id }
        static func imageForPlaylist(id: String, ownerID: String) -> String           { return users/ownerID/playlists/id/"images" }
        static func tracksForPlaylist(id: String, ownerID: String) -> String          { return users/ownerID/playlists/id/"tracks" }
        static func followsForPlaylist(id: String, ownerID: String) -> String         { return users/ownerID/playlists/id/"followers" }
        static func checkIfUsersFollowPlaylist(id: String, ownerID: String) -> String { return users/ownerID/playlists/id/"followers/contains" }
    }
}

extension String {
    fileprivate static func /(lhs: String, rhs: String) -> String {
        return lhs + "/" + rhs
    }
}
