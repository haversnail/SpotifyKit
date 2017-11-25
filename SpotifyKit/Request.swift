//
//  Request.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale.
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

/// The [Response Status Codes][Guide] used by the Spotify Web API, as defined in the [RFC 2616] and [RFC 6585].
///
/// [Guide]: https://developer.spotify.com/web-api/user-guide/#response-status-codes
/// [RFC 2616]: https://www.ietf.org/rfc/rfc2616.txt
/// [RFC 6585]: https://www.ietf.org/rfc/rfc6585.txt
public struct SKResponseStatus {
    
    /// The underlying HTTP status code.
    public let code: Int
    
    // MARK: API Status Codes
    
    /// The request has succeeded. The client can read the result of the request in the body and the headers of the response.
    public static let ok = SKResponseStatus(code: 200)
    
    /// The request has been fulfilled and resulted in a new resource being created.
    public static let created = SKResponseStatus(code: 201)
    
    /// The request has been accepted for processing, but the processing has not been completed.
    public static let accepted = SKResponseStatus(code: 202)
    
    /// The request has succeeded but returns no message body.
    public static let noContent = SKResponseStatus(code: 204)
    
    /// The response has not changed. See [Conditional requests](https://developer.spotify.com/web-api/user-guide/#conditional-requests) for more details.
    public static let notModified = SKResponseStatus(code: 304)
    
    /// The request could not be understood by the server due to malformed syntax. The message body will contain more information. See [Error Details](https://developer.spotify.com/web-api/user-guide/#error-details) for more details.
    public static let badRequest = SKResponseStatus(code: 400)
    
    /// The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials.
    public static let unauthorized = SKResponseStatus(code: 401)
    
    /// The server understood the request, but is refusing to fulfill it.
    public static let forbidden = SKResponseStatus(code: 403)
    
    /// The requested resource could not be found. This error can be due to a temporary or permanent condition.
    public static let notFound = SKResponseStatus(code: 404)
    
    /// [Rate limiting](https://developer.spotify.com/web-api/user-guide/#rate-limiting) has been applied.
    public static let tooManyRequests = SKResponseStatus(code: 429)
    
    /// An internal server error has occurred. Although unlikely, if you receive this error, please report it [here](https://github.com/spotify/web-api/issues).
    public static let internalServerError = SKResponseStatus(code: 500)
    
    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    public static let badGateway = SKResponseStatus(code: 502)
    
    /// The server is currently unable to handle the request due to a temporary condition which will be alleviated after some delay. You can choose to resend the request again.
    public static let serviceUnavailable = SKResponseStatus(code: 503)
}

extension SKResponseStatus: Equatable {
    
    // MARK: Comparing Status Codes
    
    public static func ==(lhs: SKResponseStatus, rhs: SKResponseStatus) -> Bool {
        return lhs.code == rhs.code
    }
}

extension SKResponseStatus: Decodable {
    
    // MARK: Decoding
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        self.code = try value.decode(Int.self)
    }
}

extension SKResponseStatus: CustomStringConvertible {
    
    // MARK: Localized Status Description
    
    public var description: String {
        switch self {
            case .ok:                   return "OK"
            case .created:              return "Created"
            case .accepted:             return "Accepted"
            case .noContent:            return "No Content"
            case .notModified:          return "Not Modified"
            case .badRequest:           return "Bad Request"
            case .unauthorized:         return "Unauthorized"
            case .forbidden:            return "Forbidden"
            case .notFound:             return "Not Found"
            case .tooManyRequests:      return "Too Many Requests"
            case .internalServerError:  return "Internal Server Error"
            case .badGateway:           return "Bad Gateway"
            case .serviceUnavailable:   return "Service Unavailable"
            default:
                return "Unexpected status: " + HTTPURLResponse.localizedString(forStatusCode: code)
        }
    }
}

extension SKResponseStatus: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description + " (\(code))"
    }
}

//public struct SKResponse {
//    let status: SKResponseStatus
//    let body: Data?
//    let entityTag: String?
//}

