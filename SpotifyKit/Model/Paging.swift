//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct Paging<Object: Decodable>: JSONDecodable { // TODO: Make JSON Codable.
        
    /// A link to the Web API endpoint returning the full result of the request.
    public let url: URL
    
    /// The array of objects.
    public let items: [Object] // TODO: Change scope to private once Collection conformance is finished.
    
    /// The maximum number of items in the response (as set in the query or by default).
    public let limit: Int
    
    /// URL to the next page of items (`nil` if none).
    public let next: URL?
    
    /// The offset of the items returned (as set in the query or by default).
    public let offset: Int
    
    /// URL to the previous page of items (`nil` if none).
    public let previous: URL?
    
    /// The total number of items available to return.
    public var count: Int { return items.count }
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case items
        case limit
        case next
        case offset
        case previous
        //case count = "total"
    }
}

// MARK: - Paging + Collection Conformance

extension Paging: Collection { // Forwards Collection logic to the Paging structure for convenience.
    
    // TODO: Test how default implementations would work without explicitly defining functions.

    public typealias Items = Array<Object>
    public typealias IndexDistance = Items.IndexDistance
    public typealias Indices = Items.Indices
    public typealias Iterator = Items.Iterator
    public typealias SubSequence = Items.SubSequence

    // MARK: - Instance Properties

    public var startIndex: Int { return items.startIndex }      // Required by _IndexableProtocol.
    public var endIndex: Int { return items.endIndex }          // Required by _IndexableProtocol.
    public var first: Items.Element? { return items.first }     // Required by Collection.
    public var indices: Items.Indices { return items.indices }  // Required by Collection.
    public var isEmpty: Bool { return items.isEmpty }           // Required by Collection.
    public var lazy: LazyCollection<Items> { return items.lazy }

    // MARK: - Instance Methods

    // Required by Collection.
    public func distance(from start: Items.Index, to end: Items.Index) -> Items.IndexDistance {
        return items.distance(from: start, to: end)
    }
    // Required by Collection.
    public func index(_ i: Items.Index, offsetBy n: Items.IndexDistance) -> Items.Index {
        return items.index(i, offsetBy: n)
    }
    // Required by Collection.
    public func index(_ i: Items.Index, offsetBy n: Items.IndexDistance, limitedBy limit: Items.Index) -> Items.Index? {
        return items.index(i, offsetBy: n, limitedBy: limit)
    }
    // Required by _IndexableProtocol.
    public func index(after i: Int) -> Int {
        return items.index(after: i)
    }
    // Does not apply.
    //public func index(of element: Items.Element) -> Items.Index? {
    //    return items.index(of: element)
    //}
    // Not required.
    public func index(where predicate: (Items.Element) throws -> Bool) rethrows -> Items.Index? {
        return try items.index(where: predicate)
    }
    // Does not apply. (Objects won't be collections themselves.)
    //public func joined() -> FlattenCollection<Items> {
    //    return items.joined()
    //}
    // Not required.
    public func makeIterator() -> Items.Iterator {
        return items.makeIterator()
    }
    // Required by Collection.
    public func prefix(through position: Items.Index) -> Items.SubSequence {
        return items.prefix(through: position)
    }
    // Required by Collection.
    public func prefix(upTo end: Items.Index) -> Items.SubSequence {
        return items.prefix(upTo: end)
    }
    // Required by Collection.
    public func suffix(from start: Items.Index) -> Items.SubSequence {
        return items.suffix(from: start)
    }
    
    // MARK: Subscripts

    // Required by Collection.
    public subscript(position: Items.Index) -> Items.Element {
        return items[position]
    }
    // Required by Collection.
    public subscript(bounds: Range<Items.Index>) -> Items.SubSequence {
        return items[bounds]
    }
}

extension Paging: RandomAccessCollection {
    // TODO: Test how default implementations would work without explicitly defining functions.
}

extension Paging: BidirectionalCollection {
    // TODO: Test how default implementations would work without explicitly defining functions.
}

// MARK: - Paging + Sequence Conformance

extension Paging: Sequence { // Forwards Sequence logic (that wasn't already defined in 'Collection') to the Paging structure for convenience.
    
    public typealias Element = Items.Element
    
    // TODO: Test how default implementations would work without explicitly defining functions.
}
