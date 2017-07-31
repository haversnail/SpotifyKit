//
//  SavedItem.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A Spotify object type that a user can save to his or her library.
public protocol UserSavable {}

/// A generic structure representing a Spotify media item that has been saved to the user's library.
public struct SavedItem<Object: UserSavable & Decodable> { // TODO: Make Codable.
    
    /// The date and time the item was saved.
    public let dateAdded: Date
    
    /// The SK media item that was saved.
    /// - Note: Instead of creating a distinct type for every "savable" Spotify object, this loosely-typed `_item` container (which stores the decoded JSON object) is maintained at the `private` scope and is used in tandem with constrained extensions to provide the correctly-typed (and named) media item for each object type.
    ///
    /// Although Spotify confines this object type to only albums and tracks for now, this "saved item" model for Spotify Library content could easily include other media items in the future. This approach provides a more scalable solution that avoids polluting the module's namespace each time a new type becomes savable.
    private let _item: Any // UserSavable & Decodable
    
    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case dateAdded = "added_at"
        case album
        case track
    }
}

// MARK: - Custom Decoding

extension SavedItem: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateAdded = try values.decode(Date.self, forKey: .dateAdded)
        
        switch Object.self {
            case is SKAlbum.Type: _item = try values.decode(SKAlbum.self, forKey: .album)
            case is SKTrack.Type: _item = try values.decode(SKTrack.self, forKey: .track)
            default:
                let context = DecodingError.Context(codingPath: values.codingPath, debugDescription: "Type does not match any possible user-saveable object types.")
                throw DecodingError.typeMismatch(Object.self, context)
        }
    }
}

// MARK: - Type-Constrained Extensions

extension SavedItem where Object == SKAlbum { // FIXME: Using concrete type constraint doesn't "hide" properties like protocol constraints do.
    /// Information about the album.
    /// - Note: This property is only available when the saved item is of type `SKAlbum`.
    public var album: SKAlbum { return _item as! SKAlbum }
}

extension SavedItem where Object == SKTrack {
    /// Information about the track.
    /// - Note: This property is only available when the saved item is of type `SKTrack`.
    public var track: SKTrack { return _item as! SKTrack }
}