/// The callback handler for a request.
///
/// - Parameters:
///     - data: The data (typically an encoded JSON object) returned by the request, if any. If the data returned represents an API-specific error object, that object will be provided via the `error` parameter instead.
///     - status: The API-specific HTTP status code associated with the response. If the underlying URL request could not be completed successfully, or the URL response contained an unexpected status code, this parameter will be `nil`.
///     - error: An error identifying if and why the request failed, or `nil` if the request was successful.
public typealias SKRequestHandler = (_ data: Data?, _ status: SKResponseStatus?, _ error: Error?) -> Void

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
//public typealias SKPlaylistSnapshotHandler = (_ snapshotID: String?, _ error: Error?) -> Void

// MARK: - Request Class

/// An abstract class that represents a request to the [Spotify Web API](https://developer.spotify.com/web-api/).
///
/// An `SKRequest` object encapsulates the properties of an HTTP request, providing a convenient template for you to create, prepare, and send requests to the Web API. See the API [Requests Guide](https://developer.spotify.com/web-api/user-guide/#requests) for more details.
public class SKRequest { // Inheriting from NSObject causes buildtime error: class conflicts with StoreKit's `SKRequest` class.
    
    // MARK: Supporting Types
    
    /// The HTTP verbs used by the Spotify Web API.
    ///
    /// See the API [Requests Guide](https://developer.spotify.com/web-api/user-guide/#requests) for more details.
    public enum HTTPMethod: String {
        
        /// Used for retrieving resources.
        case GET
        
        /// Used for creating resources.
        case POST
        
        /// Used for changing/replacing resources or collections.
        case PUT
        
        /// Used for deleting resources.
        case DELETE
    }
    
    /// The MIME content types available for sending multipart requests to the [Spotify Web API](https://developer.spotify.com/web-api/).
    ///
    /// - Note: The only content types currently accepted by the Spotify Web API are `application/json` and `image/jpeg` for all PUT, POST, or DELETE requests. If/when more content types become part of the API, they will be made available here.
    public enum ContentType: String {
        
        /// Represents UTF-8 encoded JSON data. This is the format for nearly all PUT, POST, and DELETE requests to the API.
        case json = "application/json"
        
        /// Represents Base64 encoded JPEG image data. This is the format used when uploading images to the API (e.g., when uploading a [custom playlist cover image](https://developer.spotify.com/web-api/upload-a-custom-playlist-cover-image/)).
        case jpeg = "image/jpeg"
    }
    
    // MARK: Request Properties

    /// The HTTP method used for this request.
    public let method: HTTPMethod

    /// The destination URL for this request.
    public let url: URL

    /// The parameters for this request, if any. If no parameters are supplied, this will be an empty dictionary.
    public let parameters: [String: Any]
    //public let parameters: [String: URLEncodable]
    
//    public static var defaultURLSession: URLSession = {
//        let configuration = URLSessionConfiguration.default
//        return URLSession(configuration: configuration)
//    }()
//    
//    public weak static var defaultAPISession: SPTSession? = SPTAuth.defaultInstance()?.session

    /// The URL session used to perform the request.
    ///
    /// Set this property if you wish to provide a custom URL session object with which to perform the underlying network request. The default value is a URL session instance with the [default configuration](apple-reference-documentation://hs7s_hgSaq).
    ///
    /// - Important: Unless this property references the [shared URL session singleton](apple-reference-documentation://hswpyQK_SL), the session will be invalidated upon deinitialization of the `SKRequest` instance.
    public lazy var urlSession: URLSession = URLSession(configuration: .default)
    //public lazy var urlSession: URLSession = URLSession.shared

    /// The authenticated Spotify API session used to authorize the request.
    ///
    /// Setting this property with your active `SPTSession` instance ensures your API request is accompanied by the appropriate OAuth access token.
    ///
    /// The default value is the current `session` object referenced by the [SPTAuth](https://spotify.github.io/ios-sdk/Classes/SPTAuth.html) class's default instance.
    public weak var apiSession: SPTSession? = SPTAuth.defaultInstance()?.session
    
    /// A tuple value storing multipart request body data and its associated MIME content type.
    internal var body: (data: Data, type: ContentType)? = nil
    
