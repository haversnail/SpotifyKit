//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A generic structure representing a paginated container for an array of Spotify objects.
///
/// This collection can either be *offset-based* or *cursor-based* depending on the [type of paging object](https://developer.spotify.com/web-api/object-model/#paging-object) returned by the Spotify Web API.
public struct PagedCollection<Object: Decodable>: JSONDecodable { // TODO: Make JSON Codable.
    
    /// The array of objects.
    private let _items: [Object]
    
    /// The maximum number of items in the response (as set in the query or by default).
    public let limit: Int
    
    /// URL to the next page of items (`nil` if none).
    public let nextURL: URL?
    
    /// The offset of the items returned (as set in the query or by default).
    public let offset: Int
    
    /// URL to the previous page of items (`nil` if none).
    public let previousURL: URL?
    
    /// The cursors used to find the next set of items. See The [Spotify Web API Object Model](https://developer.spotify.com/web-api/object-model/#cursor-object) for reference.
    public let cursors: [String: String]?
    
    /// The total number of items available to return.
    /// - Note: To retrieve the number of items currently returned by the paging object, see "`count`" instead.
    public var total: Int
    
    /// A link to the Web API endpoint returning the full result of the request.
    public let url: URL
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case _items = "items"
        case limit
        case nextURL = "next"
        case offset
        case previousURL = "previous"
        case cursors
        case total
    }
}

// MARK: - Collection Conformance

extension PagedCollection: Collection { // Forwards Collection logic to the PagedCollection structure for convenience.
    
    public typealias Index = Array<Object>.Index

    public var startIndex: Index {
        return _items.startIndex
    }
    
    public var endIndex: Index {
        return _items.endIndex
    }
    
    public subscript(position: Index) -> Object {
        return _items[position]
    }
    
    public func index(after i: Index) -> Index {
        return _items.index(after: i)
    }
}

extension PagedCollection: BidirectionalCollection { // Extends support for backward as well as forward index traversal.
    
    public func index(before i: Index) -> Index {
        return _items.index(before: i)
    }
}

extension PagedCollection: RandomAccessCollection {} // Significantly improves efficiency for operations requiring index distance measurement.
