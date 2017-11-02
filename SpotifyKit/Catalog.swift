//
//  Catalog.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 9/17/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A structure used to make requests to the Spotify catalog for top-level items such as albums, artists, tracks, playlists, and others.
///
/// - Note: All request-performing methods (e.g., "`getAlbum`" or "`search`") use the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. If you want to customize the request by injecting your own custom URL/API session or by decoding the response yourself, you can do so using any of the accompanying factory methods (e.g., "`makeAlbumRequest`" or "`makeSearchRequest`") to create and return the `SKRequest` instance itself.
public struct SKCatalog {
    
    public static var local: SKCatalog { return SKCatalog(locale: Locale.current) } // var current // Locale.autoupdatingCurrent
    
    /// The locale representing the specific storefront/market from which to request catalog content.
    ///
    /// All requests that include a "`market`," "`country`," or "`locale`" parameter will refer to the region and language codes provided by this property. If set to `nil`, many requests will return results for all available markets.
    ///
    /// - Important: Some requests are required to specify a locale or country code, and will result in an error if no locale is set before performing the request. This requirement will be annotated by all applicable requests.
    public var locale: Locale? // var storefront // = Locale.current // = nil
    
    /// Creates a new, reusable catalog instance with the specified storefront.
    ///
    /// - Parameter locale: The storefront/market from which to request catalog content.
    public init(locale: Locale?/* = Locale.current*/) {
        self.locale = locale
    }
    
    // MARK: - Albums
    
    // MARK: Get an Album ✔︎
    