    /// An optional entity tag against to compare the request's response.
    ///
    /// See [Conditional Requests](https://developer.spotify.com/web-api/user-guide/#conditional-requests) for more details.
    //public var entityTag: String? = nil

    /// The prepared URL used by the URL request, comprised of the initial URL and the query containing the URL-encodable elements in `parameters`.
    ///
    /// - Complexity: O(*n*), where *n* is the number of elements in `parameters`.
    private var preparedURL: URL {
        get {
            if parameters.isEmpty { return url }
            
//            // Imperative, stateful approach:
//            var items: [URLQueryItem] = []
//            let encoder = URLEncoder()
//            for (key, value) in parameters {
//                guard value is URLEncodable else { continue }
//                let encodedValue = (value as! URLEncodable).string(using: encoder)
//                items.append(URLQueryItem(name: key, value: encodedValue))
//            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = parameters
                .lazy
                .filter { $0.value is URLEncodable } // Filter our those values that aren't URL-encodable.
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
            if let body = body {
                request.httpBody = body.data
                request.addValue(body.type.rawValue, forHTTPHeaderField: Constants.HeaderFields.contentType)
            }
            
//            // Add the entity tag, if provided:
//            if let eTag = entityTag {
//                request.addValue("\"" + eTag + "\"", forHTTPHeaderField: Constants.HeaderFields.ifNoneMatch)
//            }

            return request
        }
    }

    // MARK: Creating Requests

