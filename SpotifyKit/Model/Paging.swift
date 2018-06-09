//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

// MARK: Paging Parameters

/// A structure representing the parameters for paginating the elements of a larger collection.
public struct Pagination {
    
    /// The number of items to be contained in the page.
    public var limit: Int
    
    /// The index of the first item to be contained in the page.
    ///
    /// If `nil` or no value is supplied, then the first item in the page will represent the first item in the overall collection (i.e., the item at index `0`).
    public var offset: Int? = nil
    
    /// Creates a set of pagination parameters based on limit and offset.
    ///
    /// - Parameters:
    ///   - limit: The number of items to be contained in the page. The maximum value for any given request is 50 items.
    ///   - offset: The index of the first item contained in the page. The default value is `nil`, meaning that the first item in the overall collection will be the first item in the page (i.e., the item at index `0`).
    public init(limit: Int, offset: Int? = nil) {
        self.limit = limit
        self.offset = offset
    }
    
    /// Creates a set of pagination parameters based on limit and page number.
    ///
    /// - Parameters:
    ///   - limit: The number of items to be contained in the page. The maximum value for any given request is 50 items.
    ///   - page: The page "number," based on the number of items in each page. For example, with limit of 20, page 1 would contain items at indices 0-19, page 2 would contain items at indices 20-39, and so on.
    public init(limit: Int, page: Int) {
        self.limit = limit
        self.offset = page > 1 ? limit * (page - 1) : nil
    }
}

// MARK: - Paging Protocols

/// A type that can be returned in a cursor-based paging collection.
///
/// The `CursorPageable` protocol is tightly linked with the `CursorProtocol` and `CursorPagingCollection` protocols. Cursor-based paging collections depend on a set of "cursors" to identify the first and last items in a given page, providing reference points from which to page through a larger list of results, typically sorted in chronological order. The type of cursor used to identify the items depends on the type of items returned in the page. Therefore, types that conform to this protocol must provide an associated cursor type that can be used to uniquely identify themselves within a paging collection.
///
/// The cursor type must also be decodable.
public protocol CursorPageable {
    
    /// A type that can be used to identify an item in a paging collection.
    associatedtype CursorType: Decodable
}

/// A type that contains a set of cursors used to identify items and traverse adjacent pages in a cursor-based paging collection.
///
/// The `CursorProtocol` protocol is tightly linked with the `CursorPageable` and `CursorPagingCollection` protocols. Cursor-based paging collections depend on a set of "cursors" to identify the first and last items in a given page, providing reference points from which to page through a larger list of results, typically sorted in chronological order. The type of cursor used to identify the items depends on the type of items returned in the page. Therefore, types that conform to this protocol must provide an associated cursor type that can be used to uniquely identify themselves within a paging collection.
public protocol CursorProtocol {
    
    /// A type that can be used to identify an item in a paging collection.
    associatedtype CursorType
    
    /// The key identifying the most recent item in the page.
    ///
    /// For paginated results that are sorted in ascending chronological order (i.e., oldest to newest), this identifer can be used to retrieve the next page of items, or—when sorted in descending chronological order (i.e., newest to oldest)—the previous page of items.
    var latest: CursorType? { get }
    
    /// The key identifying the least recent item in the page.
    ///
    /// For paginated results that are sorted in ascending chronological order (i.e., oldest to newest), this identifer can be used to retrieve the previous page of items, or—when sorted in descending chronological order (i.e., newest to oldest)—the next page of items.
    var earliest: CursorType? { get }
}

/// A collection that provides paginated results from a [Spotify Web API](https://developer.spotify.com/web-api/) request.
///
/// Paging collections are either *offset-based* or *cursor-based* depending on the [type of paging object](https://developer.spotify.com/web-api/object-model/#paging-object) returned by the API. The `PagingCollection` protocol serves as a base for common collection requirements.
///
/// Paging collections inherit from the `RandomAccessCollection` protocol, adopting all the functionality and efficiency of a bidirectional, random-access collection such as `Array`. In addition to the paging and API-specific requirements, types that conform to this protocol must also implement the requirements of the [Collection](apple-reference-documentation://hsvGnEkSD0) and [BidirectionalCollection](apple-reference-documentation://hswH9Lot32) protocols—and in order to meet the complexity guarantees of a random-access collection, either the index must conform to the [Strideable](apple-reference-documentation://hs7JNqlCdc) protocol, or the `index(_:offsetBy:)` and `distance(from:to:)` methods must be implemented with O(1) efficiency.
public protocol PagingCollection: RandomAccessCollection {
    
    /// The maximum number of items returned in the page, as set in the request or by default.
    var limit: Int { get }
    
