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
        let accessToken = "BQDv2a24cTr7dNCGEsT2OlSQONyKGRf9BcdpyxL4CXMd_uaNwpCzK99C4pZkqrmGE0cQuXhdPsQNUxXbGOcB-qtFMGQrj0eK81jzzRlGLZMJRe6L7jyAB1Eex-sKnUuZBhECirU2dAb-KJHsHK9bxZ16XUdKJSV28Vbin38mcwu4Ps4kz5u5dcsW8Vul2CJzrbJvi_KKEpVW3QckIA-hUTuStqq9ibIw-4160D2sQa3JeD2mm4YyQ1g86qDKSgOXggjuXJQIbVqRtMIwAKC_LDmy"
        
        apiSession = SPTSession(userName: "haversnail",
                                accessToken: accessToken,
                                expirationDate: Date.distantFuture)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
