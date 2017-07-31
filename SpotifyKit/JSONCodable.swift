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

// MARK: - Keyed Decoding Container + Raw Value Case Conversion
//
// In some instances, certain objects returned by the Web API contain strings
// whose formatting differs from their expected or documented values. For
// example, when requesting "recommendations based on seeds," cartain fields
// that are otherwise always lowercased strings are returned in all caps —
// making raw representable types based on these fields hard to instantiate.
// These methods, when used in a custom decoding initializer, provide better,
// more precise control over how these enum-dependent raw values are decoded.
extension KeyedDecodingContainer {
    
    enum StringDecodingStrategy {
        case capitalize
        case lowercase
        case uppercase
    }
    
    /// Decodes a value of the given string representable type for the given key, changing case if necessary.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - parameter case: The case the raw string value must be converted to in order to initialize an instance of the given type.
    /// - returns: A value of the requested type, if present for the given key and convertible to the requested case and type.
    /// - throws: `DecodingError.dataCorrupted` if the encountered value is an invalid raw value for the given type.
    func decode<T: Decodable>(_ type: T.Type, forKey key: K, toCase case: StringDecodingStrategy? = nil) throws -> T where T: RawRepresentable, T.RawValue == String {
        
        let decoded = try self.decode(String.self, forKey: key)
        
        let rawValue: String
        switch `case` {
            case .some(.capitalize): rawValue = decoded.capitalized
            case .some(.lowercase): rawValue = decoded.lowercased()
            case .some(.uppercase): rawValue = decoded.uppercased()
            case .none: rawValue = decoded
        }
        
        guard let value = type.init(rawValue: rawValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath + [key], debugDescription: "Cannot initialize \(T.self) from invalid \(T.RawValue.self) value \"\(decoded)\" or any case-sensitive variant"))
        }
        
        return value
    }
    
    /// Decodes a value of the given string representable type for the given key and changing case if necessary, if present.
    ///
    /// This method returns `nil` if the container does not have a value associated with `key`, or if the value is null. The difference between these states can be distinguished with a `contains(_:)` call.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - parameter case: The case the raw string value must be converted to in order to initialize an instance of the given type.
    /// - returns: A decoded value of the requested type, or `nil` if the `Decoder` does not have an entry associated with the given key, or if the value is a null value.
    /// - throws: `DecodingError.dataCorrupted` if the encountered value is an invalid raw value for the given type.
    func decodeIfPresent<T: Decodable>(_ type: T.Type, forKey key: K, toCase case: StringDecodingStrategy? = nil) throws -> T? where T: RawRepresentable, T.RawValue == String {
        
        guard let decoded = try self.decodeIfPresent(String.self, forKey: key) else { return nil }
        
        let rawValue: String
        switch `case` {
            case .some(.capitalize): rawValue = decoded.capitalized
            case .some(.lowercase): rawValue = decoded.lowercased()
            case .some(.uppercase): rawValue = decoded.uppercased()
            case .none: rawValue = decoded
        }
        
        guard let value = type.init(rawValue: rawValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath + [key], debugDescription: "Cannot initialize \(T.self) from invalid \(T.RawValue.self) value \"\(decoded)\" or any case-sensitive variant"))
        }
        
        return value
    }
}