    /// Creates and returns the request used to get an album.
    ///
    /// - Parameter id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAlbumRequest(id: String) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.album(id: id), parameters: parameters)!
    }
    
    /// Gets Spotify catalog information for a single album.
    ///
    /// - Parameters:
    ///   - id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the album.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `album`: The requested full album object, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAlbum(withID id: String, handler: @escaping (SKAlbum?, Error?) -> Void) {
        makeAlbumRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get Several Albums ✔︎
    
    /// Creates and returns the request used to get several albums.
    ///
    /// - Parameter ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the albums. Maximum: 20 IDs.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAlbumsRequest(ids: [String]) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = ids
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.albums, parameters: parameters)!
    }
    
    /// Gets Spotify catalog information for multiple albums identified by their Spotify IDs.
    ///
    /// - Parameters:
    ///   - ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the albums. Maximum: 20 IDs.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `albums`: The requested list of full album objects. If a particular album cannot be found for a given ID, the resulting array will contain `nil` at the corresponding index.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAlbums(withIDs ids: [String], handler: @escaping ([SKAlbum?]?, Error?) -> Void) {
        makeAlbumsRequest(ids: ids).perform(handler: handler)
    }
    
    // MARK: - Artists
    
    // MARK: Get an Artist ✔︎
    
    /// Creates and returns the request used to get an artist.
    ///
    /// - Parameter id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artist.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeArtistRequest(id: String) -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.artist(id: id))!
    }
    
    /// Gets Spotify catalog information for a single artist identified by their unique Spotify ID.
    ///
    /// - Parameters:
    ///   - id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artist.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `artist`: The requested full artist object, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getArtist(withID id: String, handler: @escaping (SKArtist?, Error?) -> Void) {
        makeArtistRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get Several Artists ✔︎
    
    /// Creates and returns the request used to get several artists.
    ///
    /// - Parameter ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artists. Maximum: 50 IDs.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeArtistsRequest(ids: [String]) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = ids
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.artists, parameters: parameters)!
    }
    
    /// Gets Spotify catalog information for several artists based on their Spotify IDs.
    ///
    /// - Parameters:
    ///   - ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the artists. Maximum: 50 IDs.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `albums`: The requested list of full artist objects. If a particular artist cannot be found for a given ID, the resulting array will contain `nil` at the corresponding index.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getArtists(withIDs ids: [String], handler: @escaping ([SKArtist?]?, Error?) -> Void) {
        makeArtistsRequest(ids: ids).perform(handler: handler)
    }
    
    // MARK: - Browse
    
    // MARK: Get Featured Playlists ✔︎
    
    /// Creates and returns the request used to get a list of Spotify featured playlists.
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameters:
    ///   - date: A timestamp used to tailor results to a specific date and time of day. For example, if retrieving featured playlists for 3:00 PM, 23 October 2014, the catalog would return a list of playlists relevant to that time and day of the week, accompanied by a specific localized message (e.g., *"Get ready to rock your Thursday! #Rocktober"*). If `nil` is provided, the response defaults to the current UTC time.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFeaturedPlaylistsRequest(date: Date?, page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.locale] = locale?.identifier
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        parameters[Constants.QueryParameters.timestamp] = date != nil ? ISO8601DateFormatter().string(from: date!) : nil
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.featuredPlaylists, parameters: parameters)!
    }
    
    /// Gets a list of Spotify featured playlists (for example, those shown on a Spotify player's "Browse" tab).
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameters:
    ///   - date: A timestamp used to tailor results to a specific date and time of day. For example, if retrieving featured playlists for 3:00 PM, 23 October 2014, the catalog would return a list of playlists relevant to that time and day of the week, accompanied by a specific localized message (e.g., *"Get ready to rock your Thursday! #Rocktober"*). If `nil` is provided, the response defaults to the current UTC time. The default value is the current date and time, relative to the user's current time zone.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `featuredPlaylists`: An `SKFeaturedPlaylists` object, which contains a paginated collection of playlists accompanied by a localized message string.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getFeaturedPlaylists(for date: Date? = Date(), page: Pagination? = nil, handler: @escaping (SKFeaturedPlaylists?, Error?) -> Void) {
        makeFeaturedPlaylistsRequest(date: date, page: page).perform(handler: handler)
    }
    
    // MARK: Get New Releases ✔︎
    
    /// Creates and returns the request used to get a list of new album releases.
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeNewReleasesRequest(page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.newReleases, parameters: parameters)!
    }
    
    /// Gets a list of new album releases featured by Spotify (for example, those shown on a Spotify player's "Browse" tab).
    ///
    /// - Parameters:
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `albums`: A paginated collection of newly released albums.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getNewReleases(page: Pagination? = nil, handler: @escaping (Page<SKAlbum>?, Error?) -> Void) {
        makeNewReleasesRequest(page: page).perform(handler: handler)
    }
    
    // MARK: Get a List of Categories ✔︎
    
    /// Creates and returns the request used to get a list of categories.
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeCategoriesRequest(page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        parameters[Constants.QueryParameters.locale] = locale?.identifier
        parameters[Constants.QueryParameters.offset] = page?.offset
        parameters[Constants.QueryParameters.limit] = page?.limit
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.categories, parameters: parameters)!
    }
    
    /// Gets a list of categories used to tag items in Spotify (for example, those shown on a Spotify player's "Browse" tab).
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameters:
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `categories`: A paginated collection of available Spotify categories.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getCategories(page: Pagination? = nil, handler: @escaping (Page<SKCategory>?, Error?) -> Void) {
        makeCategoriesRequest(page: page).perform(handler: handler)
    }
    
    // MARK: Get a Category ✔︎
    
    /// Creates and returns the request used to get a single category.
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameter id: The [Spotify category ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the category.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeCategoryRequest(id: String) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        parameters[Constants.QueryParameters.locale] = locale?.identifier
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.category(id: id), parameters: parameters)!
    }
    
    /// Gets a single category used to tag items in Spotify (for example, those shown on a Spotify player's "Browse" tab).
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameters:
    ///   - id: id: The [Spotify category ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the category.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `category`: The requested category, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getCategory(withID id: String, handler: @escaping (SKCategory?, Error?) -> Void) {
        makeCategoryRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get Available Genre Seeds ✔︎
    
    /// Creates and returns the request used to get available genre seeds for recommendations.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAvailableGenresRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.genres)!
    }
    
    /// Gets a list of available genre seeds used for recommendations.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `genres`: The list of available genres.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAvailableGenres(handler: @escaping ([String]?, Error?) -> Void) {
        makeAvailableGenresRequest().perform(handler: handler)
    }
    
    // MARK: Get Recommendations ✔︎
    
    /// Creates and returns the request used to get recommendations based on seed genres, artists, and tracks.
    ///
    /// Recommendations are generated based on the available information for a given seed entity and matched against similar artists and tracks. If there is sufficient information about the provided seeds, a list of tracks will be returned together with pool size details.
    ///
    /// - Note: For each request, you may provide up to five seed items comprised of any combination of genres, artists, and tracks. If more than five seed items are provided, the request will result in an error.
    ///
    /// In cases where seed artists and tracks are very new or obscure, the request may not have enough data to generate a list of tracks.
    ///
    /// - Parameters:
    ///   - genres: A list of seed genres. For possible values, use the "`getAvailableGenres`" method to retrieve a list of genres available as seeds for this request.
    ///   - artists: A list of seed artists.
    ///   - tracks: A list of seed tracks.
    ///   - attributes: A list of tunable track attributes by which to filter results. Each attribute allows you to specify a minimum value, maximum value, and target value.
    ///   - limit: The target size of the results. **Note**: For seeds with unusually small pools or when highly restrictive filtering is applied, it may be impossible to generate the requested number of recommended tracks. In such cases, debugging information will be made available in the response.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeRecommendationsRequest(genres: [String],
                                           artists: [SKArtist],
                                           tracks: [SKTrack], // TODO: Change to protocol constraints.
                                           attributes: Set<SKTrackAttribute>,
                                           limit: Int?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        parameters[Constants.QueryParameters.limit] = limit
        
        parameters[Constants.QueryParameters.seedArtists] = artists.isEmpty ? nil : artists.map { $0.id }
        parameters[Constants.QueryParameters.seedTracks] = tracks.isEmpty ? nil : tracks.map { $0.id }
        parameters[Constants.QueryParameters.seedGenres] = genres.isEmpty ? nil : genres
        
        for attribute in attributes {
            parameters[Constants.QueryParameters.minPrefix + attribute.key] = attribute.values.min
            parameters[Constants.QueryParameters.maxPrefix + attribute.key] = attribute.values.max
            parameters[Constants.QueryParameters.targetPrefix + attribute.key] = attribute.values.target
        }
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.recommendations, parameters: parameters)!
    }
    
    /// Gets recommendations based on seed genres, artists, and tracks.
    ///
    /// Recommendations are generated based on the available information for a given seed entity and matched against similar artists and tracks. If there is sufficient information about the provided seeds, a list of tracks will be returned together with pool size details.
    ///
    /// - Note: For each request, you may provide up to five seed items comprised of any combination of genres, artists, and tracks. If more than five seed items are provided, the request will result in an error.
    ///
    /// In cases where seed artists and tracks are very new or obscure, the request may not have enough data to generate a list of tracks.
    ///
    /// - Parameters:
    ///   - genres: A list of seed genres. For possible values, use the "`getAvailableGenres`" method to retrieve a list of genres available as seeds for this request.
    ///   - artists: A list of seed artists.
    ///   - tracks: A list of seed tracks.
    ///   - attributes: A list of tunable track attributes by which to filter results. Each attribute allows you to specify a minimum value, maximum value, and target value.
    ///   - limit: The target size of the results. **Note**: For seeds with unusually small pools or when highly restrictive filtering is applied, it may be impossible to generate the requested number of recommended tracks. In such cases, debugging information will be made available in the response.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `recommendations`: An `SKRecommendations` object, which contains an array of tracks accompanied by the seeds from which the tracks are returned.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getRecommendationsBasedOn(genres: [String],
                                          artists: [SKArtist],
                                          tracks: [SKTrack],
                                          filteredBy attributes: Set<SKTrackAttribute> = [],
                                          limit: Int? = nil,
                                          handler: @escaping (SKRecommendations?, Error?) -> Void) {
        
        makeRecommendationsRequest(genres: genres, artists: artists, tracks: tracks, attributes: attributes, limit: limit).perform(handler: handler)
    }
    //public func getRecommendations<T: Seedable>(basedOn seeds: [T], filteredBy attributes: Set<SKTrackAttribute> = [], limit: Int? = nil, handler: @escaping (SKRecommendations?, Error?) -> Void)
    
    // MARK: - Search
    
    /// Creates and returns the request used to search the Spotify catalog.
    ///
    /// - Parameters:
    ///   - types: An array identifying the types of objects requested by the search. Possible values are `.album`, `.artist`, `.track`, and `.playlist`. The static constant `.all` can also be used to represent an array containing all search result types.
    ///   - keywords: The search term against which to match results. **Note**: Keyword matching is *not* case-sensitive.
    ///   - alternate: An alternate search term used to broaden the search. If no alternate keywords are needed, set this parameter to `nil`.
    ///   - unwanted: Unwanted keywords to exclude from the search. If no unwanted keywords are needed, set this parameter to `nil`.
    ///   - inOrder: When `false`, keywords will be matched in any order; when `true`, the search will maintain exact keyword order.
    ///   - filters: A list of field filters by which to narrow the search. For available filters, see `SKSearchFieldFilter`. If no filters are needed, set this parameter to an empty array.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeSearchRequest(types: Set<SKSearchResultType>,
                                  keywords: String,
                                  alternate: String?,
                                  unwanted: String?,
                                  inOrder: Bool,
                                  filters: Set<SKSearchFieldFilter>,
                                  page: Pagination?) -> SKRequest {
        
        // Begin with the primary keywords, adding quotes if 'inOrder' is true:
        var query: String = inOrder ? "\"" + keywords.lowercased() + "\"" : keywords.lowercased()
        
        // Add any alternate keywords:
        if let alternate = alternate, !alternate.isEmpty {
            query.append(" OR " + alternate.lowercased())
        }
        
        // Add any unwanted keywords:
        if let unwanted = unwanted, !unwanted.isEmpty {
            query.append(" NOT " + unwanted.lowercased())
        }
        
        // If there are any filters,
        if !filters.isEmpty {
            
            // Create a URL encoder instance with which to encode the filter values:
            let encoder = URLEncoder()
            encoder.spaceSeparator = "+"
            encoder.rangeSeparator = "-"
            encoder.dateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy"
                return formatter
            }()
            
            for filter in filters {
                
                // If the filter isn't intended for the given search result type(s), then skip it and continue to the next one:
                switch filter {
                    case .genre:     guard types.contains(.artists) || types.contains(.tracks) else { continue }
                    case .tag, .upc: guard types.contains(.albums) else { continue }
                    case .isrc:      guard types.contains(.tracks) else { continue }
                    default: break
                }
                
                let value = filter.value.string(using: encoder) // Encode the filter's associated value;
                if !value.isEmpty {                             // as long as the string value isn't empty,
                    query.append(" \(filter.key):\(value)")     // append it to the query.
                }
            }
        }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.query] = query
        parameters[Constants.QueryParameters.type] = types.isEmpty ? nil : types
        parameters[Constants.QueryParameters.market] = locale?.regionCode // TODO: Find a way to include the "from_token" value.
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.search, parameters: parameters)!
    }
    
    /// Gets Spotify catalog information about artists, albums, tracks or playlists that match a keyword string.
    ///
    /// - Parameters:
    ///   - types: An array identifying the types of objects requested by the search. Possible values are `.album`, `.artist`, `.track`, and `.playlist`. The static constant `.all` can also be used to represent an array containing all search result types.
    ///   - keywords: The search term against which to match results. **Note**: Keyword matching is *not* case-sensitive.
    ///   - alternate: An alternate search term used to broaden the search. The default value is an empty string.
    ///   - unwanted: Unwanted keywords to exclude from the search. The default value is an empty string.
    ///   - inOrder: When `false`, keywords will be matched in any order; when `true`, the search will maintain exact keyword order. The default value is `false`.
    ///   - filters: A list of field filters by which to narrow the search. For available filters, see `SKSearchFieldFilter`. The default value is an empty array.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for this request. The parameters for this handler are:
    ///       - `results`: An `SKSearchResults` object containing paged results for any albums, artists, tracks, or playlists returned by the search.
    ///       - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func search(for types: Set<SKSearchResultType>,
                       matching keywords: String,
                       or alternate: String? = nil,
                       excluding unwanted: String? = nil,
                       inOrder: Bool = false,
                       filteredBy filters: Set<SKSearchFieldFilter> = [],
                       page: Pagination? = nil,
                       handler: @escaping (SKSearchResults?, Error?) -> Void) {
        
        makeSearchRequest(types: types,
                          keywords: keywords,
                          alternate: alternate,
                          unwanted: unwanted,
                          inOrder: inOrder,
                          filters: filters,
                          page: page)
            .perform(handler: handler)
    }
    
    // MARK: - Tracks
    
    // MARK: Get a Track
    
    /// Creates and returns the request used to get a track.
    ///
    /// - Parameter id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeTrackRequest(id: String) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.track(id: id), parameters: parameters)!
    }
    
    /// Gets Spotify catalog information for a single track identified by its unique Spotify ID.
    ///
    /// - Parameters:
    ///   - id: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the track.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `track`: The requested full track object, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getTrack(withID id: String, handler: @escaping (SKTrack?, Error?) -> Void) {
        makeTrackRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get Several Tracks
    
    /// Creates and returns the request used to get several tracks.
    ///
    /// - Parameter ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the tracks. Maximum: 50 IDs.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeTracksRequest(ids: [String]) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = ids
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.tracks, parameters: parameters)!
    }
    
    /// Gets Spotify catalog information for multiple tracks based on their Spotify IDs.
    ///
    /// - Parameters:
    ///   - ids: A list of the [Spotify IDs](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the tracks. Maximum: 50 IDs.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `tracks`: The requested list of full track objects. If a particular track cannot be found for a given ID, the resulting array will contain `nil` at the corresponding index.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getTracks(withIDs ids: [String], handler: @escaping ([SKTrack?]?, Error?) -> Void) {
        makeTracksRequest(ids: ids).perform(handler: handler)
    }
    
    // TODO: - Follow
    
    // TODO: - Users
    
    // TODO: - User Library
    
    // TODO: - Player
}

