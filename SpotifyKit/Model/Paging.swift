//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct Paging/* PagingCollection / PagedCollection / PaginatedCollection */<Object: Decodable>: JSONDecodable { // TODO: Make JSON Codable.
    
    /// The array of objects.
    private let _items: [Object]
    
    /// The maximum number of items in the response (as set in the query or by default).
    public let limit: Int
    
    /// URL to the next page of items (`nil` if none).
    public let next: URL?
    
    /// The offset of the items returned (as set in the query or by default).
    public let offset: Int
    
    /// URL to the previous page of items (`nil` if none).
    public let previous: URL?
    
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
        case next
        case offset
        case previous
        case total
    }
}

// MARK: - Paging + Collection Conformance

extension Paging: Collection { // Forwards Collection logic to the Paging structure for convenience.
    
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

extension Paging: BidirectionalCollection { // Extends support for backward as well as forward index traversal.
    
    public func index(before i: Index) -> Index {
        return _items.index(before: i)
    }
}

extension Paging: RandomAccessCollection {} // Significantly improves efficiency for operations requiring index distance measurement.