    /// The total number of items available to return.
    ///
    /// Whereas the `count` property provides the number of items in the current page of results, `total` provides the total number of items generated by the API request. Note that not all requests return this value (for example, when fetching a list of recently played tracks).
    var total: Int? { get }
    
    /// A link to the Web API endpoint returning the full result of the request.
    var url: URL { get }
    
    /// The URL to the next page of items, or `nil` if no next page exists.
    var nextURL: URL? { get }
    
    /// The URL to the previous page of items, or `nil` if no previous page exists.
    var previousURL: URL? { get }
}

/// A collection that supports offset-based pagination.
///
/// Offset-based paging collections use an `offset` index to paginate items in a larger list of results. Offset-based pagination is the default mechanism for returning paginated results from the [Spotify Web API](https://developer.spotify.com/web-api/).
public protocol OffsetPagingCollection: PagingCollection {
    
    /// The index offset of the items returned in the page, as set in the request or by default.
    var offset: Index { get }
}

/// A collection that supports cursor-based pagination.
///
/// The `CursorPagingCollection` protocol is tightly linked with the `CursorProtocol` and `CursorPageable` protocols. As opposed to offset-based paging collections, cursor-based paging collections depend on a set of "cursors" to identify the first and last items in a given page, providing reference points from which to page through a larger list of results, typically sorted in chronological order. The type of cursor used to identify the items depends on the type of items returned in the page. Therefore, types that conform to this protocol must also conform its elements to `CursorPageable` and provide an associated type that conforms to the `CursorProtocol`, where its cursor type matches that of the collection's `Element`.
public protocol CursorPagingCollection: PagingCollection where Element: CursorPageable {
    
    /// A type that contains a set of cursors used to identify items in the collection.
    ///
    /// The associated cursor type must match that of the collection's `Element`.
    associatedtype Cursors: CursorProtocol where Cursors.CursorType == Element.CursorType
    
    /// The cursors used to identify the first and last items in the page.
    var cursors: Cursors { get }
}

// MARK: - Custom JSON Decoding

extension PagingCollection where Self: JSONDecodable {
    
    // MARK: Decoding JSON Paging Objects
    
    /// Creates a SpotifyKit type from the specified JSON data.
    ///
    /// - Parameter jsonData: The data containing the JSON-encoded [Spotify object](https://developer.spotify.com/web-api/object-model/).
    public init(from jsonData: Data) throws {
        
        let decoder = JSONDecoder()
        // Since some cursor-based paging responses use a different timestamp format than the rest of the Web API,
        // we have to use a custom decoding strategy here:
        decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
            
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            //let keys = decoder.codingPath.map { $0.stringValue }
            //if keys.contains("cursors") { ... }
            let key = decoder.codingPath.last
            
            // If we encountered one of the cursor coding keys while attempting to decode a date,
            if key?.stringValue == CursorKeys.latest.stringValue || key?.stringValue == CursorKeys.earliest.stringValue {
                // Then we know we're decoding a Unix Millisecond Timestamp date; decode and return:
                guard let timestamp = TimeInterval(dateString) else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "cannot decode Unix Timestamp Date from invalid string value \(dateString).")
                }
                return Date(timeIntervalSince1970: timestamp / 1000)
            } else {
                // Otherwise, decode and return as a ISO 8601 formatted date as usual:
                let formatter = ISO8601DateFormatter()
                guard let date = formatter.date(from: dateString) else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "cannot decode ISO 8601 Date from invalid string value \(dateString).")
                }
                return date
            }
        }
        
        // First try decoding a paged collection object as normal:
        do { self = try decoder.decode(Self.self, from: jsonData) }
            
        // If we're not finding the keys we're expecting,
        catch let DecodingError.keyNotFound(key, context) {
            // if the key we're missing isn't in the top level, then this error was thrown from decoding a sub-element; pass it along:
            if context.codingPath.count > 1 { throw DecodingError.keyNotFound(key, context) }
            // otherwise, try decoding as a paged collection wrapped in a single key-value pair dictionary,
            guard let collection = try decoder.decode([String: Self].self, from: jsonData).first?.value else {
                // throwing an error if the dictionary object is empty:
                throw DecodingError.dataCorruptedError(atCodingPath: context.codingPath, debugDescription: "JSON object is empty.")
            }
            
            self = collection
        }
            
        // Otherwise, throw any other errors encountered:
        catch { throw error }
    }
}

// MARK: - Collection Types

/// A generic collection that provides offset-based paginated results from a [Spotify Web API](https://developer.spotify.com/web-api/) request.
///
/// - SeeAlso: The Web API [Paging](https://developer.spotify.com/web-api/object-model/#paging-object) object.
public struct Page<Element: Decodable>: OffsetPagingCollection, JSONDecodable {
    
    /// The array of items.
    private let items: [Element]
    
    // MARK: Collection Conformance
    