// MARK: - Artist Requests

extension SKArtist {
    
    // MARK: Get an Artist's Albums ✔︎
    
    /// Creates and returns the request used to get the current artist's albums.
    ///
    /// - Parameters:
    ///   - types: The types of albums by which to filter results. If no types are specified (i.e., parameter is set to an empty array), all album types will be returned. See `SKAlbumType` for possible values.
    ///   - locale: The locale-specific storefront/market from which to request. **Note:** If set to `nil`, results will be returned for all markets and will likely contain duplicate results, one for each market in which the album is available.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAlbumsRequest(types: Set<SKAlbumType>, locale: Locale?, page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.albumType] = types.isEmpty ? nil : types
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.albumsForArtist(id: id), parameters: parameters)!
    }
    
    /// Gets Spotify catalog information about the current artist’s albums.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameters:
    ///   - types: The types of albums by which to filter results. If no types are specified, all album types will be returned. See `SKAlbumType` for possible values. The default value is an empty array.
    ///   - locale: The locale-specific storefront/market from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called. **Note:** If set to `nil`, results will be returned for all markets and will likely contain duplicate results, one for each market in which the album is available.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `albums`: A paginated collection of simplified albums, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAlbums(filteredBy types: Set<SKAlbumType> = [], for locale: Locale? = SKCatalog.local.locale, page: Pagination? = nil, handler: @escaping (Page<SKAlbum>?, Error?) -> Void) {
        makeAlbumsRequest(types: types, locale: locale, page: page).perform(handler: handler)
    }
    
    // MARK: Get an Artist's Top Tracks ✔︎
    
    /// Creates and returns the request used to get the current artist's top tracks.
    ///
    /// - Parameter locale: The locale-specific storefront/market from which to request. **Note:** The locale must contain a valid region code.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeTopTracksRequest(locale: Locale) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale.regionCode
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.topTracksForArtist(id: id), parameters: parameters)!
    }
    
    /// Gets Spotify catalog information about the current artist’s top tracks.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific catalog from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called. **Note:** The locale must contain a valid region code.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `tracks`: An array returned by the request of up to 10 top tracks, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getTopTracks(for locale: Locale = SKCatalog.local.locale!, handler: @escaping ([SKTrack]?, Error?) -> Void) {
        makeTopTracksRequest(locale: locale).perform(handler: handler)
    }
    
    // MARK: Get an Artist's Related Artists ✔︎
    
    /// Creates and returns the request used to get a list of artists similar to the current artist.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeRelatedArtistsRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.relatedArtistsForArtist(id: id))!
    }
    
    /// Gets Spotify catalog information about artists similar to the current artist.
    ///
    /// Similarity is based on analysis of the Spotify community’s [listening history](http://news.spotify.com/se/2010/02/03/related-artists/).
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `artists`: An array returned by the request of up to 20 related artists, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getRelatedArtists(handler: @escaping ([SKArtist]?, Error?) -> Void) {
        makeRelatedArtistsRequest().perform(handler: handler)
    }
}

// MARK: - Category Requests

extension SKCategory {
    
    // MARK: Get a Category's Playlists ✔︎
    
    /// Creates and returns the request used to get playlists for the current category.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific storefront/market from which to request.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makePlaylistsRequest(locale: Locale?, page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.country] = locale?.regionCode
        parameters[Constants.QueryParameters.offset] = page?.offset
        parameters[Constants.QueryParameters.limit] = page?.limit
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.playlistsForCategory(id: id), parameters: parameters)!
    }
    
    /// Gets a list of Spotify playlists tagged with the current category.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific storefront/market from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `playlists`: A paginated collection of simplified playlists, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getPlaylists(for locale: Locale? = SKCatalog.local.locale, page: Pagination? = nil, handler: @escaping (Page<SKPlaylist>?, Error?) -> Void) {
        makePlaylistsRequest(locale: locale, page: page).perform(handler: handler)
    }
    
}

// MARK: - Track Requests

extension SKTrack {
    
    // MARK: Get Audio Features ✔︎
    
    /// Creates and returns the request used to get audio features for the current track.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAudioFeaturesRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.audioFeaturesForTrack(id: id))!
    }
    
    /// Gets audio feature information for the current track.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `features`: The requested audio features object, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAudioFeatures(handler: @escaping (SKAudioFeatures?, Error?) -> Void) {
        makeAudioFeaturesRequest().perform(handler: handler)
    }
}

extension Collection where Element: Track {
    
    // MARK: Get Audio Features for Several Tracks ✔︎
    
    /// Creates and returns the request used to get audio features for the current collection of tracks.
    ///
    /// - Important: The maximum number of IDs the API can process for a single request to this endpoint is 100. If the current array contains more than 100 items, the request may result in an error.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAudioFeaturesRequest() -> SKRequest {
        if self.isEmpty { assertionFailure("collection of IDs must contain at least one value for the API request to be valid.") }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = self.isEmpty ? nil : map { $0.id }
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.audioFeatures, parameters: parameters)!
    }
    
    /// Gets audio feature information for the current collection of tracks.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Important: The maximum number of IDs the API can process for a single request to this endpoint is 100. If the current array contains more than 100 items, the request may result in an error.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `features`: An array of audio feature objects corresponding to the tracks in this array. If audio features for a particular track ID cannot be found, the resulting array will contain a `nil` value at the corresponding index.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAudioFeatures(handler: @escaping ([SKAudioFeatures?]?, Error?) -> Void) {
        makeAudioFeaturesRequest().perform(handler: handler)
    }
}

// MARK: - User Requests

extension SKUser {
    
    // MARK: Get a User's Profile ✔︎
    
    /// Creates and returns the request used to get a user.
    ///
    /// - Parameter id: The user's [Spotify user ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids).
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeUserRequest(id: String) -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.user(id: id))!
    }
    
    /// Gets public profile information about a Spotify user.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameters:
    ///   - id: The user's [Spotify user ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids).
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `user`: The requested user, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getUser(withID id: String, handler: @escaping (SKUser?, Error?) -> Void) {
        makeUserRequest(id: id).perform(handler: handler)
    }
    
    // MARK: Get a User's Playlists ✔︎
    
    /// Creates and returns the request used to get the user's playlists.
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makePlaylistsRequest(page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.playlistsForUser(id: id), parameters: parameters)!
    }
    
    /// Gets a list of the playlists owned or followed by the user.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Private playlists are only retrievable for the *current user* and requires the "`playlist-read-private`" scope to have been authorized by the user. Note that this scope alone will not return collaborative playlists, even though they are always private.
    ///
    /// See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `user`: The current authenticated user, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getPlaylists(page: Pagination? = nil, handler: @escaping (Page<SKPlaylist>?, Error?) -> Void) {
        makePlaylistsRequest(page: page).perform(handler: handler)
    }
}

