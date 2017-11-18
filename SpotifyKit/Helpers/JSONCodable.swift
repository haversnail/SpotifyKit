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
    
    /// Creates a SpotifyKit type from the specified JSON data.
    ///
    /// - Parameter jsonData: The data containing the JSON-encoded [Spotify object](https://developer.spotify.com/web-api/object-model/).
    ///
    /// - Note: The default implementation of this method decodes date values using the ISO 8601 timestamp format [specified by the Web API](https://developer.spotify.com/web-api/user-guide/#timestamps). If your need another date decoding strategy, you must provide your own custom implementation.
    init(from jsonData: Data) throws
}

extension JSONDecodable {
    
    /// Creates a SpotifyKit type from the specified JSON data.
    ///
    /// - Parameter jsonData: The data containing the JSON-encoded [Spotify object](https://developer.spotify.com/web-api/object-model/).
    ///
    /// - Note: The default implementation of this method decodes date values using the ISO 8601 timestamp format [specified by the Web API](https://developer.spotify.com/web-api/user-guide/#timestamps). If your need another date decoding strategy, you must provide your own custom implementation.
    public init(from jsonData: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

/// A type that can encode itself to a JSON representation.
public protocol JSONEncodable: Encodable {
    
    /// Encodes the given type to a JSON representation suitable for the [Spotify Web API](https://developer.spotify.com/web-api/).
    ///
    /// - Returns: A `Data` value containing the payload.
    /// - Throws: Any errors encountered during encoding. See [EncodingError](apple-reference-documentation://hsJCtRo9pa) for more details.
    func data() throws -> Data
}

extension JSONEncodable {
    public func data() throws -> Data {
        let encoder = JSONEncoder()
        
        encoder.dataEncodingStrategy = .base64
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted // Do we need this?
        if #available(iOS 11.0, *) {
            encoder.outputFormatting.insert(.sortedKeys)
        }
        
        return try encoder.encode(self)
    }
}

// MARK: - Array Conformance

extension Array: JSONDecodable/* where Element: Decodable */{ // FIXME: Uncomment when conditional conformance is available.
    
    public init(from jsonData: Data) throws {
        
        self.init() // Initialize self here so we can get type(of: self).
        guard Element.self is Decodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to 'JSONDecodable' because \(Element.self) does not conform to 'Decodable'")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // First try decoding a top-level array as normal:
        do { self = try decoder.decode([Element].self, from: jsonData) }
        
        // If we found a type other than a top-level array (which is common for many Spotify Web API requests),
        catch DecodingError.typeMismatch(_, let context) where context.debugDescription.contains("dictionary") { // "where context.valueFound is [String: Any]"
            // then try decoding as an array wrapped in a single key-value pair dictionary,
            guard let array = try decoder.decode([String: [Element]].self, from: jsonData).first?.value else {
                // throwing an error if there is no "first" element (implying the dictionary was just an empty object):
                throw DecodingError.dataCorruptedError(atCodingPath: context.codingPath, debugDescription: "JSON object is empty.")
            }
            
            self = array
        }
        
        // Otherwise, throw any other errors encountered:
        catch { throw error }
    }
}

//extension Array: JSONEncodable/* where Element: Encodable */{ // FIXME: Uncomment when conditional conformance is available.
//    // TODO: Design JSONEncodable.
//}

// MARK: - Dictionary Conformance

extension Dictionary: JSONDecodable/* where Key: Decodable, Value: Decodable */{ // FIXME: Uncomment when conditional conformance is available.
    
    public init(from jsonData: Data) throws {
        
        self.init() // Initialize self here so we can get type(of: self).
        guard Key.self is Decodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to 'JSONDecodable' because \(Key.self) does not conform to 'Decodable'")
        }
        
        guard Value.self is Decodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to 'JSONDecodable' because \(Value.self) does not conform to 'Decodable'")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode([Key: Value].self, from: jsonData)
    }
}

//extension Dictionary: JSONEncodable/* where Key: Encodable, Value: Encodable */{ // FIXME: Uncomment when conditional conformance is available.
//    // TODO: Design JSONEncodable.
//}

// MARK: - Optional Conformance

extension Optional: JSONDecodable/* where Wrapped: Decodable */{ // FIXME: Uncomment when conditional conformance is available.
    
    public init(from jsonData: Data) throws {
        
        self = .none // Initialize self here so we can get type(of: self).
        guard Wrapped.self is Decodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to 'JSONDecodable' because \(Wrapped.self) does not conform to 'Decodable'")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode(Wrapped?.self, from: jsonData)
    }
}

//extension Optional: JSONEncodable/* where Wrapped: Encodable */{ // FIXME: Uncomment when conditional conformance is available.
//    // TODO: Design JSONEncodable.
//}

// MARK: - Decoding Error Convenience Methods

extension DecodingError {
    
    /// A convenience method which creates a new .dataCorrupted error using the given coding path and debug description.
    ///
    /// - Parameters:
    ///   - codingPath: The path of `CodingKeys` taken to get to the point of the failing decode call.
    ///   - debugDescription: A description of what went wrong, for debugging purposes.
    internal static func dataCorruptedError(atCodingPath codingPath: [CodingKey], debugDescription: String, underlyingError: Error? = nil) -> DecodingError {
        return .dataCorrupted(Context(codingPath: codingPath, debugDescription: debugDescription, underlyingError: underlyingError))
    }
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
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot initialize \(Self.self) from invalid \(RawValue.self) value \"\(decoded)\" or any case-sensitive variant."))
        }
        
        self = value
    }
}
