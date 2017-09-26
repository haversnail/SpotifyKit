//
//  RequestTests.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 8/10/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import XCTest
@testable import SpotifyKit

class RequestTests: XCTestCase {
    
    var catalog: SKCatalog!
    
    // MARK: - Test Case Lifecycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // FIXME: 1. Provide your username.
        let username = "francesetoth"
        
        // FIXME: 2. Request an access token.
        /// - Note: Be sure to request all scopes when retrieving a new token, as some tests will perform API requests that require access to private user data.
        /// - SeeAlso: https://developer.spotify.com/web-api/console/
        let accessToken = "BQDeUq5pROz9Ah6IIY7-rq0R0oIpj7DZ8zUie5WwGOmLI7e2SUy7g-9fmYigWvgaUnNIdAfSk-BhhiXGpSjeI0MX6XMJu-Iykm1bdKG9kmVWFI5q3yullW68boFwnySms4h-bo63bFe6mSVzfA"
        
        SPTAuth.defaultInstance().session = SPTSession(userName: username,
                                                       accessToken: accessToken,
                                                       expirationDate: Date.distantFuture)
        
        catalog = SKCatalog(locale: Locale(identifier: "en_US"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        SPTAuth.defaultInstance().session = nil
        catalog = nil
        super.tearDown()
    }
    
    // MARK: - Utility Methods
    
    func makeRequestExpectation() -> XCTestExpectation {
        return expectation(description: "the request handler was invoked.")
    }
    
    func wait(for expectation: XCTestExpectation, timeout: TimeInterval = 5, file: StaticString = #file, line: UInt = #line) {
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        switch result {
            case .timedOut: XCTFail("the request timed out.", file: file, line: line)
            // add other cases here if needed.
            default: break
        }
    }
    
    func assertRequest(_ request: SKRequest, contains components: String..., file: StaticString = #file, line: UInt = #line) {
        let url = request.preparedURLRequest.url!.absoluteString
        
        for component in components {
            if !url.contains(component) {
                XCTFail("expected to find \"\(component)\" in the prepared URL request: \(url)", file: file, line: line)
            }
        }
    }
    
    // MARK: - Request Class Tests
    
    func testInit() {
        
        // Arrange:
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm/tracks?market=AU&limit=3")!
        let invalidURL = URL(string: "https://www.example.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm/tracks?market=AU&limit=3")!
        let parameters: [String: Any] = ["offset": 3, "market": "US"] // The "market" parameter should overwrite the existing "market" query item.
        
        // Act:
        let request = SKRequest(method: .GET, url: url, parameters: parameters)
        let failedRequest = SKRequest(method: .GET, url: invalidURL, parameters: parameters)
        
        // Assert requests:
        XCTAssertNotNil(request, "could not create the request.")
        XCTAssertNil(failedRequest, "initialized a request with an invalid URL.")
        
        // Assert sanitized URL:
        XCTAssertEqual(request?.url.absoluteString, "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm/tracks", "URL did not remove existing query string.")
        
        // Assert parameters:
        XCTAssert(request?.parameters.count == 3, "existing query items were not appended to the 'parameters' property.")
        XCTAssert(request?.parameters.contains { $0.key == "market" && ($0.value as? String) == "US" } ?? false, "existing query items were not overwritten with items from the 'parameters' argument.")
        //print(request?.parameters ?? "No parameters: request was not valid!")
    }
    
    func testConvenienceInit() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let endpointWithoutLeadingSlash = "v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let endpointWithBaseURL = "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let endpointWithInvalidBaseURL = "https://www.example.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        
        let expectedURL = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        
        // Act:
        let validRequest = SKRequest(method: .GET, endpoint: endpoint)
        let validRequest2 = SKRequest(method: .GET, endpoint: endpointWithoutLeadingSlash)
        let validRequest3 = SKRequest(method: .GET, endpoint: endpointWithBaseURL)
        let invalidRequest = SKRequest(method: .GET, endpoint: endpointWithInvalidBaseURL)
        
        // Assert:
        XCTAssertNotNil(validRequest, "could not create the request.")
        XCTAssertEqual(validRequest?.url.absoluteURL, expectedURL)
        XCTAssertNotNil(validRequest2, "could not create the request.")
        XCTAssertEqual(validRequest2?.url.absoluteURL, expectedURL)
        XCTAssertNotNil(validRequest3, "could not create the request.")
        XCTAssertEqual(validRequest3?.url.absoluteURL, expectedURL)
        XCTAssertNil(invalidRequest, "initialized a request with an invalid endpoint.")
    }
    
