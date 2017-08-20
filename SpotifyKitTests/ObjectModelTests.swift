//
//  ObjectModelTests.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import XCTest
@testable import SpotifyKit

class ObjectModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func initTestObject<T: JSONDecodable>(of type: T.Type, from jsonData: Data) -> T? {
        do {
            return try type.init(from: jsonData)
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch DecodingError.keyNotFound(let key, let context) {
            print(context.debugDescription, "A matching JSON key couldn't be found for the \"\(key)\" coding key.")
            return nil
        } catch DecodingError.typeMismatch(_, let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch DecodingError.valueNotFound(_, let context) {
            print(context.debugDescription, context.codingPath)
            return nil
        } catch {
            print("Untyped error:", error)
            return nil
        }
    }
    
    func testAlbum() {
        let album = initTestObject(of: SKAlbum.self, from: albumData)
        XCTAssertNotNil(album, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(album?.name, "El Camino")
        // Test computed vars:
        XCTAssertEqual(album?.releaseDate?.description(with: nil), "2011-12-06 00:00:00 +0000")
        XCTAssertEqual(album?.isSimplified, false)
        // Test paging collection operations:
        XCTAssertEqual(album?.tracks?.startIndex, 0)
        XCTAssertEqual(album?.tracks?.endIndex, 11)
        XCTAssertEqual(album?.tracks?[3].name, "Little Black Submarines")
        XCTAssertEqual(album?.tracks?.index(after: 1), 2)
        XCTAssertEqual(album?.tracks?.index(before: 11), 10)
    }
    
    func testArtist() {
        let artist = initTestObject(of: SKArtist.self, from: artistData)
        XCTAssertNotNil(artist, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(artist?.name, "Cold War Kids")
        // Test computed vars:
        XCTAssertEqual(artist?.isSimplified, false)
    }
    
    func testAudioFeatures() {
        let audioFeatures = initTestObject(of: SKAudioFeatures.self, from: audioFeaturesData)
        XCTAssertNotNil(audioFeatures, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(audioFeatures?.key, .Bb)
        XCTAssertEqual(audioFeatures?.mode, .minor)
        // Test computed var:
        XCTAssertEqual(audioFeatures?.duration, TimeInterval(203.782))
    }
    
    func testCategory() {
        let category = initTestObject(of: SKCategory.self, from: categoryData)
        XCTAssertNotNil(category, "object could not be initialized from the given JSON data (see console).")
    }
    
    func testError() {
        let error = initTestObject(of: SKError.self, from: errorData)
        XCTAssertNotNil(error, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(error?.localizedDescription, "Receieved a 401 error: The access token expired.")
    }
    
    func testAuthError() {
        let error = initTestObject(of: SKAuthenticationError.self, from: authenticationErrorData)
        XCTAssertNotNil(error, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(error?.localizedDescription, "Received a \"invalid_client\" error: Invalid client secret.")
    }
    
    func testPlayHistory() {
        let recentTracks = initTestObject(of: PagedCollection<SKRecentTrack>.self, from: recentTrackData)
        XCTAssertNotNil(recentTracks, "object could not be initialized from the given JSON data (see console).")
    }
    
    func testPlaylist() {
        let playlist = initTestObject(of: SKPlaylist.self, from: playlistData)
        XCTAssertNotNil(playlist, "object could not be initialized from the given JSON data (see console).")
    }
    
    func testRecommendations() {
        let recommendations = initTestObject(of: SKRecommendations.self, from: recommendationsData)
        XCTAssertNotNil(recommendations, "object could not be initialized from the given JSON data (see console).")
    }
    
    func testSavedAlbums() {
        let savedAlbums = initTestObject(of: PagedCollection<SavedItem<SKAlbum>>.self, from: savedAlbumData)
        XCTAssertNotNil(savedAlbums, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(savedAlbums?[0].album.name, "Hold My Home")
    }
    
    func testSavedTracks() {
        let savedTracks = initTestObject(of: PagedCollection<SavedItem<SKTrack>>.self, from: savedTrackData)
        XCTAssertNotNil(savedTracks, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(savedTracks?[10].track.name, "Counting Stars")
    }

    func testTrack() {
        let track = initTestObject(of: SKTrack.self, from: trackData)
        XCTAssertNotNil(track, "object could not be initialized from the given JSON data (see console).")
        XCTAssertEqual(track?.name, "My Thing")
        // Test computed vars:
        XCTAssertEqual(track?.duration, TimeInterval(157.666))
        XCTAssertEqual(track?.contentRating, .clean)
        XCTAssertEqual(track?.isSimplified, false)
        // Test the returned "simplified" album object properties (for code coverage):
        XCTAssertEqual(track?.album?.isSimplified, true)
        XCTAssertNil(track?.album?.releaseDate)
    }
    
    func testUser() {
        let user = initTestObject(of: SKUser.self, from: userData)
        XCTAssertNotNil(user, "object could not be initialized from the given JSON data (see console).")
    }

}