extension SKCurrentUser {
    
    // MARK: Get the Current User's Profile ✔︎
    
    /// Creates and returns the request used to get the current authenticated user.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeCurrentUserRequest() -> SKRequest { // makeAuthenticatedUserRequest
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.me)!
    }
    
    /// Gets detailed profile information about the current authenticated user.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// To retrieve all user properties, the access token also must have been generated with certain scopes authorized. In particular:
    /// * Reading the user's email address requires the "`user-read-email`" scope.
    /// * Reading the user's country and product subscription level requires the "`user-read-private`" scope.
    /// * Reading the user's date of birth requires the "`user-read-birthdate`" scope.
    ///
    /// See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - id: The user's [Spotify user ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids).
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `user`: The current authenticated user, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func getCurrentUser(handler: @escaping (SKCurrentUser?, Error?) -> Void) { // getAuthenticatedUser
        makeCurrentUserRequest().perform(handler: handler)
    }
    
    // MARK: Get the Current User's Playlists ✔︎
    
    /// Creates and returns the request used to get the current authenticated user's playlists.
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makePlaylistsRequest(page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.myPlaylists, parameters: parameters)!
    }
    
    /// Gets a list of the playlists owned or followed by the current authenticated user.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Private playlists are only retrievable for the *current user* and requires the "`playlist-read-private`" scope to have been authorized by the user. Note that this scope alone will not return collaborative playlists, even though they are always private.
    ///
    /// See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `user`: The current authenticated user, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getPlaylists(page: Pagination? = nil, handler: @escaping (Page<SKPlaylist>?, Error?) -> Void) {
        makePlaylistsRequest(page: page).perform(handler: handler)
    }
}

// MARK: - Playlist Requests

extension SKPlaylist {
    
    // MARK: Create a Playlist ✔︎
    
    /// Creates and returns the request used to create a new playlist.
    ///
    /// - Parameters:
    ///   - userID: The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the current authenticated user. **Note**: the access token provided to this request must have been issued on behalf of this user, who must have authorized either the "`playlist-modify-public`" or "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///   - name: The name for the new playlist. This name does not need to be unique; a user may have several playlists with the same name.
    ///   - description: An optional description of the playlist.
    ///   - isPublic: `true` if the playlist will be public, `false` if private. **Note**: to create private playlists, the user must have authorized the "`playlist-modify-private`" scope.
    ///   - isCollaborative: `true` if the playlist will be collaborative, `false` otherwise. **Note**: to create collaborative playlists, the user must have authorized both "`playlist-modify-private`" and "`playlist-modify-public`" scopes.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public static func makeNewPlaylistRequest(userID: String, name: String, description: String?, isPublic: Bool, isCollaborative: Bool) -> SKRequest {
        
        let request = SKRequest(method: .POST, endpoint: Constants.Endpoints.playlistsForUser(id: userID))!
        
        typealias RequestBody = Constants.RequestBodies.PlaylistDetailsBody
        let data = try! RequestBody(name: name,
                                    description: description,
                                    isPublic: isPublic,
                                    isCollaborative: isCollaborative).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Creates a new, empty playlist for the current authenticated user.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to provide the user ID for, and the access token to authenticate, the underlying request. If this session does not contain a valid access token, the request will result in an error; if this session does not contain a valid username, then this method will do nothing.
    ///
    /// The access token must have been issued on behalf of the current user, who must have authorized either the "`playlist-modify-public`" or "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - name: The name for the new playlist. This name does not need to be unique; a user may have several playlists with the same name.
    ///   - description: An optional description of the playlist. The default value is `nil`.
    ///   - isPublic: `true` if the playlist should be public, `false` if private. The default value is `true`. **Note**: to create private playlists, the user must have authorized the "`playlist-modify-private`" scope.
    ///   - isCollaborative: `true` if the playlist should be collaborative, `false` otherwise. The default value is `false`. **Note**: to create collaborative playlists, the user must have authorized both "`playlist-modify-private`" and "`playlist-modify-public`" scopes.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `playlist`: The newly-created playlist object, if the request was successful.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public static func createPlaylist(named name: String, description: String? = nil, isPublic: Bool = true, isCollaborative: Bool = false, handler: @escaping (SKPlaylist?, Error?) -> Void) {
        
        guard let userID = SPTAuth.defaultInstance()?.session?.canonicalUsername else { // TODO: Remove dependency on iOS SDK classes in the future.
            assertionFailure("the 'SPTAuth' default instance session must contain a valid username."); return
        }
        
        makeNewPlaylistRequest(userID: userID, name: name, description: description, isPublic: isPublic, isCollaborative: isCollaborative).perform(handler: handler)
    }
    
    // MARK: Update a Playlist's Details ✔︎
    
    /// Creates and returns the request used to update a playlist's details.
    ///
    /// - Note: If all parameters have been set to `nil`, the returned request will not contain a request body.
    ///
    /// - Parameters:
    ///   - name: The new name for the playlist.
    ///   - description: A new description of the playlist.
    ///   - isPublic: If `true`, the playlist will be made public; if `false`, private.
    ///   - isCollaborative: If `true`, the playlist will become collaborative and other users will be able to modify the playlist in their Spotify client. **Note**: setting this parameter to `true` is only applicable to non-public playlists.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeUpdateDetailsRequest(name: String?, description: String?, isPublic: Bool?, isCollaborative: Bool?) -> SKRequest {
        
        let request = SKRequest(method: .PUT, endpoint: Constants.Endpoints.playlist(id: id, ownerID: owner.id))!
        
        if name == nil && description == nil && isPublic == nil && isCollaborative == nil { return request }
        
        typealias RequestBody = Constants.RequestBodies.PlaylistDetailsBody
        let data = try! RequestBody(name: name,
                                    description: description,
                                    isPublic: isPublic,
                                    isCollaborative: isCollaborative).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Changes a playlist's details, including its name, description, and access levels.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Changing the details for a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, changing the details for a private playlist requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// If all parameters have been set to nil, then this method will do nothing.
    ///
    /// - Parameters:
    ///   - name: The new name for the playlist. The default value is `nil`.
    ///   - description: A new description of the playlist. The default value is `nil`.
    ///   - isPublic: If `true`, the playlist will be made public; if `false`, private. The default value is `nil`.
    ///   - isCollaborative: If `true`, the playlist will become collaborative and other users will be able to modify the playlist in their Spotify client. The default value is `nil`. **Note**: setting this parameter to `true` is only applicable to non-public playlists.
    ///   - handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func update(name: String? = nil, description: String? = nil, isPublic: Bool? = nil, isCollaborative: Bool? = nil, handler: @escaping SKErrorHandler) {
        if name == nil && description == nil && isPublic == nil && isCollaborative == nil { return }
        
        makeUpdateDetailsRequest(name: name, description: description, isPublic: isPublic, isCollaborative: isCollaborative).perform(handler: handler)
    }
    
    // MARK: Upload a Custom Playlist Cover Image ✔︎
    
    /// Creates and returns the request used to upload a custom playlist cover image.
    ///
    /// - Parameter data: The image data to upload. The payload must contain Base-64 encoded JPEG image data. The maximum encoded payload size is 256 KB.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeUpdateImageRequest(data: Data) -> SKRequest { // makeUploadImageRequest(data: Data) // makeReplaceImageRequest(data: Data)
        
        let request = SKRequest(method: .PUT, endpoint: Constants.Endpoints.imageForPlaylist(id: id, ownerID: owner.id))!
        request.addMultipartData(data, type: .jpeg)
        return request
    }
    
    /// Uploads a custom playlist cover image, replacing the current image used to represent the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// The access token must have been issued on behalf of the user who owns the playlist, and must have the "`ugc-image-upload`" scope authorized. In addition, the token must also contain the "`playlist-modify-public`" and/or "`playlist-modify-private`" scopes, depending the access level of playlist. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - data: The image data to upload. The payload must contain Base-64 encoded JPEG image data. The maximum encoded payload size is 256 KB.
    ///   - handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func updateImage(with data: Data, handler: @escaping SKErrorHandler) { // uploadImage(_ data: ...) // replaceImage(with data: ...)
        
        // If the size exceeds the maximum file size, call the handler now and return a custom error message (API doesn't return an error for this):
        guard data.count <= Constants.maxImageSize else {
            let size = Float(data.count) / 1000
            
            let sizeText = size < 1000 ? String(format: "%.1f", size) + " KB" : String(format: "%.1f", size/1000) + " MB"
            
            let message = """
            The final Base-64 encoded JPEG image is too large (\(sizeText)).
            Consider reducing the image size or lowering the compression quality.
            """
            
            handler(SKError(status: .badRequest, message: message))
            return
        }

        makeUpdateImageRequest(data: data).perform(handler: handler)