    func testPreparedURLRequest() {
        
        // Arrange:
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        let request = SKRequest(method: .GET, url: url, parameters: ["market": "US"])
        let requestBody = "{\"test\":true}".data(using: .utf8)!
        
        // Set the API session to nil first:
        request?.apiSession = nil
        
        // Assert current URL request:
        XCTAssertNotNil(request, "could not create the request.")
        XCTAssertEqual(request?.preparedURLRequest.url?.absoluteString, "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm?market=US")
        XCTAssertNil(request?.preparedURLRequest.value(forHTTPHeaderField: "Authorization"), "the URL request's \"Authorizaton\" field should be empty.")
        XCTAssertNil(request?.preparedURLRequest.value(forHTTPHeaderField: "Content-Type"), "the URL request's \"Content-Type\" field should be empty.")
        XCTAssertNil(request?.preparedURLRequest.httpBody, "the URL request's HTTP body should be empty.")
        
        // Reset the API session:
        request?.apiSession = SPTAuth.defaultInstance().session

        // Assert updated URL request:
        XCTAssertEqual(request?.preparedURLRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(SPTAuth.defaultInstance().session.accessToken!)")
        
        // Set multipart request body:
        request?.addMultipartData(requestBody, type: .json)
        
        // Assert updated URL request:
        XCTAssertEqual(request?.preparedURLRequest.httpBody, requestBody)
        XCTAssertEqual(request?.preparedURLRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testValidResponse() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let request = SKRequest(method: .GET, endpoint: endpoint)!
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Act:
        request.perform { [unowned self] (data, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let data = data else {
                XCTFail("'data' is nil."); return
            }
            
            do {
                let album = try SKAlbum(from: data)
                XCTAssertEqual(album.id, "5DLhV9yOvZ7IxVmljMXtNm")
            } catch {
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Album.json", payload: data))
                XCTFail("could not initialize the SpotifyKit object from the given data. \(error.localizedDescription)")
            }
        }
    }
    
    func testInvalidResponse() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let request = SKRequest(method: .GET, endpoint: endpoint)!
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Give the request an invalid API session/access token:
        request.apiSession = SPTSession(userName: "haversnail",
                                         accessToken: "something-that-isnt-valid",
                                         expirationDate: Date.distantFuture)
        
        // Act:
        request.perform { [unowned self] (data, error) in
            defer { promise.fulfill() }

            // Assert:
            XCTAssertNotNil(error, "'error' is not supposed to be nil.")
            
            if let data = data {
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Payload.json", payload: data))
                XCTFail("'data' is supposed to be nil.")
            }
            guard let error = error as? SKError else {
                XCTFail("error object is supposed to be of type 'SKError'"); return
            }
            
            XCTAssertEqual(error.status, .unauthorized)
        }
    }
    
    // MARK: - Request Factory Tests
    
    func testSearchRequest() {
        
        // Arrange:
        let formatter = ISO8601DateFormatter()
        let startDate = formatter.date(from: "2010-05-05T09:30:00Z")!
        let endDate = formatter.date(from: "2017-06-05T09:30:00Z")!
        let filters: Set<SKSearchFieldFilter> = [
            .genre("soundtrack"), // Should not be added to the query, since we'll only be requesting albums and playlists ("genre" applies to artists/tracks).
            .year(DateInterval(start: startDate, end: endDate)),
//            .upc("1234"),
//            .isrc("abcd"),
//            .tag(.hipster),
//            .tag(.new)
        ]
        let page = PageParameters(limit: 3)
        
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        let request = catalog.makeSearchRequest(types: [.albums, .playlists],
                                                keywords: "Game of",
                                                alternate: "",
                                                unwanted: "Thrones",
                                                inOrder: true,
                                                filters: filters,
                                                page: page)
        
        // Assert request:
        assertRequest(request, contains: "q=%22game+of%22+NOT+thrones+year:2010-2017", "type=album,playlist", "market=US", "limit=3")
        
        // Act:
        catalog.search(for: [.albums, .playlists], matching: "Game of", excluding: "Thrones", inOrder: true, filteredBy: filters, page: page) { (results, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let results = results else {
                XCTFail("'results' is nil."); return
            }
            
            XCTAssertNotNil(results.albums, "results should have contained album objects.")
            XCTAssertNotNil(results.playlists, "results should have contained playlist objects.")
            XCTAssertNil(results.artists, "results should not have contained artist objects.")
            XCTAssertNil(results.tracks, "results should not have contained track objects.")
            
            guard let albums = results.albums else { return }
            
            for album in albums {
                //print(album.name)
                XCTAssert(album.name.localizedCaseInsensitiveContains("game of"), "one or more albums does not contain the expected keywords.")
                XCTAssert(!album.name.localizedCaseInsensitiveContains("thrones"), "one or more albums contains unwanted keywords.")
            }
        }
    }
    
    func testSPTSessionMethods() {
        
        // Arrange:
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        let session = SPTAuth.defaultInstance().session!
        let promise = makeRequestExpectation()
        promise.expectedFulfillmentCount = 2 // Make sure both requests finish successfully.
        defer { wait(for: promise) }
        
        let handler: SKRequestHandler = { [unowned self] (data, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let data = data else {
                XCTFail("'data' is nil."); return
            }
            
            do {
                let album = try SKAlbum(from: data)
                XCTAssertEqual(album.id, "5DLhV9yOvZ7IxVmljMXtNm")
            } catch {
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Album.json", payload: data))
                XCTFail("could not initialize the SpotifyKit object from the given data. \(error.localizedDescription).")
            }
        }
        
        // Act:
        session.performRequest(method: .GET, url: url, handler: handler)
        session.performRequest(method: .GET, endpoint: url.path, handler: handler)
    }
    
    func testExpandableRequest() {
        
        // Arrange:
        let artist = try! SKArtist(from: simplifiedArtistData)
        let request = artist.makeFullObjectRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url, artist.url)
        
        // Act:
        artist.getFullObject { (artist, error) in
            defer { promise.fulfill() }

            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artist = artist else {
                XCTFail("'artist' is nil."); return
            }
            
            XCTAssertNotNil(artist.popularity, "property should contain a non-nil value.")
        }
    }
    
    // MARK: - Album Requests
    
    func testGetAlbum() {
        
        // Arrange:
        let albumID = "5DLhV9yOvZ7IxVmljMXtNm"
        let request = catalog.makeAlbumRequest(id: albumID)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/albums/\(albumID)")
        XCTAssertEqual(request.preparedURLRequest.url?.query, "market=US")
        
        // Act (using public convenience method):
        catalog.getAlbum(withID: albumID) { (album, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let album = album else {
                XCTFail("'album' is nil."); return
            }
            
            XCTAssertEqual(album.id, albumID)
        }
    }
    
    func testGetSeveralAlbums() {
        
        // Arrange:
        let albumIDs = ["5DLhV9yOvZ7IxVmljMXtNm","ABCm9wqX2AAeZNV3kdxXYZ","790mhPtbtIdMDRdZM3Jimz"] // Middle ID does not exist.
        let request = catalog.makeAlbumsRequest(ids: albumIDs)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/albums", "ids=5DLhV9yOvZ7IxVmljMXtNm,ABCm9wqX2AAeZNV3kdxXYZ,790mhPtbtIdMDRdZM3Jimz", "market=US")
        
        // Act:
        catalog.getAlbums(withIDs: albumIDs) { (albums, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let albums = albums else {
                XCTFail("'albums' is nil."); return
            }
            
            XCTAssertEqual(albums.count, 3)
            XCTAssertEqual(albums[0]?.id, "5DLhV9yOvZ7IxVmljMXtNm")
            XCTAssertEqual(albums[2]?.id, "790mhPtbtIdMDRdZM3Jimz")
            XCTAssertNil(albums[1], "middle value should have been nil - the corresponding ID didn't exist.")
        }
    }
    
    // MARK: - Artist Requests
    
    func testGetArtist() {
        
        // Arrange:
        let artistID = "6VDdCwrBM4qQaGxoAyxyJC"
        let request = catalog.makeArtistRequest(id: artistID)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artistID)")
        
        // Act:
        catalog.getArtist(withID: artistID) { (artist, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artist = artist else {
                XCTFail("'artist' is nil."); return
            }
            
            XCTAssertEqual(artist.id, artistID)
        }
    }
    
    func testGetSeveralArtists() {
        
        // Arrange:
        let artistIDs = ["6VDdCwrBM4qQaGxoAyxyJC","ABCm9wqX2AAeZNV3kdxXYZ","53XhwfbYqKCa1cC15pYq2q"] // Middle ID does not exist.
        let request = catalog.makeArtistsRequest(ids: artistIDs)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists")
        XCTAssertEqual(request.preparedURLRequest.url?.query, "ids=6VDdCwrBM4qQaGxoAyxyJC,ABCm9wqX2AAeZNV3kdxXYZ,53XhwfbYqKCa1cC15pYq2q")
        
        // Act:
        catalog.getArtists(withIDs: artistIDs) { (artists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artists = artists else {
                XCTFail("'artists' is nil."); return
            }
            
            XCTAssertEqual(artists.count, 3)
            XCTAssertEqual(artists[0]?.id, "6VDdCwrBM4qQaGxoAyxyJC")
            XCTAssertEqual(artists[2]?.id, "53XhwfbYqKCa1cC15pYq2q")
            XCTAssertNil(artists[1], "middle value should have been nil - the corresponding ID didn't exist.")
        }
    }
    
    func testGetAlbumsForArtist() {

        // Arrange:
        let artist = try! SKArtist(from: artistData)
        let locale = Locale(identifier: "en_US")
        let page = PageParameters(limit: 3, page: 2)
        let request = artist.makeAlbumsRequest(types: [.album, .single], locale: locale, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }

        // Assert request:
        assertRequest(request, contains: "/v1/artists/\(artist.id)/albums", "album_type=album,single", "market=US", "offset=3", "limit=3")

        // Act:
        artist.getAlbums(filteredBy: [.album, .single], for: locale, page: page) { (albums, error) in
            defer { promise.fulfill() }

            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let albums = albums else {
                XCTFail("'albums' is nil."); return
            }

            XCTAssertEqual(albums.limit, 3)
            XCTAssertEqual(albums.offset, 3)
        }
    }

    func testGetTopTracksForArtist() {

        // Arrange:
        let artist = try! SKArtist(from: artistData)
        let locale = Locale(identifier: "en_US")
        let request = artist.makeTopTracksRequest(locale: locale)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }

        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artist.id)/top-tracks")
        XCTAssertEqual(request.preparedURLRequest.url?.query, "country=US")

        // Act:
        artist.getTopTracks(for: locale) { (tracks, error) in
            defer { promise.fulfill() }

            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let tracks = tracks else {
                XCTFail("'tracks' is nil."); return
            }

            XCTAssertEqual(tracks[0].artists[0].name, artist.name)
        }
    }

    func testGetRelatedArtistsForArtist() {

        // Arrange:
        let artist = try! SKArtist(from: artistData)
        let request = artist.makeRelatedArtistsRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }

        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artist.id)/related-artists")

        // Act:
        artist.getRelatedArtists { (artists, error) in
            defer { promise.fulfill() }

            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = artists else {
                XCTFail("'artists' is nil."); return
            }

            //for artist in artists { print(artist.name) }
        }
    }
    
    // MARK: - Audio Features Requests
    
    func testGetAudioFeaturesForTrack() {
        
        // Arrange:
        let track = try! SKTrack(from: trackData)
        let request = track.makeAudioFeaturesRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/audio-features/\(track.id)")
        
        // Act:
        track.getAudioFeatures { (features, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let features = features else {
                XCTFail("'features' was nil."); return
            }
            
            XCTAssertEqual(features.uri, track.uri)
        }
    }
    
    func testGetAudioFeaturesForSeveralTracks() {
        
        // Arrange:
        let tracks = try! [SKTrack](from: trackArrayData)
        let request = tracks.makeAudioFeaturesRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/audio-features")
        XCTAssertEqual(request.preparedURLRequest.url?.query, "ids=53L6A3I9vf7rgEZnMzx54E,7FESgYLcOufHqKlwrvJN60,7g1YqCZblmFepoevFFVP7t")
        
        // Act:
        tracks.getAudioFeatures { (features, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let features = features else {
                XCTFail("'features' was nil."); return
            }
            
            XCTAssert(features.contains { $0 != nil }, "no 'features' object should be nil - request contained valid track IDs.")
            XCTAssertEqual(features.map { $0!.uri }, tracks.map { $0.uri })
        }
    }
    
    // MARK: - Browse Requests
    
    func testGetFeaturedPlaylists() {
        
        // Arrange:
        let page = PageParameters(limit: 1)
        let date = ISO8601DateFormatter().date(from: "2017-09-16T21:45:00Z")!
        let request = catalog.makeFeaturedPlaylistsRequest(date: date, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/browse/featured-playlists", "locale=en_US", "country=US", "timestamp=2017-09-16T21:45:00Z", "limit=1")
        
        // Act:
        catalog.getFeaturedPlaylists(for: date, page: page) { (lists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let lists = lists else {
                XCTFail("'lists' was nil."); return
            }
            
            XCTAssertEqual(lists.localizedMessage, "Party Time")
            XCTAssertEqual(lists.playlists[0].name, "Fight Night")
        }
    }
    
    func testGetNewReleases() {
        
        // Arrange:
        let page = PageParameters(limit: 5)
        let request = catalog.makeNewReleasesRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/browse/new-releases", "country=US", "limit=5") // FIXME: Refactor this method to test for exactly these strings—not more or less.
        
        // Act:
        catalog.getNewReleases(page: page) { (albums, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = albums else {
                XCTFail("'albums' was nil."); return
            }
            
            //for album in albums { print(album.name + " -- " + album.artists[0].name) }
        }
    }
    
    func testGetCategories() {
        
        // Arrange:
        let page = PageParameters(limit: 5)
        let request = catalog.makeCategoriesRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/browse/categories", "locale=en_US", "country=US", "limit=5")
        
        // Act:
        catalog.getCategories(page: page) { (categories, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = categories else {
                XCTFail("'categories' was nil."); return
            }
            
            //for category in categories { print(category.name, "(\(category.id))") }
        }
    }
    
    func testGetCategory() {
        
        // Arrange:
        let categoryID = "indie_alt"
        let request = catalog.makeCategoryRequest(id: categoryID)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/browse/categories/\(categoryID)")
        
        // Act:
        catalog.getCategory(withID: categoryID) { (category, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let category = category else {
                XCTFail("'category' was nil."); return
            }
            
            XCTAssertEqual(category.id, categoryID)
        }
    }
    
    func testGetPlaylistsForCategory() {
        
        // Arrange:
        let category = try! SKCategory(from: categoryData)
        let page = PageParameters(limit: 5)
        let request = category.makePlaylistsRequest(locale: catalog.locale, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/browse/categories/\(category.id)/playlists", "country=US", "limit=5")
        
        // Act:
        category.getPlaylists(for: catalog.locale, page: page) { (playlists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = playlists else {
                XCTFail("'playlists' was nil."); return
            }
            
            //for playlist in playlists { print(playlist.name) }
        }
    }
    
    func testGetAvailableGenres() {
        
        // Arrange:
        let request = catalog.makeAvailableGenresRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/recommendations/available-genre-seeds")
        
        // Act:
        catalog.getAvailableGenres { (genres, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = genres else {
                XCTFail("'genres' was nil."); return
            }
            
            //for genre in genres { print(genre) }
        }
        
    }
    
    func testGetRecommendations() {
        
        // Arrange:
        let genres = ["alt-rock", "indie"]
        let tracks = [try! SKTrack(from: trackData)]
        let artists = [try! SKArtist(from: artistData)]
        let attributes: Set<SKTrackAttribute> = [
            .tempo(min: nil, max: nil, target: 120),
            .valence(min: 0.5, max: 1, target: nil),
            .duration(min: nil, max: 240, target: nil)
        ]
        let request = catalog.makeRecommendationsRequest(genres: genres, artists: artists, tracks: tracks, attributes: attributes, limit: 5)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        assertRequest(request, contains: "/v1/recommendations",
                                         "seed_genres=alt-rock,indie",
                                         "seed_artists=\(artists[0].id)",
                                         "seed_tracks=\(tracks[0].id)",
                                         "max_duration_ms=240000",
                                         "target_tempo=120.0",
                                         "min_valence=0.5",
                                         "max_valence=1.0")
        
        // Act:
        catalog.getRecommendationsBasedOn(genres: genres, artists: artists, tracks: tracks, filteredBy: attributes, limit: 5) { (recommendations, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let recommendations = recommendations else {
                XCTFail("'recommendations' was nil."); return
            }
            
            XCTAssertEqual(recommendations.tracks.count, 5)
            
            let genreSeeds = recommendations.seeds.filter { $0.type == .genre }.map { $0.id }
            let artistSeeds = recommendations.seeds.filter { $0.type == .artist }.map { $0.id }
            let trackSeeds = recommendations.seeds.filter { $0.type == .track }.map { $0.id }
            
            for genre in genres {
                XCTAssert(genreSeeds.contains(genre), "expected to find \(genre) in genre seeds: \(genreSeeds.joined(separator: ", "))")
            }
            for artist in artists {
                XCTAssert(artistSeeds.contains(artist.id), "expected to find \(artist) in artist seeds: \(artistSeeds.joined(separator: ", "))")
            }
            for track in tracks {
                XCTAssert(trackSeeds.contains(track.id), "expected to find \(track) in track seeds: \(trackSeeds.joined(separator: ", "))")
            }
            
            //for track in recommendations.tracks { print(track.name, " -- ", track.artists[0].name) }
        }
    }
    
    // MARK: - User Requests
    
    func testGetUser() {
        
        // Arrange:
        let userID = "ahavermale"
        let request = SKUser.makeUserRequest(id: userID)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/users/\(userID)")
        
        // Act:
        SKUser.getUser(withID: userID) { (user, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let user = user else {
                XCTFail("'user' was nil."); return
            }
            
            XCTAssertEqual(user.id, userID)
        }
    }
    
    func testGetCurrentUser() {
        
        // Arrange:
        let username = SPTAuth.defaultInstance().session.canonicalUsername!
        let request = SKUser.makeCurrentUserRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/me")
        
        // Act:
        SKUser.getCurrentUser { (user, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let user = user else {
                XCTFail("'user' was nil."); return
            }
            
            XCTAssertEqual(user.id, username)
        }
    }
}