    /// Creates a new request with the specified properties.
    ///
    /// If the URL provided does not contain either the Web API base URL (`https://api.spotify.com`), or the Web API accounts service URL (`https://accounts.spotify.com`), this initializer will fail.
    ///
    /// - Parameters:
    ///     - method: The HTTP verb to use for this API request. For possible values, see `SKRequest.HTTPMethod`.
    ///     - url: The full destination URL for this API request, comprised of either the Web API base URL (`https://api.spotify.com`) or the accounts service URL (`https://accounts.spotify.com`) and the specific endpoint from which to request data.
    ///     - parameters: The parameters to send along with the API request, if any. The values are encoded as a URL query string and appended to the destination URL.
    /// - Note: If the URL provided already contains a query string, those query items will be removed from the stored `url` property and made available through the `parameters` property instead. When both a `parameters` argument and a URL with existing query items are supplied, both are stored in the `parameters` property. Values supplied by the `parameters` argument will overwrite any conflicting values supplied by the URL query.
    public init?(method: HTTPMethod, url: URL, parameters: [String: Any] = [:]) {
        
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
    ///     - method: The HTTP verb to use for this API request. For possible values, see `SKRequest.HTTPMethod`.
    ///     - endpoint: The destination endpoint for this API request, relative to the Web API base URL (`https://api.spotify.com`).
    ///     - parameters: The parameters to send along with the API request, if any. The values are encoded as a URL query string and appended to the destination URL.
    public convenience init?(method: HTTPMethod, endpoint: String, parameters: [String: Any] = [:]) {
        
        guard let url = URL(string: endpoint, relativeTo: Constants.baseURL) else { return nil }
        
        self.init(method: method, url: url, parameters: parameters)
    }

    deinit {
        if urlSession !== URLSession.shared {       // As long as `urlSession` isn't the shared instance,
            urlSession.finishTasksAndInvalidate()   // invalidate the session once this SKRequest is deinitialized.
        }
    }
    
    // MARK: Preparing Requests
    
    /// Adds multipart request body data for a PUT, POST, or DELETE request.
    ///
    /// - Parameters:
    ///     - data: The data for the request body, typically an encoded JSON object.
    ///     - type: The MIME content type of the request body. The default value is "`application/json`."
    public func add(_ data: Data, type: ContentType = .json) {
        body = (data: data, type: type)
    }
    
//    /// Adds multipart request body JSON data for a PUT, POST, or DELETE request.
//    ///
//    /// - Parameter body: A type that can be encoded to a JSON representation.
//    /// - Throws: Any errors encountered during encoding.
//    public func add<T: JSONEncodable>(_ body: T) throws {
//        let data = try body.data()
//        self.body = (data: data, type: .json)
//    }
    
    // MARK: Sending Requests

    /// Performs the request, handling API-specific responses and calling the specified handler when complete.
    ///
    /// - Parameter handler: The callback handler for this request. The parameters for this handler are:
    ///     - `data`: The data (typically an encoded JSON object) returned by the request, if any.
    ///     - `status`: The API-specific HTTP status code associated with the response. If the underlying URL request could not be completed successfully, or the URL response contained an unexpected status code, this parameter will be `nil`.
    ///     - `error`: An error identifying if and why the request or decoding failed, or `nil` if the request was successful.
    public func perform(completion handler: @escaping SKRequestHandler) {

        //let urlSession = URLSession(configuration: .default)
        // let taskHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
        let task = urlSession.dataTask(with: preparedURLRequest) { (data, response, error) in

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
            
            // Get the status code:
            let status = SKResponseStatus(code: response.statusCode)
            print(status)
            
//            // Get the entity tag, if provided:
//            if var eTag = response.allHeaderFields[Constants.HeaderFields.eTag] as? String {
//                let quotes = CharacterSet(charactersIn: "\"")
//                let tag = eTag.trimmingCharacters(in: quotes)
//                // Return tag in handler.
//            }

            // Next, handle the data - if no data was returned by this request, then just return the status code:
            guard let data = data else {
                handler(nil, status, nil)
                return
            }
            
            // If the data represents an error object returned by the Web API, handle it here:
            if let apiError = try? SKError(from: data) {
                
                // If it's a rate-limiting error, then add the seconds left before retrying:
                if status == .tooManyRequests {
                    if let secondsLeft = response.allHeaderFields[Constants.HeaderFields.retryAfter] as? TimeInterval {
                        let message = apiError.message + "\nYou may retry in \(secondsLeft) seconds."
                        let error = SKError(status: status, message: message)
                        handler(nil, status, error)
                        return
                    }
                }
                
                handler(nil, status, apiError)
                return
            }

            // Likewise, if the data represents an authentication error object, handle it here:
            if let authError = try? SKAuthenticationError(from: data) {
                handler(nil, status, authError)
                return
            }

            // Finally, if we did not receive any URL errors, and any data received was not an API error object, then return the data and status code:
            handler(data, status, nil)
        }
        
//        let task: URLSessionTask
//        switch body {
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
    ///     - `error`: An error object identifying if and why the request or decoding failed, or `nil` if the request was successful.
    public func perform<T: JSONDecodable>(completion handler: @escaping SKDecodableHandler<T>) {

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
    public func perform(completion handler: @escaping SKErrorHandler) {
        perform { (_, _, error) in
            handler(error)
        }
    }
}

// MARK: - SpotifyAuthentication Extensions

extension SPTSession {
    
    // MARK: Request Factory Methods
    
    /// Creates a [Spotify Web API](https://developer.spotify.com/web-api/) request using the current session for authorization.
    ///
    /// - Parameters:
    ///   - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///   - url: The destination URL for this request.
    ///   - parameters: The parameters for this request, if any.
    /// - Returns: An authorized `SKRequest` instance, or `nil` if a request cannot be instantiated with the given parameters.
    public func makeRequest(method: SKRequest.HTTPMethod, url: URL, parameters: [String: Any] = [:]) -> SKRequest? {
        
        let request = SKRequest(method: method, url: url, parameters: parameters)
        request?.apiSession = self
        return request
    }
    
    /// Creates a [Spotify Web API](https://developer.spotify.com/web-api/) request using the current session for authorization.
    ///
    /// - Parameters:
    ///   - method: The HTTP verb to use for this request: `GET`, `PUT`, `POST`, or `DELETE`.
    ///   - endpoint: The destination endpoint for this request.
    ///   - parameters: The parameters for this request, if any.
    /// - Returns: An authorized `SKRequest` instance, or `nil` if a request cannot be instantiated with the given parameters.
    public func makeRequest(method: SKRequest.HTTPMethod, endpoint: String, parameters: [String: Any] = [:]) -> SKRequest? {
        
        let request = SKRequest(method: method, endpoint: endpoint, parameters: parameters)
        request?.apiSession = self
        return request
    }
}
