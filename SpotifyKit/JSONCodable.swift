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
    /// - Parameter data: The data object containing the JSON-encoded Spotify data.
    init?(data: Data)
}

extension JSONDecodable {
    
    public init?(data: Data) {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            self = try decoder.decode(Self.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch DecodingError.keyNotFound(let key, let context) {
            print(context.debugDescription, "A matching JSON key couldn't be found for the \"\(key)\" coding key.")
            return nil
        } catch DecodingError.typeMismatch(_, let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch DecodingError.valueNotFound(_, let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch {
            print("Untyped error:", error)
            return nil
        }
    }
}

/// A type that can encode itself to a JSON representation.
public protocol JSONEncodable: Encodable {
    // TODO: Design JSONEncodable.
}
