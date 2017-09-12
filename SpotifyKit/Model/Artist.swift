//
//  Artist.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKArtist: JSONDecodable {
    
    // MARK: - Embedded Types
    
    /// An enum representing the expected `type` value for an artist object.
    private enum ObjectType: String, Codable { case artist }
    
    // MARK: - Object Properties (Simplified)
    
    /// Known external URLs for this artist. See ["external URL object"](https://developer.spotify.com/web-api/object-model/#external-url-object) for more details.
    public let externalURLs: [String: URL]
    
    /// A link to the Web API endpoint providing full details of the artist.
    public let url: URL
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artist.
    public let id: String
    
    /// The name of the artist.
    public let name: String
    
    /// The [Spotify URI](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    public let uri: String
    
    /// The object type: `"artist"`.
    private let type: ObjectType
    
    // MARK: - Object Properties (Full)
    
    /// Information about the followers of the artist.
    public let followers: SKFollowers?
    
    /// A list of the genres the artist is associated with. For example: `"Prog Rock"`, `"Post-Grunge"`. (If not yet classified, the array is empty.)
    public let genres: [String]?
    
    /// Images of the artist in various sizes, widest first.
    public let images: [SKImage]?
    
    /// The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks.
    public let popularity: Int?
    
    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case followers
        case genres
        case url = "href"
        case id
        case images
        case name
        case popularity
        case type
        case uri
    }
}

// MARK: - Expandable Conformance

extension SKArtist: Expandable {
    
    public var isSimplified: Bool {
        return
            followers == nil &&
            genres == nil &&
            images == nil &&
            popularity == nil
    }
}

// MARK: - Requests

extension SKArtist {
    
    // MARK: Get an Artist
    
    /// Creates and returns the request used to get an artist.
    ///
    /// - Parameter id: The Spotify ID for the artist, used in the endpoint path.
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal static func makeArtistRequest(id: String) -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.artist(id: id))!
    }
    
    /// Get Spotify catalog information for a single artist identified by their unique Spotify ID.
    ///
    /// - Important: This method uses the default `SPTAuth` instance's session object to authenticate the underlying API request. Ensure this session contains a valid access token before calling this method, otherwise this request will result in a `401` "unauthorized" error.
    ///
    /// - Parameters:
    ///   - id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artist.
    ///   - handler: The callback handler for the underlying request. The parameters for this handler are:
    ///     - `artist`: The requested full artist object, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getArtist(withID id: String, handler: @escaping (SKArtist?, Error?) -> Void) {
        makeArtistRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get Several Artists
    
    /// Creates and returns the request used to get several artists.
    ///
    /// - Parameter ids: The Spotify IDs for the artists, used in the URL query.
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal static func makeArtistsRequest(ids: [String]) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = ids
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.artists, parameters: parameters)!
    }
    
    /// Get Spotify catalog information for several artists based on their Spotify IDs.
    ///
    /// - Important: This method uses the default `SPTAuth` instance's session object to authenticate the underlying API request. Ensure this session contains a valid access token before calling this method, otherwise this request will result in a `401` "unauthorized" error.
    ///
    /// - Parameters:
    ///   - ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artists. Maximum: 50 IDs.
    ///   - handler: The callback handler for the underlying request. The parameters for this handler are:
    ///     - `albums`: The list of requested full artist objects. If a particular artist cannot be found for a given ID, the resulting array will contain a `nil` value at the corresponding index.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getArtists(withIDs ids: [String], handler: @escaping ([SKArtist?]?, Error?) -> Void) {
        makeArtistsRequest(ids: ids).perform(handler: handler)
    }
    
    // MARK: Get an Artist's Albums
    
    /// Creates and returns the request used to get the current artist's albums.
    ///
    /// - Parameters:
    ///   - types: The album types used to specify the "`album_type`" query parameter.
    ///   - locale: The `Locale` object used to specify the "`market`" query parameter.
    ///   - page: The tuple value containing values for the "`limit`" and "`offset`" query parameters.
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal func makeAlbumsRequest(types: [SKAlbum.AlbumType]?, locale: Locale?, page: Page?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.albumType] = types
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.albumsForArtist(id: id), parameters: parameters)!
    }
    
    /// Get Spotify catalog information about the given artist’s albums.
    ///
    /// - Important: This method uses the default `SPTAuth` instance's session object to authenticate the underlying API request. Ensure this session contains a valid access token before calling this method, otherwise this request will result in a `401` "unauthorized" error.
    ///
    /// - Parameters:
    ///   - types: The types of albums by which to filter results. If no types are specified, all album types will be returned. See `SKAlbum.AlbumType` for possible values.
    ///   - locale: The locale-specific catalog from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called. **Note:** If set to `nil`, results will be returned for all markets and will likely contain duplicate results, one for each market in which the album is available.
    ///   - page: A tuple value containing the parameters for paginating the results, specifying the number of items and the index of the first item to be returned.
    ///   - handler: The callback handler for the underlying request. The parameters for this handler are:
    ///     - `albums`: A paginated collection of simplified albums, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAlbums(filteredBy types: [SKAlbum.AlbumType]? = nil, in locale: Locale? = Locale.current, page: Page? = nil, handler: @escaping (PagedCollection<SKAlbum>?, Error?) -> Void) {
        makeAlbumsRequest(types: types, locale: locale, page: page).perform(handler: handler)
    }
    
    // MARK: Get an Artist's Top Tracks
    
    /// Creates and returns the request used to get the given artist's top tracks.
    ///
    /// - Parameter locale: The `Locale` object used to specify the "`country`" query parameter.
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal func makeTopTracksRequest(in locale: Locale?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.topTracksForArtist(id: id), parameters: parameters)!
    }
    
    /// Get Spotify catalog information about the given artist’s top tracks.
    ///
    /// - Important: This method uses the default `SPTAuth` instance's session object to authenticate the underlying API request. Ensure this session contains a valid access token before calling this method, otherwise this request will result in a `401` "unauthorized" error.
    ///
    /// - Parameters:
    ///   - locale: *Required*. The locale-specific catalog from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called.
    ///   - handler: The callback handler for the underlying request. The parameters for this handler are:
    ///     - `tracks`: An array returned by the request of up to 10 top tracks, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getTopTracks(in locale: Locale? = Locale.current, handler: @escaping ([SKTrack]?, Error?) -> Void) {
        makeTopTracksRequest(in: locale).perform(handler: handler)
    }
    
    // MARK: Get an Artist's Related Artists
    
    /// Creates and returns the request used to get a list of artists related to the given artist.
    ///
    /// - Returns: The `SKRequest` object, for testing purposes.
    internal func makeRelatedArtistsRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.relatedArtistsForArtist(id: id))!
    }
    
    /// Get Spotify catalog information about artists similar to the given artist.
    ///
    /// Similarity is based on analysis of the Spotify community’s [listening history](http://news.spotify.com/se/2010/02/03/related-artists/).
    ///
    /// - Important: This method uses the default `SPTAuth` instance's session object to authenticate the underlying API request. Ensure this session contains a valid access token before calling this method, otherwise this request will result in a `401` "unauthorized" error.
    ///
    /// - Parameter handler: The callback handler for the underlying request. The parameters for this handler are:
    ///     - `artists`: An array returned by the request of up to 20 related artists, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getRelatedArtists(handler: @escaping ([SKArtist]?, Error?) -> Void) {
        makeRelatedArtistsRequest().perform(handler: handler)
    }
}
