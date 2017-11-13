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



// MARK: SKRequestHandler

/// The callback handler for a request.
///
/// - Parameters:
///     - data: The data (typically an encoded JSON object) returned by the request, if any. If the data returned represents an API-specific error object, that object will be provided via the `error` parameter instead.
///     - status: The API-specific HTTP status code associated with the request reponse. If the underlying URL request could not be completed successfully, or the URL response contained an unexpected status code, this parameter will be `nil`.
///     - error: An error identifying if and why the request failed, or `nil` if the request was successful.
public typealias SKRequestHandler = (_ data: Data?, _ status: HTTPStatusCode?, _ error: Error?) -> Void // or `SKRequest.ResponseHandler`?

/// The callback handler for a request.
///
/// - Parameters:
///     - type: The type decoded from the JSON data returned by the request. If the type could not be decoded from the data received, the `error` parameter will provide details.
///     - error: An error identifying if and why the request or decoding failed, or `nil` if the request was successful.
public typealias SKDecodableHandler<T: JSONDecodable> = (_ type: T?, _ error: Error?) -> Void

/// The callback handler for a request.
///
/// - Parameter error: An error identifying if and why the request or decoding failed, or `nil` if the request was successful.
public typealias SKErrorHandler = (_ error: Error?) -> Void



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
    public lazy var urlSession: URLSession = URLSession(configuration: .default) // or `URLSession.shared`?
//    public lazy var urlSession: URLSession = {
//        let configuration = URLSessionConfiguration.default
//        return URLSession(configuration: configuration)
//    }()

    /// The authenticated Spotify API session used to authorize the request.
    ///
    /// Setting this property with your active `SPTSession` instance ensures your API request is accompanied by the appropriate OAuth access token.
    ///
    /// The default value is the current `session` object referenced by the [SPTAuth](https://spotify.github.io/ios-sdk/Classes/SPTAuth.html) class's default instance.
    public weak var apiSession: SPTSession? = SPTAuth.defaultInstance()?.session // or `nil`?
    
    /// A tuple value storing multipart request body data and its associated MIME content type.
    internal var requestBody: (data: Data, type: ContentType)? = nil // fileprivate

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
//                let encodedValue = (value as! URLEncodable).string(using: encoder)
//                items.append(URLQueryItem(name: key, value: encodedValue))
//            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            
            // Create the array of query items by:
            // 1. filtering out those values that aren't URL-encodable,
            // 2. mapping the remaining key/value pairs to a new `URLQueryItem`, encoding the value as a URL-compatible string.
            components?.queryItems = parameters
                .lazy
                .filter { $0.value is URLEncodable }
                .map { return URLQueryItem(name: $0.key, value: ($0.value as! URLEncodable).string(using: .`default`)) }
            
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
    ///     - `error`: An error identifying if and why the request or decoding failed, or `nil` if the request was successful.
    public func perform(handler: @escaping SKRequestHandler) {

        //let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: preparedURLRequest) { (data, response, error) in // let taskHandler: (Data?, URLResponse?, Error?) -> Void =

            // First, handle 'error' - if any URL loading errors were encountered, forward and return here:
            if let error = error {
                handler(nil, nil, error)
                return
            }

            // Next, handle the URL response - make sure that it is in fact an HTTP URL response:
            guard let response = response as? HTTPURLResponse else {
                assertionFailure("Performing any request to the Spotify Web API is an HTTPS request and should therefore always return an HTTPURLResponse object.")
                handler(nil, nil, URLError(.unsupportedURL))
                return
            }

            // Next, make sure the status code of that response matches one of the expected HTTP status codes:
            guard let statusCode = HTTPStatusCode(rawValue: response.statusCode) else {
                assertionFailure("Received an unexpected status code from the Spotify Web API: \(response.statusCode)")
                handler(nil, nil, nil) // TODO: Return an "unknown status code" error.
                return
            }
            
            print(statusCode)

            // Next, handle the data - if no data was returned by this request, then just return the status code:
            guard let data = data else {
                handler(nil, statusCode, nil)
                return
            }
            
            // If the data represents an error object returned by the Web API, handle it here:
            if let apiError = try? SKError(from: data) {
                handler(nil, statusCode, apiError)
                return
            }

            // Likewise, if the data represents an authentication error object, handle it here:
            if let authError = try? SKAuthenticationError(from: data) {
                handler(nil, statusCode, authError)
                return
            }

            // TODO: Handle Conditional Requests.

            // Finally, if we did not receive any URL errors, and any data received was not an API error object, then return the data and status code:
            handler(data, statusCode, nil)
        }
        
//        let task: URLSessionTask
//
//        //switch method {
//        //    case .PUT, .POST: ...
//        //    default: ...
//        //}
//
//        switch requestBody {
//            case .some(let body): task = urlSession.uploadTask(with: preparedURLRequest, from: body.data, completionHandler: taskHandler)
//            case .none: task = urlSession.dataTask(with: preparedURLRequest, completionHandler: taskHandler)
//        }

        task.resume()
        //urlSession.finishTasksAndInvalidate()
    }
    
    /// Performs the request, decoding the JSON data returned by the request to the given type and calling the specified handler when complete.
    ///
    /// - Parameter handler: The callback handler for this request. The parameters for this handler are:
    ///     - `type`: The type decoded from the JSON data returned by the request.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func perform<T: JSONDecodable>(handler: @escaping SKDecodableHandler<T>) {

        perform { (data, _, error) in
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
    
    /// Performs the request, calling the specified handler when complete.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error identifying if and why the request failed, or `nil` if the request was successful.
    public func perform(handler: @escaping SKErrorHandler) {
        perform { (_, _, error) in
            handler(error)
        }
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
    ///         - `error`: An error identifying if and why the request failed, or `nil` if the request was successful.
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
    ///         - `error`: An error identifying if and why the request failed, or `nil` if the request was successful.
    public func performRequest(method: HTTPRequestMethod, endpoint: String, parameters: [String: Any] = [:], requestBody: (Data, SKRequest.ContentType)? = nil, handler: @escaping SKRequestHandler) {
        
        makeRequest(method: method, endpoint: endpoint, parameters: parameters, requestBody: requestBody)?.perform(handler: handler)
    }
}