    public var startIndex: Int {
        return items.startIndex
    }
    
    public var endIndex: Int {
        return items.endIndex
    }
    
    public subscript(position: Int) -> Element {
        return items[position]
    }
    
    public func index(after i: Int) -> Int {
        return items.index(after: i)
    }
    
    // MARK: Bidirectional Collection Conformance
    
    public func index(before i: Int) -> Int {
        return items.index(before: i)
    }
    
    // MARK: Paging Collection Conformance
    
    public let limit: Int
    public let total: Int?
    public let url: URL
    public let nextURL: URL?
    public let previousURL: URL?
    
    // MARK: Offset Paging Collection Conformance
    
    public let offset: Int

    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case items
        case limit
        case nextURL = "next"
        case offset
        case previousURL = "previous"
        //case cursors
        case total
    }
}

/// A generic collection that provides cursor-based paginated results from a [Spotify Web API](https://developer.spotify.com/web-api/) request.
///
/// - SeeAlso: The Web API [Cursor-Based Paging](https://developer.spotify.com/web-api/object-model/#cursor-based-paging-object) object.
public struct CursorPage<Element: CursorPageable & Decodable>: CursorPagingCollection, JSONDecodable {
    
    /// The array of items.
    private let items: [Element]
    
    // MARK: Collection Conformance
    
    public var startIndex: Int {
        return items.startIndex
    }
    
    public var endIndex: Int {
        return items.endIndex
    }
    
    public subscript(position: Int) -> Element {
        return items[position]
    }
    
    public func index(after i: Int) -> Int {
        return items.index(after: i)
    }
    
    // MARK: Bidirectional Collection Conformance
    
    public func index(before i: Int) -> Int {
        return items.index(before: i)
    }
    
    // MARK: Paging Collection Conformance
    
    public let limit: Int
    public let total: Int?
    public let url: URL
    public let nextURL: URL?
    public let previousURL: URL?
    
    // MARK: Cursor Paging Collection Conformance
    
//    // Nesting struct with an associated type that depends on parent generic struct causes runtime error in Swift 4.0.2 and earlier ("cyclic metadata dependency detected"). See SR-5086 and similar issues. Resolved using Swift 4.1 snapshot toolchain (2017-11-06).
//    /// A structure containing a set of cursors used to identify items in a cursor-based paging collection.
//    ///
//    /// Cursor-based paging collections depend on a set of "cursors" to identify the first and last items in a given page, providing reference points from which to page through a larger list of results, typically sorted in chronological order.
//    public struct Cursors: CursorProtocol, Decodable {
//
//        //public typealias CursorType = Element.CursorType
//        private typealias CodingKeys = CursorKeys // moved to fileprivate top-level scope for custom date decoding fix.
//
//        public var latest: Element.CursorType?
//        public var earliest: Element.CursorType?
//    }
    
    public let cursors: Cursors<Element.CursorType> // FIXME: Change to non-generic type once Swift 4.1 is implemented.
    
    private enum CodingKeys: String, CodingKey {
        case url = "href"
        case items
        case limit
        case nextURL = "next"
        //case offset
        case previousURL = "previous"
        case cursors
        case total
    }
}

fileprivate enum CursorKeys: String, CodingKey {
    case latest = "after" // newest // latest // mostRecent // next // last
    case earliest = "before" // oldest // earliest // leastRecent // previous // first
}

/// A structure containing a set of cursors used to identify items in a cursor-based paging collection.
///
/// Cursor-based paging collections depend on a set of "cursors" to identify the first and last items in a given page, providing reference points from which to page through a larger list of results, typically sorted in chronological order.
public struct Cursors<CursorType: Decodable>: CursorProtocol, Decodable { // FIXME: Move inside 'Page' once Swift 4.1 is implemented.
    
    //public typealias CursorType = CursorPage.Element.CursorType
    private typealias CodingKeys = CursorKeys // moved to fileprivate top-level scope for custom date decoding fix.
    
    public var latest: CursorType?
    public var earliest: CursorType?
}

//public struct AnyCursor<CursorType: Decodable>: CursorProtocol, Decodable {
//
//    private let _latest: CursorType?
//    private let _earliest: CursorType?
//
//    public init<C: CursorProtocol>(_  base: C) where C.CursorType == CursorType {
//        self._latest = base.latest
//        self._earliest = base.earliest
//    }
//
//    public var latest: CursorType? { return _latest }
//    public var earliest: CursorType? { return _earliest }
//
//    private enum CodingKeys: String, CodingKey {
//        case _latest = "after"
//        case _earliest = "before"
//    }
//}

//extension Page {
//    public init(url: URL, limit: Int, offset: Int? = nil) {
//        self.items = [] // var?
//        self.limit = limit
//        self.offset = offset
//        self.url = url
//    }
//}
