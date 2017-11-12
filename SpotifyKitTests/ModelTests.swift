//
//  ModelTests.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import XCTest
@testable import SpotifyKit

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func initTestObject<T: JSONDecodable>(_ type: T.Type, from jsonData: Data, file: StaticString = #file, line: UInt = #line) -> T? {
        do {
            return try type.init(from: jsonData)
        } catch DecodingError.dataCorrupted(let context) {
            XCTFail("\(context.debugDescription) \nCoding Path: \(context.codingPath.debugDescription)", file: file, line: line)
            return nil
        } catch DecodingError.keyNotFound(_, let context) {
            XCTFail("\(context.debugDescription) \nCoding Path: \(context.codingPath.debugDescription)", file: file, line: line)
            return nil
        } catch DecodingError.typeMismatch(_, let context) {
            XCTFail("\(context.debugDescription) \nCoding Path: \(context.codingPath.debugDescription)", file: file, line: line)
            return nil
        } catch DecodingError.valueNotFound(_, let context) {
            XCTFail("\(context.debugDescription) \nCoding Path: \(context.codingPath.debugDescription)", file: file, line: line)
            return nil
        } catch {
            XCTFail("object could not be initialized from the given JSON data. \(error.localizedDescription)", file: file, line: line)
            return nil
        }
    }
    
    func testAlbum() {
        guard let album = initTestObject(SKAlbum.self, from: albumData) else { return }
        XCTAssertEqual(album.name, "El Camino")
        // Assert computed vars:
        XCTAssertEqual(album.releaseDate?.description(with: nil), "2011-12-06 00:00:00 +0000")
        XCTAssertEqual(album.isSimplified, false)
        // Assert paging collection operations:
        XCTAssertEqual(album.tracks?.startIndex, 0)
        XCTAssertEqual(album.tracks?.endIndex, 11)
        XCTAssertEqual(album.tracks?[3].name, "Little Black Submarines")
        XCTAssertEqual(album.tracks?.index(after: 1), 2)
        XCTAssertEqual(album.tracks?.index(before: 11), 10)
    }
    
    func testSeveralAlbums() {
        guard let albums = initTestObject([SKAlbum].self, from: albumArrayData) else { return }
        // Assert array:
        XCTAssertEqual(albums.count, 2)
    }
    
    func testArtist() {
        guard let artist = initTestObject(SKArtist.self, from: artistData) else { return }
        XCTAssertEqual(artist.name, "Cold War Kids")
        // Assert computed vars:
        XCTAssertEqual(artist.isSimplified, false)
    }
    
    func testAudioFeatures() {
        guard let audioFeatures = initTestObject(SKAudioFeatures.self, from: audioFeaturesData) else { return }
        XCTAssertEqual(audioFeatures.key, .Bb)
        XCTAssertEqual(audioFeatures.mode, .minor)
        // Assert computed var:
        XCTAssertEqual(audioFeatures.duration, TimeInterval(203.782))
    }
    
    func testCategory() {
        guard let category = initTestObject(SKCategory.self, from: categoryData) else { return }
        XCTAssertEqual(category.name, "Indie")
    }
    
    func testDevice() {
        guard let device = initTestObject(SKDevice.self, from: deviceData) else { return }
        XCTAssertEqual(device.type, .computer)
    }
    
    func testError() {
        guard let error = initTestObject(SKError.self, from: errorData) else { return }
        XCTAssertEqual(error.localizedDescription, "Received a 401 (unauthorized) error: The access token expired")
    }
    
    func testAuthError() {
        guard let error = initTestObject(SKAuthenticationError.self, from: authenticationErrorData) else { return }
        XCTAssertEqual(error.localizedDescription, "Received a \"invalid_client\" error: Invalid client secret")
    }
    
    func testPlayHistory() {
        guard let recentTracks = initTestObject(CursorPage<SKRecentTrack>.self, from: recentTrackData) else { return }
        XCTAssertEqual(recentTracks[0].context.type, .playlist)
    }
    
    func testPlaylist() {
        guard let playlist = initTestObject(SKPlaylist.self, from: playlistData) else { return }
        XCTAssertEqual(playlist.name, "Turn Up")
    }

    func testRecommendations() {
        guard let recommendations = initTestObject(SKRecommendations.self, from: recommendationsData) else { return }
        XCTAssertEqual(recommendations.seeds[0].type, .artist)
    }
    
    func testSavedAlbums() {
        guard let albums = initTestObject(Page<SKSavedAlbum>.self, from: savedAlbumData) else { return }
        XCTAssertEqual(albums[0].name, "Hold My Home")
    }
    
    func testSavedTracks() {
        guard let tracks = initTestObject(Page<SKSavedTrack>.self, from: savedTrackData) else { return }
        XCTAssertEqual(tracks[10].name, "Counting Stars")
    }

    func testTrack() {
        guard let track = initTestObject(SKTrack.self, from: trackData) else { return }
        XCTAssertEqual(track.name, "My Thing")
        // Assert computed vars:
        XCTAssertEqual(track.duration, TimeInterval(157.666))
        XCTAssertEqual(track.contentRating, .clean)
        XCTAssertEqual(track.isSimplified, false)
        // Assert the returned "simplified" album object properties (for code coverage):
        XCTAssertEqual(track.album?.isSimplified, true)
        XCTAssertNil(track.album?.releaseDate)
    }
    
    func testUser() {
        guard let user = initTestObject(SKUser.self, from: userData) else { return }
        XCTAssertEqual(user.id, "nikerunclub")
    }
    
    func testCurrentUser() {
        guard let user = initTestObject(SKCurrentUser.self, from: currentUserData) else { return }
        XCTAssertEqual(user.id, "ahavermale")
    }

    func testPayloadMismatch() {
        do {
            let _ = try SKUser(from: albumData) // Try creating a user from album data.
            XCTFail("'SKUser' type was able to instantiate itself from the wrong payload.")
        } catch DecodingError.dataCorrupted(let context) {
            XCTAssertEqual(context.codingPath[0].stringValue, "type") // Should encounter the wrong 'type' value.
        } catch {
            XCTFail("enountered an unexpected error. \(error.localizedDescription)")
        }
    }
}

extension Array where Element == CodingKey {
    fileprivate var debugDescription: String {
        get {
            var path = ""
            if self.isEmpty { return path }
            
            for (index, key) in self.enumerated() {
                if key.intValue != nil {                    // If there's an int value for this particular key,
                    path.append(key.stringValue)            // then append the string value as-is; it represents an index-based key.
                } else {                                    // if there is no int value,
                    path.append("\"\(key.stringValue)\"")   // then add quotes to show that it represents a string-based key.
                }
                
                if index < endIndex - 1 {                   // As long as we're not on the last key,
                    path.append(" ~> ")                     // add some pretty-printed pointing.
                }
            }
            return path
        }
    }
}
