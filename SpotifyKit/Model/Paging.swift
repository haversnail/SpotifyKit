//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A structure representing the parameters for pagingating the elements of a larger collection.
///
/// If no parameters are supplied, requests will return 20 items by default, beginning with the first item.
public struct PageParameters { // Pag(e/ing)/PageIndex/PageIterator/PageParameters/PageOptions/PageConstraints
    
    /// The number of items to be contained in the page.
    public var limit: Int // count/capacity
    
    /// The index of the first item to be contained in the page. If `nil` or no value is supplied, then the first item in the page will represent the first item in the overall collection (i.e., the item at index `0`).
    public var offset: Int? = nil // index
    
    
    /// Creates a set of page parameters based on limit and offset.
    ///
    /// - Parameters:
    ///   - limit: The number of items to be contained in the page. The maximum value for any given request is 50 items.
    ///   - offset: The index of the first item contained in the page. The default value is `nil`, meaning that the first item in the overall collection will be the first item in the page (i.e., the item at index `0`).
    public init(limit: Int, offset: Int? = nil) {
        self.limit = limit
        self.offset = offset
    }
    
    /// Creates a set of page parameters based on limit and page number.
    ///
    /// - Parameters:
    ///   - limit: The number of items to be contained in the page. The maximum value for any given request is 50 items.
    ///   - page: The page "number," based on the number of items in each page. For example, with limit of `20`, page `1` would contain items at indices `0-19`, page `2` would contain items at indices `20-39`, and so on.
    public init(limit: Int, page: Int) {
        self.limit = limit
        self.offset = page > 1 ? limit * (page - 1) : nil
    }
    
//    func advancing(by numberOfPages: Int = 1) -> PageParameters {
//        return PageParameters(limit: limit, offset: (offset ?? 0) + (limit * numberOfPages))
//    }
//
//    mutating func advance(by numberOfPages: Int = 1) {
//        offset = (offset ?? 0) + (limit * numberOfPages)
//    }
}



// MARK: - Collection

/// A generic collection used to paginate results from a [Spotify Web API](https://developer.spotify.com/web-api/) request.
///
/// This collection can either be *offset-based* or *cursor-based* depending on the [type of paging object](https://developer.spotify.com/web-api/object-model/#paging-object) returned by the API.
public struct Page<Element: Decodable>: JSONDecodable {
    
    /// Contains paging cursors used to find the adjacent pages of items.
    public struct Cursors: Decodable {
        
        /// The cursor to use as a key to find the previous page of items.
        public let before: String?
        
        /// The cursor to use as a key to find the next page of items.
        public let after: String?
    }
    
    /// The array of objects.
    private let _items: [Element]
    
    /// The maximum number of items in the response (as set in the query or by default).
    public let limit: Int
    
    /// URL to the next page of items (`nil` if none).
    public let nextURL: URL?
    
    /// The offset of the items returned (as set in the query or by default). This property will be `nil` if the collection is a cursor-based paging object.
    public let offset: Int?
    
    /// URL to the previous page of items (`nil` if none).
    public let previousURL: URL?
    
    /// The cursors used to find the next set of items. See The [Spotify Web API Object Model](https://developer.spotify.com/web-api/object-model/#cursor-object) for reference.
    public let cursors: Cursors?
    
    /// The total number of items available to return. Note that not all paging objects return this value (for example, when fetching a list of recently played tracks).
    /// - Note: To retrieve the number of items currently returned by the paging object, see "`count`" instead.
    public var total: Int?
    
    /// A link to the Web API endpoint returning the full result of the request.
    public let url: URL
    
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

    public init(from jsonData: Data) throws {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        // First try decoding a paged collection object as normal:
        do { self = try decoder.decode(Page<Element>.self, from: jsonData) }
        
        // If we're not finding the keys we're expecting,
        catch DecodingError.keyNotFound(_, let context) {
            // then try decoding as a paged collection wrapped in a single key-value pair dictionary,
            guard let collection = try decoder.decode([String: Page<Element>].self, from: jsonData).first?.value else {
                // throwing an error if the dictionary object is empty:
                throw DecodingError.dataCorruptedError(atCodingPath: context.codingPath, debugDescription: "JSON object is empty.")
            }
            
            self = collection
        }
        
        // Otherwise, throw any other errors encountered:
        catch { throw error }
    }
}

// MARK: - Collection Conformance

extension Page: Collection { // Forwards Collection logic to the Page structure for convenience.
    
    public typealias Index = Array<Element>.Index

    public var startIndex: Index {
        return _items.startIndex
    }
    
    public var endIndex: Index {
        return _items.endIndex
    }
    
    public subscript(position: Index) -> Element {
        return _items[position]
    }
    
    public func index(after i: Index) -> Index {
        return _items.index(after: i)
    }
}

extension Page: BidirectionalCollection { // Extends support for backward as well as forward index traversal.
    
    public func index(before i: Index) -> Index {
        return _items.index(before: i)
    }
}

extension Page: RandomAccessCollection {} // Guarantees O(1) efficiency for operations requiring index distance measurement.