//        makeUpdateImageRequest(data: data).perform { (_, status, error) in
//            if let error = error {
//                handler(error); return
//            }
//
//            guard status == .accepted else {
//                // TODO: Pass error to handler.
//                return
//            }
//        }
    }
    
    /// Uploads a custom playlist cover image, replacing the current image used to represent the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// The access token must have been issued on behalf of the user who owns the playlist, and must have the "`ugc-image-upload`" scope authorized. In addition, the token must also contain the "`playlist-modify-public`" and/or "`playlist-modify-private`" scopes, depending the access level of playlist. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - image: The image data to upload. The maximum encoded payload size is 256 KB. **Note**: if there is a problem generating Base-64 encoded JPEG image data from the given `UIImage`—for example, if the image has no data or if the underlying `CGImageRef` contains data in an unsupported bitmap format—then this method will do nothing and the provided callback handler will not be executed.
    ///   - quality: The compression quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality). The default value is 0.8.
    ///   - handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func updateImage(with image: UIImage, quality: Float = 0.8, handler: @escaping SKErrorHandler) { // replaceImage(with image: ...)
        
        guard let data = UIImageJPEGRepresentation(image, CGFloat(quality)) else {
            print("UIImage could not be converted to a JPEG representation."); return
        }
        
        //print("Image data size (before encoding):", Float(data.count) / 1000, "KB")
        //let base64Data = data.base64EncodedData()
        //print("Image data size (after encoding):", Float(base64Data.count) / 1000, "KB")
        
        updateImage(with: data.base64EncodedData(), handler: handler)
    }
    
    // MARK: Get a Playlist's Tracks ✔︎
    
    /// Creates and returns the request used to get a playlist's tracks.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific storefront/market from which to request.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeTracksRequest(locale: Locale?, page: Pagination?) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.market] = locale?.regionCode
        parameters[Constants.QueryParameters.limit] = page?.limit
        parameters[Constants.QueryParameters.offset] = page?.offset
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.tracksForPlaylist(id: id, ownerID: owner.id), parameters: parameters)!
    }
    
    /// Gets the full details for the tracks of a playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// Both public and private playlists belonging to any user are retrievable on provision of a valid access token.
    ///
    /// - Parameters:
    ///   - locale: The locale-specific storefront/market from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `tracks`: A paginated collection of full playlist track objects, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getTracks(for locale: Locale? = SKCatalog.local.locale, page: Pagination? = nil, handler: @escaping (Page<SKPlaylistTrack>?, Error?) -> Void) {
        makeTracksRequest(locale: locale, page: page).perform(handler: handler)
    }
    
    // MARK: Add Tracks to a Playlist ✔︎
    
    /// Creates and returns the request used to add tracks to the playlist.
    ///
    /// - Parameters:
    ///   - tracks: A list of tracks to add.
    ///   - position: The index at which to insert the tracks. If omitted or set to `nil`, the tracks will be appended to the playlist.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAddTracksRequest<T: Collection>(tracks: T, position: Int?) -> SKRequest where T.Element: Track {
        if tracks.isEmpty { assertionFailure("collection of tracks must contain at least one track for the API request to be valid.") }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.uris] = tracks.isEmpty ? nil : tracks.map { $0.uri }
        parameters[Constants.QueryParameters.position] = position
        return SKRequest(method: .POST, endpoint: Constants.Endpoints.tracksForPlaylist(id: id, ownerID: owner.id), parameters: parameters)!
    }
    
    /// Adds the given tracks to the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Adding tracks to a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, adding tracks to a private playlist (including collaborative playlists) requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - tracks: A list of tracks to add.
    ///   - position: The index at which to insert the tracks. If omitted or set to `nil`, the tracks will be appended to the playlist. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func add<T: Collection>(_ tracks: T, at position: Int? = nil, handler: @escaping (String?, Error?) -> Void) where T.Element: Track {
        makeAddTracksRequest(tracks: tracks, position: position).perform { (snapshotID: [String: String]?, error) in
            handler(snapshotID?.first?.value, error)
        }
    }
    
    /// Adds the given track to the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Adding tracks to a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, adding tracks to a private playlist (including collaborative playlists) requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - track: The track to add.
    ///   - position: The index at which to insert the track. If omitted or set to `nil`, the track will be appended to the playlist. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func add<T: Track>(_ track: T, at position: Int? = nil, handler: @escaping (String?, Error?) -> Void) {
        add([track], handler: handler)
    }

    // MARK: Remove Tracks from a Playlist ✔︎
    
    /// Creates and returns the request used to remove tracks from the playlist.
    ///
    /// - Note: This method is used only to construct the `SKRequest` instance, and is kept private to (a) avoid confusion regarding which parameters can be supplied, and (b) remove the need to explicitly define '`T`' for cases where we aren't providing any tracks to the request.
    ///
    /// The request cannot specify both positions and tracks simultaneously.
    private func _makeRemoveTracksRequest<T: Collection>(tracks: T?, positions: [Int]?, snapshotID: String?) -> SKRequest where T.Element: Track {

        let request = SKRequest(method: .DELETE, endpoint: Constants.Endpoints.tracksForPlaylist(id: id, ownerID: owner.id))!
        
        typealias RequestBody = Constants.RequestBodies.RemoveTracksBody
        let tracks = tracks?.map { RequestBody.Track(uri: $0.uri) }
        let data = try! RequestBody(tracks: tracks, positions: positions, snapshotID: snapshotID).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Creates and returns the request used to remove tracks from the playlist.
    ///
    /// - Parameters:
    ///   - tracks: The list of tracks to remove. The tracks' URIs must match those already in the playlist, otherwise the request will result in an error. Call the method with this parameter when attempting to remove all occurrences of a given track or set of tracks within the playlist.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeRemoveTracksRequest<T: Collection>(tracks: T, snapshotID: String?) -> SKRequest where T.Element: Track {
        return _makeRemoveTracksRequest(tracks: tracks, positions: nil, snapshotID: snapshotID)
    }
    
    /// Creates and returns the request used to remove tracks from the playlist.
    ///
    /// - Parameters:
    ///   - positions: An array of integers representing the indices of the tracks to remove. The values provided must be valid indices within the list of tracks.  Call the method with this parameter when attempting to remove tracks at a specific position or positions within the playlist.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeRemoveTracksRequest(positions: [Int], snapshotID: String?) -> SKRequest {
        let tracks: [SKTrack]? = nil // Compiler cannot infer 'T' from simply passing nil, so we create a typed nil value here.
        return _makeRemoveTracksRequest(tracks: tracks, positions: positions, snapshotID: snapshotID)
    }
    
    /// Removes one or more tracks from the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Removing tracks from a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, removing tracks from a private playlist requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - positions: An array of integers representing the indices of the tracks to remove. The values provided must be valid indices within the list of tracks. A maximum of 100 values can be sent at once.
    ///   - snapshotID: The specific playlist snapshot against which to perform the changes. This parameter is required to guard against concurrent edits to the playlist. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts. The default value is the playlist's current `snapshotID`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func remove(at positions: [Int], inSnapshot snapshotID: String = "", handler: @escaping (String?, Error?) -> Void) { // removeTracks
        
        let snapshotID = snapshotID.isEmpty ? self.snapshotID : snapshotID
        
        makeRemoveTracksRequest(positions: positions, snapshotID: snapshotID).perform { (snapshotID: [String: String]?, error) in
            handler(snapshotID?.first?.value, error)
        }
    }
    
    /// Removes one or more tracks from the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Removing tracks from a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, removing tracks from a private playlist requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - position: An integer representing the index of the track to remove. The value provided must be a valid index within the list of tracks.
    ///   - snapshotID: The specific playlist snapshot against which to perform the changes. This parameter is required to guard against concurrent edits to the playlist. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts. The default value is the playlist's current `snapshotID`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func remove(at position: Int, inSnapshot snapshotID: String = "", handler: @escaping (String?, Error?) -> Void) { // removeTrack
        
        remove(at: [position], inSnapshot: snapshotID, handler: handler)
    }
    
    /// Removes all occurrences of the specified tracks from the playlist.
    ///
    /// - Parameters:
    ///   - tracks: The list of tracks to remove. The tracks' URIs must match those already in the playlist, otherwise the request will result in an error.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts. The API will validate that the specified tracks exist and make the changes, even if more recent changes have been made to the playlist. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func removeOccurrences<T: Collection>(of tracks: T, inSnapshot snapshotID: String? = nil, handler: @escaping (String?, Error?) -> Void) where T.Element: Track {
        
        makeRemoveTracksRequest(tracks: tracks, snapshotID: snapshotID).perform { (snapshotID: [String: String]?, error) in
            handler(snapshotID?.first?.value, error)
        }
    }
    
    /// Removes all occurrences of the specified track from the playlist.
    ///
    /// - Parameters:
    ///   - track: The track to remove. The track's URI must match one already in the playlist, otherwise the request will result in an error.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. When making subsequent playlist requests, use this parameter to supply the most recent snapshot identifier to avoid editing conflicts. The API will validate that the specified track exists and make the changes, even if more recent changes have been made to the playlist. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func removeOccurrences<T: Track>(of track: T, inSnapshot snapshotID: String? = nil, handler: @escaping (String?, Error?) -> Void) {
        
        removeOccurrences(of: [track], inSnapshot: snapshotID, handler: handler)
    }
    
    // MARK: Reorder a Playlist's Tracks ✔︎
    
    /// Creates and returns the request used to reorder tracks in a playlist.
    ///
    /// - Parameters:
    ///   - startIndex: The index of the first track to be reordered.
    ///   - rangeLength: The number of tracks to be reordered, beginning with the start index. If reordering a single track, set this parameter to `nil`.
    ///   - position: The index of the track before which the reordered track(s) should be inserted.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeMoveTracksRequest(startIndex: Int, rangeLength: Int?, position: Int, snapshotID: String?) -> SKRequest {
        
        let request = SKRequest(method: .PUT, endpoint: Constants.Endpoints.tracksForPlaylist(id: id, ownerID: owner.id))!
        
        typealias RequestBody = Constants.RequestBodies.ReorderTracksBody
        let data = try! RequestBody(startIndex: startIndex,
                                    rangeLength: rangeLength,
                                    newIndex: position,
                                    snapshotID: snapshotID).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Reorders a track or a group of tracks in a playlist.
    ///
    /// When reordering tracks, the timestamp indicating when they were added and the user who added them will be kept untouched. In addition, users following the playlists will not be notified about changes in the playlists when the tracks are reordered.
    ///
    /// # Discussion
    ///
    /// When selecting which tracks to reorder, you can use a half-open range to select tracks up to a given index. For example:
    ///
    /// ## Listing 1
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 7..<endIndex, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves tracks at index seven onwards
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    /// Alternatively, you can use a closed range to encompass all tracks at the given indices. For example:
    ///
    /// ## Listing 2
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 0...2, before: endIndex) {
    ///     (snapshotID, error) in
    ///     // Moves the first three tracks
    ///     // to the end of the playlist.
    /// }
    /// ````
    /// If you simply want to move a single track instead of a range of tracks, you can also provide a single index value. For example:
    ///
    /// ## Listing 3
    /// ````
    /// playlist.move(at: 5, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves the track at index five
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    ///
    /// For a better visualization on how reordering Spotify tracks works, see the [API Endpoint Reference](https://developer.spotify.com/web-api/reorder-playlists-tracks/).
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// - Parameters:
    ///   - indices: A contiguous range of integers representing the indices of the tracks to reorder, with the lower bound representing the index of the first track to be reordered. When using a closed range, the bounds of the range must be valid indices within the list of tracks; with a half-open range, all values up to (but not including) the upper bound must be valid indices within the list of tracks.
    ///   - position: The index of the track before which the reordered track(s) should be inserted. To move tracks to the end of the playlist, set this parameter to the track list's "past the end" position—that is, the position one greater than the last valid index. With the exception of this value, this parameter must be a valid index within the list of tracks.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func move(at indices: Range<Int>, before position: Int, inSnapshot snapshotID: String? = nil, handler: @escaping (String?, Error?) -> Void) { // moveTracks
        
        makeMoveTracksRequest(startIndex: indices.lowerBound,
                              rangeLength: indices.count == 1 ? nil : indices.count,
                              position: position,
                              snapshotID: snapshotID)
            
            .perform { (snapshotID: [String: String]?, error) in
                handler(snapshotID?.first?.value, error)
        }
    }
    
    /// Reorders a track or a group of tracks in a playlist.
    ///
    /// When reordering tracks, the timestamp indicating when they were added and the user who added them will be kept untouched. In addition, users following the playlists will not be notified about changes in the playlists when the tracks are reordered.
    ///
    /// # Discussion
    ///
    /// When selecting which tracks to reorder, you can use a half-open range to select tracks up to a given index. For example:
    ///
    /// ## Listing 1
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 7..<endIndex, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves tracks at index seven onwards
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    /// Alternatively, you can use a closed range to encompass all tracks at the given indices. For example:
    ///
    /// ## Listing 2
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 0...2, before: endIndex) {
    ///     (snapshotID, error) in
    ///     // Moves the first three tracks
    ///     // to the end of the playlist.
    /// }
    /// ````
    /// If you simply want to move a single track instead of a range of tracks, you can also provide a single index value. For example:
    ///
    /// ## Listing 3
    /// ````
    /// playlist.move(at: 5, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves the track at index five
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    ///
    /// For a better visualization on how reordering Spotify tracks works, see the [API Endpoint Reference](https://developer.spotify.com/web-api/reorder-playlists-tracks/).
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// - Parameters:
    ///   - indices: A contiguous range of integers representing the indices of the tracks to reorder, with the lower bound representing the index of the first track to be reordered. When using a closed range, the bounds of the range must be valid indices within the list of tracks; with a half-open range, all values up to (but not including) the upper bound must be valid indices within the list of tracks.
    ///   - position: The index of the track before which the reordered track(s) should be inserted. To move tracks to the end of the playlist, set this parameter to the track list's "past the end" position—that is, the position one greater than the last valid index. With the exception of this value, this parameter must be a valid index within the list of tracks.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func move(at indices: ClosedRange<Int>, before position: Int, inSnapshot snapshotID: String? = nil, handler: @escaping (String?, Error?) -> Void) {
        move(at: Range(indices), before: position, handler: handler)
    }
    
    /// Reorders a track or a group of tracks in a playlist.
    ///
    /// When reordering tracks, the timestamp indicating when they were added and the user who added them will be kept untouched. In addition, users following the playlists will not be notified about changes in the playlists when the tracks are reordered.
    ///
    /// # Discussion
    ///
    /// When selecting which tracks to reorder, you can use a half-open range to select tracks up to a given index. For example:
    ///
    /// ## Listing 1
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 7..<endIndex, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves tracks at index seven onwards
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    /// Alternatively, you can use a closed range to encompass all tracks at the given indices. For example:
    ///
    /// ## Listing 2
    /// ````
    /// let endIndex = playlist.totalTracks
    /// playlist.move(at: 0...2, before: endIndex) {
    ///     (snapshotID, error) in
    ///     // Moves the first three tracks
    ///     // to the end of the playlist.
    /// }
    /// ````
    /// If you simply want to move a single track instead of a range of tracks, you can also provide a single index value. For example:
    ///
    /// ## Listing 3
    /// ````
    /// playlist.move(at: 5, before: 0) {
    ///     (snapshotID, error) in
    ///     // Moves the track at index five
    ///     // to the beginning of the playlist.
    /// }
    /// ````
    ///
    /// For a better visualization on how reordering Spotify tracks works, see the [API Endpoint Reference](https://developer.spotify.com/web-api/reorder-playlists-tracks/).
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// - Parameters:
    ///   - index: The index of the track to reorder. This parameter must be valid index within the list of tracks.
    ///   - position: The index of the track before which the reordered track(s) should be inserted. To move tracks to the end of the playlist, set this parameter to the track list's "past the end" position—that is, the position one greater than the last valid index. With the exception of this value, this parameter must be a valid index within the list of tracks.
    ///   - snapshotID: A specific playlist snapshot against which to perform the changes. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func move(at index: Int, before position: Int, inSnapshot snapshotID: String? = nil, handler: @escaping (String?, Error?) -> Void) { // moveTrack
        
        makeMoveTracksRequest(startIndex: index, rangeLength: nil, position: position, snapshotID: snapshotID)
            .perform { (snapshotID: [String: String]?, error) in
                handler(snapshotID?.first?.value, error)
        }
    }
    
    // MARK: Replace a Playlist's Tracks ✔︎
    
    /// Creates and returns the request used to replace tracks in the playlist.
    ///
    /// - Parameter tracks: The list of tracks with which to replace the contents of the playlist. To clear all tracks from the playlist, set this parameter to an empty array.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeReplaceTracksRequest<T: Collection>(tracks: T) -> SKRequest where T.Element: Track {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.uris] = tracks.map { $0.uri }  // Note: We want to keep this parameter even if 'tracks' is empty,
                                                                            // in case the user wants to clear all tracks from the playlist.
                                                                            // (i.e., "/playlist/{playlistID}/tracks?uris=")
        return SKRequest(method: .PUT, endpoint: Constants.Endpoints.tracksForPlaylist(id: id, ownerID: owner.id), parameters: parameters)!
    }
    
    /// Replaces all the tracks in the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Replacing tracks in a public playlist requires authorization of the "`playlist-modify-public`" scope; likewise, replacing tracks in a private playlist requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - tracks: The list of tracks with which to replace the contents of the playlist. To clear all tracks from the playlist, set this parameter to an empty array.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `snapshotID`: On success, the snapshot ID string identifying the version of this playlist that reflects the given changes. This value can be used to identify this specific version in subsequent requests.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func replace<T: Collection>(with tracks: T, handler: @escaping (String?, Error?) -> Void) where T.Element: Track {
        
        makeReplaceTracksRequest(tracks: tracks).perform { (snapshotID: [String: String]?, error) in
            handler(snapshotID?.first?.value, error)
        }
    }
}

