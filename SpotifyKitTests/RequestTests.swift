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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // FIXME: Request a new access token if this one is expired.
        // Note: Be sure to request all scopes when retrieving a new token, as some tests perform API requests that require access to private user data.
        // https://developer.spotify.com/web-api/console/
        let accessToken = "BQCFH5Csovz5xPg9hAk8V8ZyCsubVM39he40aEniApvF9WIDQ-zIB1xm_HIYf9ZTIOCgM3YY49PkDXNGspfcOiEsNZ4cEeRbk0gVwX2vnwV6hHwf3jldvaE1EkhYDt9ASOdUI-2sX3ZbKxzvAw"
        
        SPTAuth.defaultInstance().session = SPTSession(userName: "haversnail",
                                                       accessToken: accessToken,
                                                       expirationDate: Date.distantFuture)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        SPTAuth.defaultInstance().session = nil
        super.tearDown()
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
        print(request?.parameters ?? "No parameters: request was not valid!")
        XCTAssert(request?.parameters.count == 3, "existing query items were not appended to the \"parameters\" property.")
        XCTAssert(request?.parameters.contains { $0.key == "market" && ($0.value as? String) == "US" } ?? false, "existing query items were not overwritten with items from the \"parameters\" argument.")
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
        let promise = expectation(description: "the request handler was invoked.")
        
        // Act:
        request.perform { [unowned self] (data, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let data = data else {
                XCTFail("\"data\" is nil."); return
            }
            
            do {
                let album = try SKAlbum(from: data)
                XCTAssertEqual(album.id, "5DLhV9yOvZ7IxVmljMXtNm")
            } catch {
                print(error)
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Album.json", payload: data))
                XCTFail("could not initialize the SpotifyKit object from the given data (see console and attachment).")
            }
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testInvalidResponse() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let request = SKRequest(method: .GET, endpoint: endpoint)!
        let promise = expectation(description: "the request handler was invoked.")
        
        
        // Give the request an invalid API session/access token:
        request.apiSession = SPTSession(userName: "haversnail",
                                         accessToken: "something-that-isnt-valid",
                                         expirationDate: Date.distantFuture)
        
        // Act:
        request.perform { (data, error) in
            defer { promise.fulfill() }

            // Assert:
            XCTAssertNotNil(error, "\"error\" was not supposed to be nil.")
            XCTAssertNil(data, "\"data\" was supposed to be nil.")
            
            guard let apiError = error as? SKError else {
                XCTFail("error object is supposed to be of type `SKError`."); return
            }
            
            XCTAssertEqual(apiError.status, .unauthorized)
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    // MARK: - Request Factory Tests
    
    func testSPTSessionMethods() {
        
        // Arrange:
        let session = SPTAuth.defaultInstance().session!
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        let promise = expectation(description: "the request handler was invoked.")
        promise.expectedFulfillmentCount = 2 // Make sure both requests finish successfully.
        
        let handler: SKRequestHandler = { [unowned self] (data, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let data = data else {
                XCTFail("\"data\" is nil."); return
            }
            
            do {
                let album = try SKAlbum(from: data)
                XCTAssertEqual(album.id, "5DLhV9yOvZ7IxVmljMXtNm")
            } catch {
                print(error)
                self.add(XCTAttachment(uniformTypeIdentifier: nil, name: "Album.json", payload: data))
                XCTFail("could not initialize the SpotifyKit object from the given data (see console and attachment).")
            }
        }
        
        // Act:
        session.performRequest(method: .GET, url: url, handler: handler)
        session.performRequest(method: .GET, endpoint: url.path, handler: handler)
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the requests timed out.")
        }
    }
    
    func testExpandableRequest() {
        
        // Arrange:
        let simplifiedArtistData = """
        {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
          },
          "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
          "id" : "6VDdCwrBM4qQaGxoAyxyJC",
          "name" : "Cold War Kids",
          "type" : "artist",
          "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
        }
        """.data(using: .utf8)!
        let artist = try! SKArtist(from: simplifiedArtistData)
        let promise = expectation(description: "the request handler was invoked.")
        let request = artist.makeFullObjectRequest()
        XCTAssertEqual(request.url, artist.url)
        
        // Act:
        artist.getFullObject { (artist, error) in
            defer { promise.fulfill() }

            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artist = artist else {
                XCTFail("\"artist\" is nil."); return
            }
            
            XCTAssertNotNil(artist.popularity, "field should be populated.")
            print(artist.popularity ?? 0)
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testSearchRequest() {
        
        // Arrange:
        let formatter = ISO8601DateFormatter()
        let startDate = formatter.date(from: "2010-05-05T09:30:00Z")!
        let endDate = formatter.date(from: "2017-06-05T09:30:00Z")!
        let filters: [SKSearchFieldFilter] = [
            .genre("soundtrack"), // Should not be added to the query, since we'll only be requesting albums and playlists ("genre" applies to artists/tracks).
            .year(DateInterval(start: startDate, end: endDate))
        ]
        
        let promise = expectation(description: "the request handlers were called.")
        promise.expectedFulfillmentCount = 2
        
        let request = SKRequest.searchRequest(for: [.albums, .playlists], matching: "Game of", excluding: "Thrones", inOrder: true, filteredBy: filters, in: Locale(identifier: "en_US"), page: Page(limit: 3))
        
        // Assert request:
        guard let query = request.preparedURLRequest.url?.query else { XCTFail("the request contained no query."); return }
        XCTAssert(query.contains("q=%22game+of%22+NOT+thrones+year:2010-2017"))
        XCTAssert(query.contains("type=album,playlist"))
        XCTAssert(query.contains("market=US"))
        XCTAssert(query.contains("limit=3"))
        print(query)
        
        // Act:
        request.perform { (results: SKSearchResults?, error) in
            defer { promise.fulfill() }

            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let results = results else {
                XCTFail("\"results\" is nil."); return
            }
            
            XCTAssertNotNil(results.albums, "results should have contained album objects.")
            XCTAssertNotNil(results.playlists, "results should have contained playlist objects.")
            XCTAssertNil(results.artists, "results should not have contained artist objects.")
            XCTAssertNil(results.tracks, "results should not have contained track objects.")
            
            guard let albums = results.albums else { return }
            
            for album in albums {
                print(album.name)
                XCTAssert(album.name.localizedCaseInsensitiveContains("game of"), "one or more albums does not contain the expected keywords.")
                XCTAssert(!album.name.localizedCaseInsensitiveContains("thrones"), "one or more albums contains unwanted keywords.")
            }
        }
        
        // Test `search` method:
        SKRequest.search(for: .all, matching: "Soundtrack") { (results, error) in
            defer { promise.fulfill() }

            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let results = results else {
                XCTFail("\"results\" is nil."); return
            }
            
            XCTAssertNotNil(results.albums, "results should have contained all object types.")
            XCTAssertNotNil(results.playlists, "results should have contained all object types.")
            XCTAssertNotNil(results.artists, "results should have contained all object types.")
            XCTAssertNotNil(results.tracks, "results should have contained all object types.")
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 10)
        if result == .timedOut {
            XCTFail("the requests timed out.")
        }
    }
    
    // MARK: Albums
    
    func testAlbumRequest() {
        
        // Arrange:
        let albumID = "5DLhV9yOvZ7IxVmljMXtNm"
        let locale = Locale(identifier: "en_US")
        let request = SKAlbum.makeAlbumRequest(id: albumID, locale: locale)
        let promise = expectation(description: "the request handler was invoked.")
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/albums/\(albumID)")
        guard let query = request.preparedURLRequest.url?.query else { XCTFail("the request contained no query."); return }
        XCTAssert(query.contains("market=US"))
        
        // Perform public request method:
        SKAlbum.getAlbum(withID: albumID, in: locale) { (album, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let album = album else {
                XCTFail("\"album\" is nil."); return
            }
            
            XCTAssertEqual(album.id, albumID)
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testSeveralAlbumsRequest() {
        
        // Arrange:
        let albumIDs = ["5DLhV9yOvZ7IxVmljMXtNm","ABCm9wqX2AAeZNV3kdxXYZ","790mhPtbtIdMDRdZM3Jimz"] // Middle ID does not exist.
        let locale = Locale(identifier: "en_US")
        let request = SKAlbum.makeAlbumsRequest(ids: albumIDs, locale: locale)
        let promise = expectation(description: "the request handler was invoked.")
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/albums")
        let queryError = "query parameter doesn't match (see console)."
        guard let query = request.preparedURLRequest.url?.query else { XCTFail("the request contained no query."); return }
        XCTAssert(query.contains("ids=5DLhV9yOvZ7IxVmljMXtNm,ABCm9wqX2AAeZNV3kdxXYZ,790mhPtbtIdMDRdZM3Jimz"), queryError)
        XCTAssert(query.contains("market=US"), queryError)
        print(query)
        
        // Act:
        SKAlbum.getAlbums(withIDs: albumIDs, in: locale) { (albums, error) in
            defer { promise.fulfill() }
            
            // Assert results:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let albums = albums else {
                XCTFail("\"albums\" is nil."); return
            }
            
            XCTAssertEqual(albums.count, 3)
            XCTAssertEqual(albums[0]?.id, "5DLhV9yOvZ7IxVmljMXtNm")
            XCTAssertEqual(albums[2]?.id, "790mhPtbtIdMDRdZM3Jimz")
            XCTAssertNil(albums[1], "middle value should have been nil - the corresponding ID didn't exist.")
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    // MARK: Artists
    
    func testArtistRequest() {
        
        // Arrange:
        let artistID = "6VDdCwrBM4qQaGxoAyxyJC"
        let request = SKArtist.makeArtistRequest(id: artistID)
        let promise = expectation(description: "the request handler was invoked.")
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artistID)")

        // Act:
        SKArtist.getArtist(withID: artistID) { (artist, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artist = artist else {
                XCTFail("\"artist\" is nil."); return
            }
            
            XCTAssertEqual(artist.id, artistID)
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testSeveralArtistsRequest() {
        
        // Arrange:
        let artistIDs = ["6VDdCwrBM4qQaGxoAyxyJC","ABCm9wqX2AAeZNV3kdxXYZ","53XhwfbYqKCa1cC15pYq2q"] // Middle ID does not exist.
        let request = SKArtist.makeArtistsRequest(ids: artistIDs)
        let promise = expectation(description: "the request handler was invoked.")
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists")
        guard let query = request.preparedURLRequest.url?.query else { XCTFail("the request contained no query."); return }
        XCTAssert(query.contains("ids=6VDdCwrBM4qQaGxoAyxyJC,ABCm9wqX2AAeZNV3kdxXYZ,53XhwfbYqKCa1cC15pYq2q"), "query parameter doesn't match (see console).")
        print(query)
        
        // Act:
        SKArtist.getArtists(withIDs: artistIDs) { (artists, error) in
            defer { promise.fulfill() }
            
            // Assert:
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let artists = artists else {
                XCTFail("\"artists\" is nil."); return
            }
            
            XCTAssertEqual(artists.count, 3)
            XCTAssertEqual(artists[0]?.id, "6VDdCwrBM4qQaGxoAyxyJC")
            XCTAssertEqual(artists[2]?.id, "53XhwfbYqKCa1cC15pYq2q")
            XCTAssertNil(artists[1], "middle value should have been nil - the corresponding ID didn't exist.")
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testArtistAlbumsRequest() {
        
        // Arrange:
        let artistData = """
        {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
          },
          "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
          "id" : "6VDdCwrBM4qQaGxoAyxyJC",
          "name" : "Cold War Kids",
          "type" : "artist",
          "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
        }
        """.data(using: .utf8)!
        let artist = try! SKArtist(from: artistData)
        let locale = Locale(identifier: "en_US")
        let page = Page(limit: 3, page: 2)
        let request = artist.makeAlbumsRequest(types: [.album, .single], locale: locale, page: page)
        let promise = expectation(description: "the request handler was invoked.")
        
        // Assert request:
        XCTAssertEqual(request.url.path, "/v1/artists/\(artist.id)/albums")
        let queryError = "query parameter doesn't match (see console)."
        guard let query = request.preparedURLRequest.url?.query else { XCTFail("the request contained no query."); return }
        XCTAssert(query.contains("album_type=album,single"), queryError)
        XCTAssert(query.contains("market=US"), queryError)
        XCTAssert(query.contains("offset=3"), queryError)
        XCTAssert(query.contains("limit=3"), queryError)
        print(query)
        
        // Act:
        artist.getAlbums(filteredBy: [.album, .single], in: locale, page: page) { (albums, error) in
            defer { promise.fulfill() }
            
            if let error = error {
                XCTFail(error.localizedDescription); return
            }
            guard let albums = albums else {
                XCTFail("\"albums\" is nil."); return
            }
            
            XCTAssertEqual(albums.limit, 3)
            XCTAssertEqual(albums.offset, 3)
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
}
