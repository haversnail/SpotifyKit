//
//  SavedItem.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A Spotify object type that a user can save to his or her library. Because the `UserSavable` protocol has no requirements of its own, you can declare conformance on any type that Spotify supports with no additional code.
public protocol UserSavable {}

/// A generic structure representing a Spotify media item that has been saved to the user's library.
public struct SavedItem<Object: UserSavable & Decodable> {
    
    /// The date and time the item was saved.
    public let dateAdded: Date
    
    /// The SK media item that was saved.
    /// - Note: Instead of creating a distinct type for every "savable" Spotify object, this loosely-typed `_item` container (which stores the decoded JSON object) is maintained at the `private` scope and is used in tandem with constrained extensions to provide the correctly-typed (and named) media item for each object type.
    ///
    /// Although Spotify confines this object type to only albums and tracks for now, this "saved item" model for Spotify Library content could easily include other media items in the future. This approach provides a more scalable solution that avoids polluting the module's namespace each time a new type becomes savable.
    private let _item: Any // UserSavable & Decodable
}

// MARK: - Custom Decoding

extension SavedItem: Decodable {
    
    // MARK: Keys
    
    fileprivate struct ItemKey: CodingKey {
        public var stringValue: String
        public var intValue: Int?
        
        public init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        public init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        
        static var dateAdded: ItemKey { return ItemKey(stringValue: "added_at")! } // The compiler won't let us create stored static vars for generic objects. :(
    }
    
    // MARK: Initializer
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemKey.self)
        
        assert(values.allKeys.count == 2, "There should be exactly two keys in any Saved Item object!")
        
        // Knowing there are only two keys, get the one that isn't "dateAdded":
        guard let itemKey = values.allKeys.first(where: { $0 != .dateAdded }) else {
            // and throw an error if we can't:
            throw DecodingError.dataCorruptedError(atCodingPath: values.codingPath, debugDescription: "No object key could be found in the encoded payload.")
        }

        dateAdded = try values.decode(Date.self, forKey: .dateAdded)
        _item = try values.decode(Object.self, forKey: itemKey)
    }
}

extension SavedItem.ItemKey: Equatable {
    static func ==(lhs: SavedItem.ItemKey, rhs: SavedItem.ItemKey) -> Bool {
        return lhs.stringValue == rhs.stringValue && lhs.intValue == rhs.intValue
    }
}

// MARK: - Type-Constrained Extensions

extension SavedItem where Object == SKAlbum { // Using concrete type constraint doesn't "hide" properties like protocol constraints do. // FIXME: Consider protocol conformance.
    /// Information about the album.
    /// - Note: This property is only available when the saved item is of type `SKAlbum`.
    public var album: SKAlbum { return _item as! SKAlbum }
}

extension SavedItem where Object == SKTrack {
    /// Information about the track.
    /// - Note: This property is only available when the saved item is of type `SKTrack`.
    public var track: SKTrack { return _item as! SKTrack }
}