// MARK: - Follow Requests

/// A type representing a Spotify item that can be followed or unfollowed by the current authenticated user.
///
/// Types that conform to this protocol provide a set of request factories and convenience methods to either follow, unfollow, or check to see if the current authenticated user is already following the given item. These types must also contain a valid [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids).
///
/// - Note: Although a Spotify playlist is technically a "followable" catalog item, the method declarations and implementations for following playlists differ from those defined here. Thus, the `SKPlaylist` type does not conform to this protocol, but instead provides its own comparable methods and request factories.
public protocol Followable {
    
    /// The [Spotify ID](https://developer.spotify.com/web-api/user-guide/#spotify-uris-and-ids) for the item. **Required.**
    var id: String { get }
    
    /// Creates and returns the request used to add the current authenticated user as a follower of the item.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    func makeFollowRequest() -> SKRequest
    
    /// Creates and returns the request used to remove the current authenticated user as a follower of the item.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    func makeUnfollowRequest() -> SKRequest
    
    /// Creates and returns the request used to check whether the current authenticated user is following the item.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    func makeFollowStatusRequest() -> SKRequest
    
    /// Adds the current authenticated user as a follower of the item.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    func follow(handler: @escaping SKErrorHandler)
    
    /// Removes the current authenticated user as a follower of the item.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    func unfollow(handler: @escaping SKErrorHandler)
    
