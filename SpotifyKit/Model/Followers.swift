//
//  Followers.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKFollowers: JSONDecodable { // TODO: Make JSON Codable.
    
    /// A link to the Web API endpoint providing full details of the followers; `nil` if not available. Please note that this will always be set to `nil`, as the Web API does not support it at the moment.
    public let href: URL?
    
    /// The total number of followers.
    public let count: Int

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case href
        case count = "total"
    }
}
