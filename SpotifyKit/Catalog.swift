//
//  Catalog.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 9/17/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A structure used to make requests to the [Spotify Web API](https://developer.spotify.com/web-api/) catalog for top-level items, such as albums, artists, tracks, playlists, and others.
///
/// - Note: All request-performing methods (e.g., "`getAlbum`" or "`search`") use the `SPTAuth` default instance session to authenticate the underlying request. If this session does not contain a valid access token, the request will result in an error. If you want to customize the request by injecting your own custom URL/API session or by decoding the response yourself, you can do so using any of the accompanying factory methods (e.g., "`makeAlbumRequest`" or "`makeSearchRequest`") to create and return the `SKRequest` instance itself.
public struct SKCatalog {
    
    public static var local: SKCatalog { return SKCatalog(locale: Locale.current) } // var current // Locale.autoupdatingCurrent
    
    /// The locale representing the specific storefront/market from which to request catalog content.
    ///
    /// All requests that include a "`market`," "`country`," or "`locale`" parameter will refer to the region and language codes provided by this property. If set to `nil`, many requests will return results for all available markets.
    ///
    /// - Important: Some requests are are required to specify a locale or country code, and will result in an error if no locale is set before performing the request. This requirement will be annotated by all requests to which this applies.
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
    public func makeFeaturedPlaylistsRequest(date: Date?, page: PageParameters?) -> SKRequest {
        
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
    public func getFeaturedPlaylists(for date: Date? = Date(), page: PageParameters? = nil, handler: @escaping (SKFeaturedPlaylists?, Error?) -> Void) {
        makeFeaturedPlaylistsRequest(date: date, page: page).perform(handler: handler)
    }
    
    // MARK: Get New Releases ✔︎
    
    /// Creates and returns the request used to get a list of new album releases.
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeNewReleasesRequest(page: PageParameters?) -> SKRequest {
        
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
    public func getNewReleases(page: PageParameters? = nil, handler: @escaping (Page<SKAlbum>?, Error?) -> Void) {
        makeNewReleasesRequest(page: page).perform(handler: handler)
    }
    
    // MARK: Get a List of Categories ✔︎
    
    /// Creates and returns the request used to get a list of categories.
    ///
    /// - Note: If a catalog locale has not been specified (i.e., `locale` is set to `nil`), or if the specified language is not available, all strings will be returned in the Spotify default language (American English).
    ///
    /// - Parameter page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeCategoriesRequest(page: PageParameters?) -> SKRequest {
        
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
    public func getCategories(page: PageParameters? = nil, handler: @escaping (Page<SKCategory>?, Error?) -> Void) {
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
                                           tracks: [SKTrack],
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
    ///   - alternate: An alternate search term used to broaden the search. If no alternate keywords are needed, set this parameter to an empty string.
    ///   - unwanted: Unwanted keywords to exclude from the search. If no unwanted keywords are needed, set this parameter to an empty string.
    ///   - inOrder: When `false`, keywords will be matched in any order; when `true`, the search will maintain exact keyword order.
    ///   - filters: A list of field filters by which to narrow the search. For available filters, see `SKSearchFieldFilter`. If no filters are needed, set this parameter to an empty array.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeSearchRequest(types: Set<SKSearchResultType>,
                                  keywords: String,
                                  alternate: String,
                                  unwanted: String,
                                  inOrder: Bool,
                                  filters: Set<SKSearchFieldFilter>,
                                  page: PageParameters?) -> SKRequest {
        
        // Begin with the primary keywords, adding quotes if 'inOrder' is true:
        var query: String = inOrder ? "\"" + keywords.lowercased() + "\"" : keywords.lowercased()
        
        // Add any alternate keywords:
        if !alternate.isEmpty {
            query.append(" OR " + alternate.lowercased())
        }
        
        // Add any unwanted keywords:
        if !unwanted.isEmpty {
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
        parameters[Constants.QueryParameters.itemType] = types.isEmpty ? nil : types
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
                       or alternate: String = "",
                       excluding unwanted: String = "",
                       inOrder: Bool = false,
                       filteredBy filters: Set<SKSearchFieldFilter> = [],
                       page: PageParameters? = nil,
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
    
    // TODO: - Playlists
    
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
    ///   - types: The types of albums by which to filter results. If no types are specified (i.e., parameter is set to an empty array), all album types will be returned. See `SKAlbum.AlbumType` for possible values.
    ///   - locale: The locale-specific storefront/market from which to request. **Note:** If set to `nil`, results will be returned for all markets and will likely contain duplicate results, one for each market in which the album is available.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item.
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAlbumsRequest(types: Set<SKAlbum.AlbumType>, locale: Locale?, page: PageParameters?) -> SKRequest {
        
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
    ///   - types: The types of albums by which to filter results. If no types are specified, all album types will be returned. See `SKAlbum.AlbumType` for possible values. The default value is an empty array.
    ///   - locale: The locale-specific storefront/market from which to request. The default value is `Locale.current`, which represents the user's region settings at the time the method is called. **Note:** If set to `nil`, results will be returned for all markets and will likely contain duplicate results, one for each market in which the album is available.
    ///   - page: The parameters for paginating the results, specifying the index and number of items to return. If no parameters are supplied, the request will return the default number of items beginning with first item. The default value is `nil`.
    ///   - handler: The callback handler for the request. The parameters for this handler are:
    ///     - `albums`: A paginated collection of simplified albums, if available.
    ///     - `error`: An error object identifying if and why the request failed, or `nil` if the request was successful.
    public func getAlbums(filteredBy types: Set<SKAlbum.AlbumType> = [], for locale: Locale? = SKCatalog.local.locale, page: PageParameters? = nil, handler: @escaping (Page<SKAlbum>?, Error?) -> Void) {
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
    public func makePlaylistsRequest(locale: Locale?, page: PageParameters?) -> SKRequest {
        
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
    public func getPlaylists(for locale: Locale? = SKCatalog.local.locale, page: PageParameters? = nil, handler: @escaping (Page<SKPlaylist>?, Error?) -> Void) {
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

extension Array where Element == SKTrack {
    
    // MARK: Get Audio Features for Several Tracks ✔︎
    
    /// Creates and returns the request used to get audio features for the current array of tracks.
    ///
    /// - Important: The maximum number of IDs the API can process for a single request to this endpoint is 100. If the current array contains more than 100 items, the request may result in an error.
    ///
    /// - Returns: An `SKRequest` instance with which to perform the API request.
    public func makeAudioFeaturesRequest() -> SKRequest {
        if self.isEmpty { assertionFailure("array of IDs must contain at least one value for the API request to be valid.") }
        
        var parameters = [String: Any]()
        parameters[Constants.QueryParameters.ids] = map { $0.id }
        return SKRequest(method: .GET, endpoint: Constants.Endpoints.audioFeatures, parameters: parameters)!
    }
    
    /// Gets audio feature information for the current array of tracks.
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

// MARK: - Expandable Type Requests

/// A type that is represented in the [Spotify Web API](https://developer.spotify.com/web-api/) by both "simplified" and "full" versions of the given type.
///
/// Types that conform to this protocol provide a set of convenience methods to retrieve the full version of a simplified SpotifyKit object, and are required to have a URL providing the API endpoint to the full details of the given object.
///
/// These types also implement an "`isSimplified`" property, a Boolean value indicating whether an instance of the given type represents a "simplified" version of the "full" Spotify object.
public protocol Expandable {
    
    /// A link to the [Web API endpoint](https://developer.spotify.com/web-api/endpoint-reference/) providing full details of the object. **Required.**
    var url: URL { get }
    
    /// A boolean value indicating whether this instance represents a "simplified" version of the "full" Spotify object (i.e., all values unique to the full object are `nil`).
    var isSimplified: Bool { get }
    
    /// Performs a request for the detailed version of the given object.
    ///
    /// If the given object already contains the requested properties, this method will do nothing, and the provided callback handler will not be executed.
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