    /// Checks whether the current authenticated user is following the item.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `isFollowing`: A Boolean value indicating whether the current authenticated user is following the item: `true` if following, `false` otherwise.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    func checkIfFollowing(handler: @escaping (Bool?, Error?) -> Void)
}

// MARK: Internal Requirements

/// Specifies intermediary internal requirements for the `Followable` protocol.
///
/// While these requirements would be easier kept in the public `Followable` protocol, doing so would unnecessarily expose properties and methods that are only relevant to the Web API, polluting the type's public namespace.
internal protocol _Followable {
    
    /// The string representation of this type, used by API requests to specify which [Spotify object](https://developer.spotify.com/web-api/object-model/) the type represents.
    static var type: String { get }
}

extension SKArtist: _Followable { static var type = "artist" }
extension SKUser: _Followable { static var type = "user" } // Wouldn't make sense for the current user to follow a SKCurrentUser type... so there's no need to include the User protocol. This should only apply to SKUser types.

// MARK: Default Implementation

extension Followable {
    
    private var followRequestParameters: [String: Any] {
        get {
            var parameters = [String: Any]()
            parameters[Constants.QueryParameters.ids] = id
            parameters[Constants.QueryParameters.type] = (Self.self as? _Followable.Type)?.type // Self.type
            return parameters
        }
    }
    
    public func makeFollowRequest() -> SKRequest {
        return SKRequest(method: .PUT, endpoint: Constants.Endpoints.myFollows, parameters: followRequestParameters)!
    }
    
    public func makeUnfollowRequest() -> SKRequest {
        return SKRequest(method: .DELETE, endpoint: Constants.Endpoints.myFollows, parameters: followRequestParameters)!
    }
    
    public func makeFollowStatusRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.checkIfFollowing, parameters: followRequestParameters)!
    }
    
    public func follow(handler: @escaping SKErrorHandler) {
        makeFollowRequest().perform(handler: handler)
    }
    
    public func unfollow(handler: @escaping SKErrorHandler) {
        makeUnfollowRequest().perform(handler: handler)
    }
    
    public func checkIfFollowing(handler: @escaping (Bool?, Error?) -> Void) {
        makeFollowStatusRequest().perform { (flags: [Bool]?, error) in
            handler(flags?.first, error)
        }
    }
}

extension SKArtist: Followable {}
extension SKUser: Followable {}

// MARK: Collection Conformance

extension Collection/*: Followable */where Element: Followable {
    
    private var followRequestParameters: [String: Any] {
        get {
            if self.isEmpty { assertionFailure("collection of Followable items must contain at least one value for the API request to be valid.") }
            
            var parameters = [String: Any]()
            parameters[Constants.QueryParameters.ids] = self.isEmpty ? nil : self.map { $0.id }
            parameters[Constants.QueryParameters.type] = (Element.self as? _Followable.Type)?.type // Element.type
            return parameters
        }
    }
    
    /// Creates and returns the request used to add the current authenticated user as a follower of the items in the collection.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFollowRequest() -> SKRequest {
        return SKRequest(method: .PUT, endpoint: Constants.Endpoints.myFollows, parameters: followRequestParameters)!
    }
    
    /// Creates and returns the request used to remove the current authenticated user as a follower of the items in the collection.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeUnfollowRequest() -> SKRequest {
        return SKRequest(method: .DELETE, endpoint: Constants.Endpoints.myFollows, parameters: followRequestParameters)!
    }
    
    /// Creates and returns the request used to check whether the current authenticated user is following the items in the collection.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFollowStatusRequest() -> SKRequest {
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.checkIfFollowing, parameters: followRequestParameters)!
    }
    
    /// Adds the current authenticated user as a follower of the items in the collection.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func follow(handler: @escaping SKErrorHandler) {
        makeFollowRequest().perform(handler: handler)
    }
    
    /// Removes the current authenticated user as a follower of the items in the collection.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func unfollow(handler: @escaping SKErrorHandler) {
        makeUnfollowRequest().perform(handler: handler)
    }
    
    /// Checks whether the current authenticated user is following the items in the collection.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Modifying the list of items that the current authenticated user follows also requires authorization of the "`user-follow-modify`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request. The parameters for this handler are:
    ///     - `isFollowing`: An array of Boolean values indicating whether the current authenticated user is following the item at the corresponding index. If a particular item is followed by the current authenticated user, the resulting array will contain `true` at the corresponding index; `false` otherwise.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func checkIfFollowing(handler: @escaping ([Bool]?, Error?) -> Void) {
        makeFollowStatusRequest().perform(handler: handler)
