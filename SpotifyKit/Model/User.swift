//
//  User.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
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

/// An enum representing the expected `type` value for a user object.
fileprivate enum ResourceType: String, Codable { case user }

// MARK: - User Protocol

public protocol User {
    
    /// The name displayed on the user's profile. `nil` if not available.
    var displayName: String? { get }
    
    /// Known external URLs for this user. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    var externalURLs: [String: URL] { get }
    
    /// Information about the followers of this user.
    /// - Note: Users that are part of a Playlist or Playlist Track instance don't return this property.
    var followers: SKFollowers? { get }
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the user.
    var id: String { get }
    
    /// The user's profile image. If the user does not have a profile image set, this property will contain an empty array.
    /// - Note: Users that are part of a Playlist instance don't return this property.
    var images: [SKImage]? { get }
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for this user.
    var uri: String { get }
    
    /// A link to the Web API endpoint for this user.
    var url: URL { get }
}

// MARK: - User Type

public struct SKUser: User, JSONDecodable {
    
    /// The resource object type: `"user"`.
    private let type: ResourceType
    
    public let displayName: String?
    public let externalURLs: [String: URL]
    public let followers: SKFollowers?
    public let id: String
    public let images: [SKImage]?
    public let uri: String
    public let url: URL
    
    // MARK: Keys

    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalURLs = "external_urls"
        case followers
        case url = "href"
        case id
        case images
        case type
        case uri
    }
}

// MARK: - Current Authenticated User Type

public struct SKCurrentUser: User, JSONDecodable { // SKAuthenticatedUser
        
    /// - SeeAlso: https:/spotify.github.io/ios-sdk/Constants/SPTProduct.html
    public enum ProductType: String, Codable {
        case free
        case open // TODO: Test for this case.
        case premium
        case unlimited
        case unknown // TODO: Test for this case.
    }
    
    /// The resource object type: `"user"`.
    private let type: ResourceType
    
    // MARK: Public Properties
    
    public let displayName: String?
    public let externalURLs: [String: URL]
    public let followers: SKFollowers?
    public let id: String
    public let images: [SKImage]?
    public let uri: String
    public let url: URL
    
    // MARK: Private Properties
    
    /// The user's date-of-birth.
    /// - Note: This field is only available when the current user has granted access to the `user-read-birthdate` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let birthdate: Date?
    
    /// The country of the user, as set in the user's account profile. This value returns an [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    /// - Note: This field is only available when the current user has granted access to the `user-read-private` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let country: String?
    
    /// The user's email address, as entered by the user when creating their account.
    /// - Important: This email address is unverified; there is no proof that it actually belongs to the user.
    /// - Note: This field is only available when the current user has granted access to the `user-read-email` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let email: String?
    
    /// The user's Spotify subscription level: "premium", "free", etc. (The subscription level "open" can be considered the same as "free".)
    /// - Note: This field is only available when the current user has granted access to the `user-read-private` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let product: ProductType?
    
    // MARK: Keys

    private enum CodingKeys: String, CodingKey {
        case birthdate
        case country
        case displayName = "display_name"
        case email
        case externalURLs = "external_urls"
        case followers
        case url = "href"
        case id
        case images
        case product
        case type
        case uri
    }
    
    // MARK: Custom JSON Decoding
    
    public init(from jsonData: Data) throws {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        self = try decoder.decode(SKCurrentUser.self, from: jsonData)
    }
}
