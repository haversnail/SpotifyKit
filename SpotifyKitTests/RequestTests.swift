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
        ///
        /// You can request a token through the Web API Console [here](https://developer.spotify.com/web-api/console/get-current-user/token?scope=user-read-private&scope=user-read-birthdate&scope=user-read-email&scope=playlist-read-private&scope=playlist-read-collaborative&scope=playlist-modify-public&scope=playlist-modify-private&scope=user-library-read&scope=user-library-modify&scope=user-follow-read&scope=user-follow-modify&scope=user-top-read&scope=user-read-playback-state&scope=user-read-recently-played&scope=user-read-currently-playing&scope=user-modify-playback-state&scope=ugc-image-upload).
        let accessToken = "BQD3bNcaYRtPT-g3eE8ndd7n-an4A0iVoMqGLtn1SeqEy-79XKzrM414MAnIrmF5X9Ae3qnNhBKuSTBa39Lmbm4uedBtE1tDxxKwKS_nl2bvBVRoL2IwG2y8QrLcJJ7x1pqwtXpaTRj0gG2DtlgKyhSbB701X8ixKsRoe7KYDyo_GGXBrahqieTfaVIF_u8PT8hmv2w9QXLXjOfmlNYUlERS_8jZwjsF1fxs_43s8SW84-3dnNaK683liJsUbA1WAsH5GqSltxxRJdecDozLE8YMAiD0jYiSjJ3hJ8zQEooWK5vLhg6Y-4XLeRUaC5w7DtmGyvysN8Z8"
        
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
    
    func decode<T: JSONDecodable>(_ type: T.Type, from request: SKRequest, file: StaticString = #file, line: UInt = #line) -> T? {
        
        guard let data = request.requestBody?.data else {
            XCTFail("the request does not contain multipart body data.", file: file, line: line)
            return nil
        }
        
        do {
            return try type.init(from: data)
        } catch {
            let message = """
                the request body could not be decoded to the given type:
                \(error.localizedDescription)
                \(String(data: data, encoding: .utf8) ?? "The data could not be decoded to a string.")
                """
            
            XCTFail(message, file: file, line: line)
            return nil
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
        request.perform { [unowned self] (data, status, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard status == .ok else {
                XCTFail("HTTP status code is not OK."); return
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
        request.perform { [unowned self] (data, status, error) in
            defer { promise.fulfill() }

            // Assert:
            XCTAssertNotNil(error, "'error' is not supposed to be nil.")
            
            if let data = data {
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Payload.json", payload: data))
                XCTFail("'data' is supposed to be nil.")
            }
            guard status == .unauthorized else {
                XCTFail("HTTP status code is supposed to be '.unauthorized'"); return
            }
            guard let error = error as? SKError else {
                XCTFail("error object is supposed to be of type 'SKError'"); return
            }
            
            XCTAssertEqual(error.status, .unauthorized)
        }
    }
    
    // MARK: - Request Extension Tests
    
    func testSPTSessionMethods() {
        
        // Arrange:
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        let session = SPTAuth.defaultInstance().session!
        let promise = makeRequestExpectation()
        promise.expectedFulfillmentCount = 2 // Make sure both requests finish successfully.
        defer { wait(for: promise) }
        
        let handler: SKRequestHandler = { [unowned self] (data, status, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard status == .ok else {
                XCTFail("HTTP status code is not OK."); return
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
        XCTAssertEqual(request.url.path, "/v1/albums")
        SKTAssertQuery(in: request, contains: "ids=5DLhV9yOvZ7IxVmljMXtNm,ABCm9wqX2AAeZNV3kdxXYZ,790mhPtbtIdMDRdZM3Jimz", "market=US")
        
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
        let page = Pagination(limit: 3, page: 2)
        let request = artist.makeAlbumsRequest(types: [.album, .single], locale: locale, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }

        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artist.id)/albums")
        SKTAssertQuery(in: request, contains: "album_type=album,single", "market=US", "offset=3", "limit=3")

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
    
    // MARK: - Track Requests
    
    func testGetTrack() {
        
        // Arrange:
        let trackID = "0kwuKfWntoGh0EWyYb7Mpf"
        let request = catalog.makeTrackRequest(id: trackID)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/tracks/\(trackID)")
        XCTAssertEqual(request.preparedURLRequest.url?.query, "market=US")
        
        // Act:
        catalog.getTrack(withID: trackID) { (track, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let track = track else {
                XCTFail("'track' was nil."); return
            }
            
            XCTAssertEqual(track.id, trackID)
            XCTAssertEqual(track.name, "Stranger Things")
        }
    }
    
    func testGetSeveralTracks() {
        
        // Arrange:
        let trackIDs = ["7gBj0VgcuAgkXkiRRYvSmK","ABCm9wqX2AAeZNV3kdxXYZ","4uNDs2TBsv2KX9b4LIxfdt"] // Middle ID does not exist.
        let request = catalog.makeTracksRequest(ids: trackIDs)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/tracks")
        SKTAssertQuery(in: request, contains: "ids=7gBj0VgcuAgkXkiRRYvSmK,ABCm9wqX2AAeZNV3kdxXYZ,4uNDs2TBsv2KX9b4LIxfdt", "market=US")
        
        // Act:
        catalog.getTracks(withIDs: trackIDs) { (tracks, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let tracks = tracks else {
                XCTFail("'tracks' is nil."); return
            }
            
            XCTAssertEqual(tracks.count, 3)
            XCTAssertEqual(tracks[0]?.id, "7gBj0VgcuAgkXkiRRYvSmK")
            XCTAssertEqual(tracks[2]?.id, "4uNDs2TBsv2KX9b4LIxfdt")
            XCTAssertNil(tracks[1], "middle value should have been nil - the corresponding ID didn't exist.")
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
        let page = Pagination(limit: 1)
        let date = ISO8601DateFormatter().date(from: "2017-09-16T21:45:00Z")!
        let request = catalog.makeFeaturedPlaylistsRequest(date: date, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/browse/featured-playlists")
        SKTAssertQuery(in: request, contains: "locale=en_US", "country=US", "timestamp=2017-09-16T21:45:00Z", "limit=1")
        
        // Act:
        catalog.getFeaturedPlaylists(for: date, page: page) { (lists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = lists else {
                XCTFail("'lists' was nil."); return
            }
            
//            XCTAssertEqual(lists.localizedMessage, "Party Time")
//            XCTAssertEqual(lists.playlists[0].name, "Fight Night")
        }
    }
    
    func testGetNewReleases() {
        
        // Arrange:
        let page = Pagination(limit: 5)
        let request = catalog.makeNewReleasesRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/browse/new-releases")
        SKTAssertQuery(in: request, contains: "country=US", "limit=5")
        
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
        let page = Pagination(limit: 5)
        let request = catalog.makeCategoriesRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/browse/categories")
        SKTAssertQuery(in: request, contains: "locale=en_US", "country=US", "limit=5")
        
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
        let page = Pagination(limit: 5)
        let request = category.makePlaylistsRequest(locale: catalog.locale, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/browse/categories/\(category.id)/playlists")
        SKTAssertQuery(in: request, contains: "country=US", "limit=5")
        
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
        XCTAssertEqual(request.url.path, "/v1/recommendations")
        SKTAssertQuery(in: request, contains: "seed_genres=alt-rock,indie",
                                               "seed_artists=\(artists[0].id)",
                                               "seed_tracks=\(tracks[0].id)",
                                               "max_duration_ms=240000",
                                               "target_tempo=120.0",
                                               "min_valence=0.5",
                                               "max_valence=1.0",
                                               "market=US",
                                               "limit=5")
        
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
    
    // MARK: - Search Requests
    
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
        let page = Pagination(limit: 3)
        
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        let request = catalog.makeSearchRequest(types: [.albums, .playlists],
                                                keywords: "Game of",
                                                alternate: nil,
                                                unwanted: "Thrones",
                                                inOrder: true,
                                                filters: filters,
                                                page: page)
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/search")
        SKTAssertQuery(in: request, contains: "q=%22game+of%22+NOT+thrones+year:2010-2017",
                                               "type=album,playlist",
                                               "market=US",
                                               "limit=3")
        
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
        let request = SKCurrentUser.makeCurrentUserRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/me")
        
        // Act:
        SKCurrentUser.getCurrentUser { (user, error) in
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
    
    func testGetPlaylistsForUser() {
        
        // Arrange:
        let user = try! SKUser(from: userData)
        let page = Pagination(limit: 3)
        let request = user.makePlaylistsRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/users/\(user.id)/playlists")
        SKTAssertQuery(in: request, contains: "limit=3")
        
        // Act:
        user.getPlaylists(page: page) { (playlists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let playlists = playlists else {
                XCTFail("'playlists' was nil."); return
            }
            
            XCTAssertEqual(playlists.count, page.limit)
        }
    }
    
    func testGetPlaylistsForCurrentUser() {
        
        // Arrange:
        let user = try! SKCurrentUser(from: currentUserData)
        let page = Pagination(limit: 3)
        let request = user.makePlaylistsRequest(page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/me/playlists")
        SKTAssertQuery(in: request, contains: "limit=3")
        
        // Act:
        user.getPlaylists(page: page) { (playlists, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let playlists = playlists else {
                XCTFail("'playlists' was nil."); return
            }
            
            XCTAssertEqual(playlists.count, page.limit)
        }
    }
    
    // MARK: - Playlist Requests
    
    func testCreatePlaylist() {
        
        // Arrange:
        let userID = SPTAuth.defaultInstance().session.canonicalUsername!
        let name = "My Test Playlist"
        let description = "A test playlist auto-generated by SpotifyKit."
        let request = SKPlaylist.makeNewPlaylistRequest(userID: userID, name: name, description: description, isPublic: false, isCollaborative: false)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .POST)
        XCTAssertEqual(request.url.path, "/v1/users/\(userID)/playlists")
        
        guard let body = decode(Constants.RequestBodies.PlaylistDetailsBody.self, from: request) else { return }
        XCTAssertEqual(body.name, name)
        XCTAssertEqual(body.description, description)
        XCTAssertEqual(body.isPublic, false)
        XCTAssertEqual(body.isCollaborative, false)
        
        // Act:
        SKPlaylist.createPlaylist(named: name, description: description, isPublic: false, isCollaborative: false) { (playlist, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let playlist = playlist else {
                XCTFail("'playlist' was nil."); return
            }
            
            XCTAssertEqual(playlist.name, name)
            XCTAssertEqual(playlist.userDescription, description)
            XCTAssertEqual(playlist.isPublic, false)
            XCTAssertEqual(playlist.isCollaborative, false)
            
//            // Delete playlist here... if functionality ever becomes available:
//            addTeardownBlock {
//                playlist.delete()
//            }
        }
        
//        // Attach JSON data:
//        request.perform { [unowned self] (data, error) in
//
//            if let data = data {
//                let attachment = XCTAttachment(data: data)
//                attachment.name = "Playlist.json"
//                attachment.lifetime = .keepAlways
//                self.add(attachment)
//            }
//        }
    }
    
    func testUpdatePlaylistDetails() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let description = "A playlist under test by the SpotifyKit framework."
        let request = playlist.makeUpdateDetailsRequest(name: nil, description: description, isPublic: nil, isCollaborative: nil)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)")
        
        guard let body = decode(Constants.RequestBodies.PlaylistDetailsBody.self, from: request) else { return }
        XCTAssertEqual(body.name, nil)
        XCTAssertEqual(body.description, description)
        XCTAssertEqual(body.isPublic, nil)
        XCTAssertEqual(body.isCollaborative, nil)
        
        // Act:
        playlist.update(description: description) { (error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
        }
    }
    
    func testUpdatePlaylistImage() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let image: UIImage = {
            let testBundle = Bundle(for: type(of: self))
            return UIImage(named: "cover-alt", in: testBundle, compatibleWith: nil)!
        }()
        let data = UIImageJPEGRepresentation(image, 0.8)!.base64EncodedData()
        let request = playlist.makeUpdateImageRequest(data: data)
        let promise = makeRequestExpectation()
        promise.expectedFulfillmentCount = 2
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/images")
        XCTAssertEqual(request.requestBody!.data, data)
        
        // Act:
        playlist.updateImage(with: image) { (error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
        }
        
        // Act, testing oversized image data:
        playlist.updateImage(with: image, quality: 1.0) { (error) in
            defer { promise.fulfill() }
            
            // Assert results:
            guard let error = error as? SKError else {
                XCTFail("request should have generated an error due to the image exceeding the maximum file size."); return
            }
            
            XCTAssertEqual(error.status, .badRequest)
        }
    }
    
    func testAddTracksToPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let tracks = try! [SKTrack](from: trackArrayData)
        let request = playlist.makeAddTracksRequest(tracks: tracks, position: 0)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .POST)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/tracks")
        SKTAssertQuery(in: request, contains: "uris=\(tracks.map { $0.uri }.joined(separator: ","))",
                                              "position=0")
        
        // Act:
        playlist.add(tracks, at: 0) { (snapshotID, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = snapshotID else {
                XCTFail("'snapshotID' was nil."); return
            }
            
            //print(snapshotID)
        }
    }
    
    func testRemoveTracksFromPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let request = playlist.makeRemoveTracksRequest(positions: [0], snapshotID: nil)
        let promise = makeRequestExpectation()
        promise.expectedFulfillmentCount = 2
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .DELETE)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/tracks")
        
        guard let body = decode(Constants.RequestBodies.RemoveTracksBody.self, from: request) else { return }
        XCTAssertNil(body.tracks)
        XCTAssertNil(body.snapshotID)
        XCTAssertEqual(body.positions?[0], 0)
        
        // Act:
        playlist.remove(at: 0) { (snapshotID, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = snapshotID else {
                XCTFail("'snapshotID' was nil."); return
            }
        
            //XCTAssertEqual(snapshotID, playlist.snapshotID)
        }
        
        // Arrange:
        guard let track = playlist.tracks?.last else { return }
        let request2 = playlist.makeRemoveTracksRequest(tracks: [track], snapshotID: nil)
        
        // Assert request body:
        guard let body2 = decode(Constants.RequestBodies.RemoveTracksBody.self, from: request2) else { return }
        XCTAssertEqual(body2.tracks?[0].uri, track.uri)
        XCTAssertNil(body2.snapshotID)
        XCTAssertNil(body2.positions)
        
        playlist.removeOccurrences(of: track) { (snapshotID, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = snapshotID else {
                XCTFail("'snapshotID' was nil."); return
            }
            
            //print(snapshotID)
        }
    }
    
    func testReorderTracksInPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let endIndex = playlist.totalTracks
        let request = playlist.makeMoveTracksRequest(startIndex: 0, rangeLength: 2, position: endIndex, snapshotID: nil)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/tracks")
        
        guard let body = decode(Constants.RequestBodies.ReorderTracksBody.self, from: request) else { return }
        XCTAssertEqual(body.startIndex, 0)
        XCTAssertEqual(body.rangeLength, 2)
        XCTAssertEqual(body.newIndex, endIndex)
        XCTAssertEqual(body.snapshotID, nil)
        
        // Act:
        playlist.move(at: 0...2, before: endIndex) { (snapshotID, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = snapshotID else {
                XCTFail("'snapshotID' was nil."); return
            }
            
            //print(snapshotID)
        }
    }
    
    func testReplaceTracksInPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let tracks = playlist.tracks!
        let request = playlist.makeReplaceTracksRequest(tracks: tracks)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/tracks")
        SKTAssertQuery(in: request, contains: "uris=\(tracks.map { $0.uri }.joined(separator: ","))")
        
        // Act:
        playlist.replace(with: tracks) { (snapshotID, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let _ = snapshotID else {
                XCTFail("'snapshotID' was nil."); return
            }
            
            //print(snapshotID)
        }
    }
    
    func testGetTracksForPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: ephemeralPlaylistData) // FIXME: Update JSON data to match your test playlist.
        let page = Pagination(limit: 5)
        let request = playlist.makeTracksRequest(locale: catalog.locale, page: page)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/tracks")
        SKTAssertQuery(in: request, contains: "market=US", "limit=5")
        
        // Act:
        playlist.getTracks(for: catalog.locale, page: page) { (tracks, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let tracks = tracks else {
                XCTFail("'tracks' was nil."); return
            }
            
            for track in tracks { print(track.name) }
        }
    }
    
    // MARK: - Follow Requests
    
    func testFollowArtists() {
        
        // Arrange:
        let artists = try! [SKArtist](from: artistArrayData)
        let request = artists.makeFollowRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/me/following")
        SKTAssertQuery(in: request, contains: "type=artist", "ids=\(artists.map { $0.id }.joined(separator: ","))")
        
        // Act:
        artists.follow { (error) in
            
            // Assert result:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            
            let request = artists.makeFollowStatusRequest()
            XCTAssertEqual(request.method, .GET)
            XCTAssertEqual(request.url.path, "/v1/me/following/contains")
            SKTAssertQuery(in: request, contains: "type=artist", "ids=\(artists.map { $0.id }.joined(separator: ","))")
            
            artists.checkIfFollowing { (isFollowing, error) in
                defer { promise.fulfill() }
                
                if let error = error {
                    XCTFail(error.localizedDescription); return
                }
                guard let isFollowing = isFollowing else {
                    XCTFail("'isFollowing' was nil."); return
                }
                
                XCTAssertEqual(isFollowing.count, 2)
                XCTAssertTrue(isFollowing[0])
                XCTAssertTrue(isFollowing[1])
            }
        }
    }
    
    func testFollowUser() {
        
        // Arrange:
        let user = try! SKUser(from: userData)
        let request = user.makeFollowRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/me/following")
        SKTAssertQuery(in: request, contains: "type=user", "ids=\(user.id)")
        
        // Act:
        user.follow { (error) in
            
            // Assert result:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            
            let request = user.makeFollowStatusRequest()
            XCTAssertEqual(request.method, .GET)
            XCTAssertEqual(request.url.path, "/v1/me/following/contains")
            SKTAssertQuery(in: request, contains: "type=user", "ids=\(user.id)")
            
            user.checkIfFollowing { (isFollowing, error) in
                defer { promise.fulfill() }

                if let error = error {
                    XCTFail(error.localizedDescription); return
                }
                guard let isFollowing = isFollowing else {
                    XCTFail("'isFollowing' was nil."); return
                }
                
                XCTAssertTrue(isFollowing)
            }
        }
    }
    
    func testUnfollowArtists() {
        
        // Arrange:
        let artists = try! [SKArtist](from: artistArrayData)
        let request = artists.makeUnfollowRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .DELETE)
        XCTAssertEqual(request.url.path, "/v1/me/following")
        SKTAssertQuery(in: request, contains: "type=artist", "ids=\(artists.map { $0.id }.joined(separator: ","))")
        
        // Act:
        artists.unfollow { (error) in
            
            // Assert result:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            
            artists.checkIfFollowing { (isFollowing, error) in
                defer { promise.fulfill() }
                
                if let error = error {
                    XCTFail(error.localizedDescription); return
                }
                guard let isFollowing = isFollowing else {
                    XCTFail("'isFollowing' was nil."); return
                }
                
                XCTAssertEqual(isFollowing.count, 2)
                XCTAssertFalse(isFollowing[0])
                XCTAssertFalse(isFollowing[1])
            }
        }
    }
    
    func testUnfollowUser() {
        
        // Arrange:
        let user = try! SKUser(from: userData)
        let request = user.makeUnfollowRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .DELETE)
        XCTAssertEqual(request.url.path, "/v1/me/following")
        SKTAssertQuery(in: request, contains: "type=user", "ids=\(user.id)")
        
        // Act:
        user.unfollow { (error) in
            
            // Assert result:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            
            user.checkIfFollowing { (isFollowing, error) in
                defer { promise.fulfill() }
                
                if let error = error {
                    XCTFail(error.localizedDescription); return
                }
                guard let isFollowing = isFollowing else {
                    XCTFail("'isFollowing' was nil."); return
                }
                
                XCTAssertFalse(isFollowing)
            }
        }
    }
    
    func testFollowPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: playlistData)
        let request = playlist.makeFollowRequest(public: false)
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .PUT)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/followers")
        
        guard let body = decode(Constants.RequestBodies.PlaylistFollowBody.self, from: request) else { return }
        XCTAssertEqual(body.isPublic, false)
        
        // Act:
        playlist.follow { (error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
        }
    }
    
    func testUnfollowPlaylist() {
        
        // Arrange:
        let playlist = try! SKPlaylist(from: playlistData)
        let request = playlist.makeUnfollowRequest()
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .DELETE)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/followers")
        
        // Act:
        playlist.unfollow { (error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
        }
        
        // Re-follow playlist when test concludes:
        addTeardownBlock {
            playlist.follow { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func testIfUsersFollowPlaylist() {
        
        // Arrange:
        let user = try! SKUser(from: userData)
        let playlist = try! SKPlaylist(from: playlistData)
        let request = playlist.makeFollowStatusRequest(users: [user])
        let promise = makeRequestExpectation()
        defer { wait(for: promise) }
        
        // Assert request:
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.url.path, "/v1/users/\(playlist.owner.id)/playlists/\(playlist.id)/followers/contains")
        SKTAssertQuery(in: request, contains: "ids=\(user.id)")
        
        // Act:
        playlist.checkIfFollowed(by: [user]) { (isFollowing, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let isFollowing = isFollowing else {
                XCTFail("'isFollowing' was nil."); return
            }
            
            XCTAssertEqual(isFollowing.count, 1)
            XCTAssertFalse(isFollowing[0])
        }
    }
    
    // MARK: - Expandable Requests
    
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
}

// MARK: - Request Test Assertions

/// Asserts that an `SKRequest` instance contains the specified URL query strings.
///
/// - Parameters:
///   - request: The `SKRequest` instance under test.
///   - items: The URL query strings against which to compare.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
func SKTAssertQuery(in request: SKRequest, contains items: String..., file: StaticString = #file, line: UInt = #line) {
    
    guard let url = request.preparedURLRequest.url else {
        XCTFail("the prepared URL request contains no URL.", file: file, line: line); return
    }
    
    guard let query = url.query else {
        XCTFail("the request URL contains no query:\n" + url.absoluteString, file: file, line: line); return
    }
    
    let expected = Set<String>(items)                               // The set of expected query items.
    let actual = Set<String>(query.components(separatedBy: "&"))    // The set of actual query items.
    
    if expected == actual { return } // If these both contain the same values, then return - no need to test further.

    let unexpected = actual.subtracting(expected) // The set of any remaining 'actual' items.
    let missing = expected.subtracting(actual) // The set of any remaining 'expected' items.
    
    if expected.isStrictSuperset(of: actual) { // then 'actual' is missing something expected (but doesn't have anything unexpected):
        for item in missing {
            XCTFail("could not find \"\(item)\" in the request URL query:\n" + query, file: file, line: line)
        }
    } else if actual.isStrictSuperset(of: expected) { // then 'actual' contains more than what's expected (but isn't missing anything):
        for item in unexpected {
            XCTFail("request URL query contained an unexpected item: \"\(item)\"\n" + query, file: file, line: line)
        }
    } else { // each set contains something that the other doesn't:
        for item in missing {
            let items = unexpected.count > 1 ? unexpected.joined(separator: "\", \"") : unexpected.first!
            XCTFail("could not find \"\(item)\" in the request URL query, but found \"\(items)\" instead:\n" + query, file: file, line: line)
        }
    }
}