//        makeFollowStatusRequest().perform { (bools: [Bool]?, error) in
//            guard error == nil else { handler(nil, error); return }
//
//            let ids = self.map { $0.id }
//            var dictionary = [String: Bool]()
//            for (id, bool) in zip(ids, bools!) {
//                dictionary[id] = bool
//            }
//
//            handler(dictionary, nil)
//        }
    }
}

// MARK: Playlist Follow Requests

extension SKPlaylist {
    
    // MARK: Follow a Playlist ✔︎
    
    /// Creates and returns the request used to add the current authenticated user as a follower of the playlist.
    ///
    /// - Parameter public: A Boolean value indicating whether the playlist should be included in the user's public playlists. **Note**: to follow playlists privately, the user must authorize the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/spotify-web-api/using-scopes/) for more details.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFollowRequest(public: Bool) -> SKRequest {
        
        let request = SKRequest(method: .PUT, endpoint: Constants.Endpoints.followsForPlaylist(id: id, ownerID: owner.id))!
        
        typealias RequestBody = Constants.RequestBodies.PlaylistFollowBody
        let data = try! RequestBody(isPublic: `public`).data()
        
        request.addMultipartData(data, type: .json)
        return request
    }
    
    /// Adds the current authenticated user as a follower of the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Following a playlist publicly requires authorization of the "`playlist-modify-public`" scope; likewise, following a playlist privately requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - public: A Boolean value indicating whether the playlist should be included in the user's public playlists. The default value is `true`. **Note**: to follow playlists privately, the user must have authorized the "`playlist-modify-private`" scope.
    ///   - handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func follow(makingPublic public: Bool = true, handler: @escaping SKErrorHandler) {
        makeFollowRequest(public: `public`).perform(handler: handler)
    }
    
    // MARK: Unfollow a Playlist ✔︎
    
    /// Creates and returns the request used to remove the current authenticated user as a follower of the playlist.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeUnfollowRequest() -> SKRequest {
        return SKRequest(method: .DELETE, endpoint: Constants.Endpoints.followsForPlaylist(id: id, ownerID: owner.id))!
    }
    
    /// Removes the current authenticated user as a follower of the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. The access token must have been issued on behalf of the current user.
    ///
    /// Unfollowing a publicly-followed playlist requires authorization of the "`playlist-modify-public`" scope; likewise, unfollowing a privately-followed playlist requires authorization of the "`playlist-modify-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameter handler: The callback handler for the request, providing an error object identifying if and why the request failed, or `nil` if the request was successful.
    public func unfollow(handler: @escaping SKErrorHandler) {
        makeUnfollowRequest().perform(handler: handler)
    }
    
    // MARK: Check if Users Follow a Playlist ✔︎
    
    /// Creates and returns the request used to check whether the given users are following the playlist.
    ///
    /// - Parameter users: The users against which to perform the check. Maximum: 5 users.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFollowStatusRequest<T: Collection>(users: T) -> SKRequest where T.Element: User {
        if users.isEmpty { assertionFailure("array of users must contain at least one value for the API request to be valid.") }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = users.isEmpty ? nil : users.map { $0.id }
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.checkIfUsersFollowPlaylist(id: id, ownerID: owner.id), parameters: parameters)!
    }
    
    /// Check to see if one or more Spotify users are following the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// Following a playlist can be done publicly or privately. Checking if a user publicly follows a playlist doesn't require any scopes; if the user is publicly following the playlist, the resulting Boolean value will be `true`.
    ///
    /// However, checking if the user is privately following a playlist is only possible for the current authenticated user when that user has granted access to the "`playlist-read-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - users: The users against which to perform the check. Maximum: 5 users.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `isFollowing`: An array of Boolean values indicating whether the given users are following the playlist. For each user that is following, the resulting array will contain `true` at the corresponding index; `false` otherwise.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func checkIfFollowed<T: Collection>(by users: T, handler: @escaping ([Bool]?, Error?) -> Void) where T.Element: User {
        makeFollowStatusRequest(users: users).perform(handler: handler)
    }
    
    /// Creates and returns the request used to check whether the given user is following the playlist.
    ///
    /// - Parameter user: The user against which to perform the check.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFollowStatusRequest<T: User>(user: T) -> SKRequest {
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = user.id
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.checkIfUsersFollowPlaylist(id: id, ownerID: owner.id), parameters: parameters)!
    }
    
    /// Check to see if one or more Spotify users are following the playlist.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// Following a playlist can be done publicly or privately. Checking if a user publicly follows a playlist doesn't require any scopes; if the user is publicly following the playlist, the resulting Boolean value will be `true`.
    ///
    /// However, checking if the user is privately following a playlist is only possible for the current authenticated user when that user has granted access to the "`playlist-read-private`" scope. See [Using Scopes](https://developer.spotify.com/web-api/using-scopes/) for more details.
    ///
    /// - Parameters:
    ///   - user: The user against which to perform the check.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `isFollowing`: A Boolean value indicating whether the given user is following the playlist: `true` if following, `false` otherwise.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func checkIfFollowed<T: User>(by user: T, handler: @escaping (Bool?, Error?) -> Void) {
        makeFollowStatusRequest(user: user).perform { (flags: [Bool]?, error) in
            handler(flags?.first, error)
        }
    }
}

// TODO: Get Authenticated User's Followed Albums

// MARK: - Expandable Type Requests

/// A type that is represented in the [Spotify Web API](https://developer.spotify.com/web-api/) by both "simplified" and "full" versions.
///
/// Types that conform to this protocol provide a set of convenience methods to retrieve the full version of a simplified SpotifyKit object, and are required to have a URL providing the API endpoint to the full details of the item.
///
/// These types also implement an "`isSimplified`" property, a Boolean value indicating whether an instance of this type represents a "simplified" version of the "full" Spotify object.
public protocol Expandable {
    
    /// A link to the [Web API endpoint](https://developer.spotify.com/web-api/endpoint-reference/) providing full details of the object. **Required.**
    var url: URL { get }
    
    /// A boolean value indicating whether this instance represents a "simplified" version of the "full" Spotify object (i.e., all values unique to the full object are `nil`).
    var isSimplified: Bool { get }
    
    /// Performs a request for the detailed version of the item.
    ///
    /// If the given object already contains the requested properties, this method will do nothing and the provided callback handler will not be executed.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameter handler: The callback handler for this request, providing the detailed object if successful, or an error object identifying if and why the request or the decoding failed if unsuccessful.
    func getFullObject(handler: @escaping (Self?, Error?) -> Void)
    //func simplified() -> Self
    //mutating func simplify()
}

extension Expandable where Self: JSONDecodable {
    
    /// Creates and returns the request used to retrieve the detailed version of the given object.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeFullObjectRequest() -> SKRequest {
        return SKRequest(method: .GET, url: url)!
    }
    
    public func getFullObject(handler: @escaping (Self?, Error?) -> Void) {
        guard isSimplified else { return }
        makeFullObjectRequest().perform(handler: handler)
    }
}

// MARK: - Paging Requests

extension Page {
    
    /// Gets the next page of items and provides it to the specified handler, or `nil` if no next page exists.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameter handler: The callback handler for this request, providing the next page of elements if successful, or an error object identifying if and why the request or the decoding failed if unsuccessful.
    public func getNext(handler: @escaping (Page<Element>?, Error?) -> Void) {
        guard let url = nextURL else { handler(nil, nil); return }
        SKRequest(method: .GET, url: url)!.perform(handler: handler)
    }
    
    /// Gets the previous page of items and provides it to the specified handler, or `nil` if no previous page exists.
    ///
    /// - Note: This method uses the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error.
    ///
    /// - Parameter handler: The callback handler for this request, providing the previous page of elements if successful, or an error object identifying if and why the request or the decoding failed if unsuccessful.
    public func getPrevious(handler: @escaping (Page<Element>?, Error?) -> Void) {
        guard let url = previousURL else { handler(nil, nil); return }
        SKRequest(method: .GET, url: url)!.perform(handler: handler)
    }
}
