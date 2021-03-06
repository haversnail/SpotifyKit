//
//  Error.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
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

// MARK: Error

/// An error returned by the Spotify Web API.
///
/// - SeeAlso: The Web API [Error](https://developer.spotify.com/documentation/web-api/reference/object-model/#error-object) object.
public struct SKError: Error, JSONDecodable {
    
    /// The HTTP response status returned by the Web API.
    public let status: SKResponseStatus
    
    /// A short description of the cause of the error.
    public let message: String
}

extension SKError: Decodable {
    
    // MARK: Custom Decoding
    
    private enum ContainerKeys: String, CodingKey {
        case error
    }
    
    private enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let values = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .error)
        status = try values.decode(SKResponseStatus.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)
    }
}

extension SKError: LocalizedError {
    
    // MARK: Localized Description
    
    public var errorDescription: String? {
        return "Received a(n) \"\(status)\" (\(status.code)) error: \(message)"
    }
}

// MARK: - Authentication Error

/// An authentication error returned by the Spotify Web API.
///
/// - SeeAlso: The Web API [Authentication Error](https://developer.spotify.com/documentation/web-api/reference/object-model/#authentication-error-object) object.
public struct SKAuthenticationError: Error, JSONDecodable {
    
    /// A high-level description of the error, as specified in [RFC 6749 Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
    public let status: String
    
    /// A more detailed description of the error, as specified in [RFC 6749 Section 4.1.2.1](https://tools.ietf.org/html/rfc6749#section-4.1.2.1).
    public let message: String
    
    private enum CodingKeys: String, CodingKey {
        case status = "error"
        case message = "error_description" // Renamed to avoid confusion with the `LocalizedError` protocol property.
    }
}

extension SKAuthenticationError: LocalizedError {
    
    // MARK: Localized Description
    
    public var errorDescription: String? {
        return "Received a(n) \"\(status)\" error: \(message)"
    }
}
