//
//  User.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKUser: JSONDecodable {
    
    // MARK: - Embedded Types
    
    /// An enum representing the expected `type` value for a user object.
    private enum ObjectType: String, Codable { case user }
    
    /// - SeeAlso: https:/spotify.github.io/ios-sdk/Constants/SPTProduct.html
    public enum ProductType: String, Codable {
        case free
        case open // TODO: Test for this case.
        case premium
        case unlimited
        case unknown // TODO: Test for this case.
    }

    // MARK: - Object Properties (Public)
    
    /// The name displayed on the user's profile. `nil` if not available.
    public let displayName: String?
    
    /// Known external URLs for this user. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    public let externalURLs: [String: URL]

    /// Information about the followers of this user.
    /// - Note: User objects that are part of a Playlist or Playlist Track object don't return this property.
    public let followers: SKFollowers?
    
    /// A link to the Web API endpoint for this user.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the user.
    public let id: String
    
    /// The user's profile image. If the user does not have a profile image set, this property will contain an empty array.
    /// - Note: User objects that are part of a Playlist object don't return this property.
    public let images: [SKImage]?
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for this user.
    public let uri: String
    
    /// The object type: `"user"`.
    private let type: ObjectType
    
    // MARK: - Object Properties (Private)
    
    /// The user's date-of-birth.
    /// - Note: This field is only available when the current user has granted access to the `user-read-birthdate` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let birthdate: Date?
    
    /// The country of the user, as set in the user's account profile. This value returns an [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    /// - Note: This field is only available when the current user has granted access to the `user-read-private` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let country: String?  // String will only always hold two characters. TODO: Change to a more performant data type.
    
    /// The user's email address, as entered by the user when creating their account.
    /// - Important: This email address is unverified; there is no proof that it actually belongs to the user.
    /// - Note: This field is only available when the current user has granted access to the `user-read-email` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let email: String?
    
    /// The user's Spotify subscription level: "premium", "free", etc. (The subscription level "open" can be considered the same as "free".)
    /// - Note: This field is only available when the current user has granted access to the `user-read-private` scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    public let product: ProductType?
    
    // MARK: - Keys

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
    
    // MARK: - Custom JSON Decoding
    
    public init(from jsonData: Data) throws {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        self = try decoder.decode(SKUser.self, from: jsonData)
    }
}
