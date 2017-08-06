//
//  Error.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: Error Object

public struct SKError: Error, JSONDecodable {
    
    /// The HTTP status code (also returned in the response header; see `HTTPStatusCode` for possible values or [Response Status Codes](https://developer.spotify.com/web-api/user-guide/#response-status-codes) for more information).
    public let status: HTTPStatusCode
    
    /// A short description of the cause of the error.
    public let message: String
}

extension SKError: Decodable {
    
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
        status = try values.decode(HTTPStatusCode.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)
    }
}

// MARK: Error Localization

extension SKError: LocalizedError {
    public var errorDescription: String? { return "Receieved a \(status.rawValue) error: \(message)." }
}

// MARK: - Authentication Error Object

public struct SKAuthenticationError: Error, JSONDecodable {
    
    /// A high level description of the error as specified in [RFC 6749 Section 5.2](https://tools.ietf.org/html/rfc6749#section-5.2).
    public let error: String
    
    /// A more detailed description of the error as specified in [RFC 6749 Section 4.1.2.1](https://tools.ietf.org/html/rfc6749#section-4.1.2.1).
    public let errorDetails: String
    
    private enum CodingKeys: String, CodingKey {
        case error
        case errorDetails = "error_description" // Renamed to avoid confusion with the `LocalizedError` protocol property.
    }
}

// MARK: Error Localization

extension SKAuthenticationError: LocalizedError {
    public var errorDescription: String? { return "Received a \"\(error)\" error: \(errorDetails)." }
}
