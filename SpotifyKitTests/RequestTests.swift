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
    
    var apiSession: SPTSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // FIXME: Request a new access token if this one is expired.
        // https://developer.spotify.com/web-api/console/
        let accessToken = "BQDHM9eEkqUaERZLymyo8uTtXtjlHF1TWlsGTOmQsGMxXgK6KA3OkyfUG6dLbY87LcDRGfQgZXOXOZea1QEoTy2E8gPIxwgzxW9opUiMlL3jZW_GrTvlh-du7lpvG6lBQkTBcgTT73Iw3kagks0tHPTr3yAM2OGLqnJ73lX130brDLXuq_mjmse8ad2k-pkBcmbrLevr0EzYSkWuq1DY9arRk0oZ01m8JfUaKHcU_p7b_roH-hT5USSTouUzYYAirELXw0TMb7mNh_-uB712KUEH"
        
        apiSession = SPTSession(userName: "haversnail",
                                accessToken: accessToken,
                                expirationDate: Date.distantFuture)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        SPTAuth.defaultInstance().session = nil
        apiSession = nil
        super.tearDown()
    }
    
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
        
        // Assert current URL request:
        XCTAssertNotNil(request, "could not create the request.")
        XCTAssertEqual(request?.preparedURLRequest.url?.absoluteString, "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm?market=US")
        XCTAssertNil(request?.preparedURLRequest.value(forHTTPHeaderField: "Authorization"), "the URL request's \"Authorizaton\" field should be empty.")
        XCTAssertNil(request?.preparedURLRequest.value(forHTTPHeaderField: "Content-Type"), "the URL request's \"Content-Type\" field should be empty.")
        XCTAssertNil(request?.preparedURLRequest.httpBody, "the URL request's HTTP body should be empty.")
        
        // Set API session:
        request?.apiSession = apiSession

        // Assert updated URL request:
        XCTAssertEqual(request?.preparedURLRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(apiSession.accessToken!)")
        
        // Set multipart request body:
        request?.addMultipartData(requestBody, type: .json)
        
        // Assert updated URL request:
        XCTAssertEqual(request?.preparedURLRequest.httpBody, requestBody)
        XCTAssertEqual(request?.preparedURLRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testValidResponse() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let request = SKRequest(method: .GET, endpoint: endpoint)
        let promise = expectation(description: "request returned the expected data.")
        
        XCTAssertNotNil(request, "could not create the request.")
        
        // Sets the request's SPTSession property:
        request?.apiSession = apiSession
        
        // Act:
        request?.perform { (data, error) in
            
            // Assert:
            XCTAssertNil(error, "\"error\" was not nil.")
            XCTAssertNotNil(data, "\"data\" was nil.")
            
            guard data != nil else { return }
            
            do {
                let _ = try SKAlbum(from: data!)
            } catch {
                XCTFail("could not initialize the SpotifyKit object from the given data (see console).")
                print(error)
                return
            }
            
            promise.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testInvalidResponse() {
        
        // Arrange:
        let endpoint = "/v1/albums/5DLhV9yOvZ7IxVmljMXtNm"
        let request = SKRequest(method: .GET, endpoint: endpoint)
        let promise = expectation(description: "request returned the expected error.")

        XCTAssertNotNil(request, "could not create the request.")
        
        // Give the request an invalid API session/access token:
        request?.apiSession = SPTSession(userName: "haversnail",
                                         accessToken: "something-that-isnt-valid",
                                         expirationDate: Date.distantFuture)
        
        // Act:
        request?.perform { (data, error) in
            
            // Assert:
            XCTAssertNotNil(error, "\"error\" was not supposed to be nil.")
            XCTAssertNil(data, "\"data\" was supposed to be nil.")
            
            guard let apiError = error as? SKError else {
                XCTFail("error object is supposed to be of type `SKError`.")
                return
            }
            
            XCTAssertEqual(apiError.status, .unauthorized)
            promise.fulfill()
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
        
        let promise = expectation(description: "results were returned by the search.")
        let request = SKRequest.searchRequest(for: .album, .playlist, matching: "Game of", excluding: "Thrones", inOrder: true, filteredBy: filters, limit: 3)
        
        guard let query = request.preparedURLRequest.url?.query else {
            XCTFail("no query was found in the prepared URL request.")
            return
        }
        
        // Assert what the query string should look like:
        print(query)
        XCTAssert(query.contains("q=%22game+of%22+NOT+thrones+year:2010-2017"))
        XCTAssert(query.contains("type=album,playlist"))
        XCTAssert(query.contains("market=from_token"))
        XCTAssert(query.contains("limit=3"))
        
        request.apiSession = apiSession
        
        // Act:
        request.perform { (results: SKSearchResults?, error) in
            
            // Assert:
            XCTAssertNil(error, "\"error\" was not nil.")
            XCTAssertNotNil(results, "results were nil.")
            
            promise.fulfill()
            
            XCTAssertNotNil(results?.albums)
            XCTAssertNotNil(results?.playlists)
            XCTAssertNil(results?.artists)
            XCTAssertNil(results?.tracks)
            
            guard let albums = results?.albums else { return }
            
            for album in albums {
                print(album.name)
                XCTAssert(album.name.localizedCaseInsensitiveContains("game of"), "one of the albums does not contain the expected keywords.")
                XCTAssert(!album.name.localizedCaseInsensitiveContains("thrones"), "one of the albums contains unwanted keywords.")
            }
            
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testSPTSessionExtension() {
        
        // Arrange:
        let url = URL(string: "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm")!
        
        let promise = expectation(description: "request returned the expected data.")
        promise.expectedFulfillmentCount = 2 // Make sure both requests finish successfully.
        
        let handler: SKRequestHandler = { (data, error) in
            
            // Assert:
            XCTAssertNil(error, "\"error\" was not nil.")
            XCTAssertNotNil(data, "\"data\" was nil.")
            
            guard data != nil else { return }
            
            do {
                let _ = try SKAlbum(from: data!)
            } catch {
                XCTFail("could not initialize the SpotifyKit object from the given data (see console).")
                print(error)
                return
            }
            
            promise.fulfill()
        }
        
        // Act:
        apiSession.performRequest(.GET, url: url, handler: handler)
        apiSession.performRequest(.GET, endpoint: url.path, handler: handler)
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
    
    func testExpandableExtension() {
        
        // Arrange:
        let artist = SKArtist(externalURLs: ["Spotify" : URL(string: "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC")!],
                              url: URL(string: "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC")!,
                              id: "6VDdCwrBM4qQaGxoAyxyJC",
                              name: "Cold War Kids",
                              uri: "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC",
                              followers: nil,
                              genres: nil,
                              images: nil,
                              popularity: nil)
        
        let promise = expectation(description: "method returned the full object.")
        
        // Set the default SPTAuth object's session:
        SPTAuth.defaultInstance().session = apiSession
        
        // Act:
        artist.getFullObject { (artist, error) in
           
            // Assert:
            XCTAssertNil(error, "\"error\" was not nil.")
            XCTAssertNotNil(artist, "object was nil.")
            XCTAssertNotNil(artist?.popularity, "field should be populated.")
            print(artist?.popularity ?? 0)
            
            promise.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        if result == .timedOut {
            XCTFail("the request timed out.")
        }
    }
}
