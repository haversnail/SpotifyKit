//
//  JSONCodable.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public typealias JSONCodable = JSONDecodable & JSONEncodable

/// A type that can decode itself from a JSON representation.
public protocol JSONDecodable: Decodable {
    
    /// Creates and returns a SpotifyKit object from the specified JSON data.
    /// - Note: The default implementation of this method decodes date values using the ISO 8601 timestamp format [specified by the Web API](https://developer.spotify.com/web-api/user-guide/#timestamps). If your need another date decoding strategy, you must provide your own custom implementation.
    /// - Parameter jsonData: The data object containing the JSON-encoded Spotify data.
    init(from jsonData: Data) throws
}

extension JSONDecodable {
    public init(from jsonData: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

/// A type that can encode itself to a JSON representation.
public protocol JSONEncodable: Encodable {
    // TODO: Design JSONEncodable.
}
