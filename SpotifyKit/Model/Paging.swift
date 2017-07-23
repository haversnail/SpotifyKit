//
//  Paging.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct Paging<Object/*: Codable*/> { // TODO: Make JSON Codable.
        
    /// A link to the Web API endpoint returning the full result of the request.
    public let href: URL
    
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
        case href
        case items
        case limit
        case next
        case offset
        case previous
        //case count = "total"
    }
}

