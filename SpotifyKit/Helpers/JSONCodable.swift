//
//  JSONCodable.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

// MARK: JSON Encoding & Decoding

public typealias JSONCodable = JSONDecodable & JSONEncodable

/// A type that can decode itself from a JSON representation.
public protocol JSONDecodable: Decodable {
    
    /// Creates a SpotifyKit object from the specified JSON data.
    ///
    /// - Parameter jsonData: The data object containing the JSON-encoded Spotify object.
    ///
    /// - Note: The default implementation of this method decodes date values using the ISO 8601 timestamp format [specified by the Web API](https://developer.spotify.com/web-api/user-guide/#timestamps). If your need another date decoding strategy, you must provide your own custom implementation.
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

// MARK: - Raw Representable Decoding + Case Tolerance
//
// In some instances, certain objects returned by the Web API contain strings
// whose formatting differs from their expected or documented values. For
// example, when requesting "recommendations based on seeds," cartain fields
// that are otherwise always lowercased strings are returned in all caps —
// making raw representable types based on these fields hard to instantiate.
// The following extension provides a succinct solution to this case-sensitive
// conflict by implicitly converting each raw value between lowercase,
// uppercase, and sentence cases before throwing an error any time we decode
// a raw representable type.
//
extension RawRepresentable where RawValue == String, Self: Decodable {
    public init(from decoder: Decoder) throws {
        let decoded = try decoder.singleValueContainer().decode(RawValue.self)

        guard let value = Self(rawValue: decoded) ??
                          Self(rawValue: decoded.lowercased()) ??
                          Self(rawValue: decoded.uppercased()) ??
                          Self(rawValue: decoded.capitalized)
        else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot initialize \(Self.self) from invalid \(RawValue.self) value \"\(decoded)\" or any case-sensitive variant"))
        }
        
        self = value
    }
}
