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
    
    func testAlbum() {
        let album = SKAlbum(data: albumData)
        XCTAssertNotNil(album, "object could not be initialized from the given JSON data.")
        XCTAssertEqual(album?.name, "El Camino")
        // Test computed vars:
        XCTAssertEqual(album?.releaseDate?.description(with: nil), "2011-12-06 00:00:00 +0000")
        XCTAssertEqual(album?.isSimplified, false)
    }
    
    func testArtist() {
        let artist = SKArtist(data: artistData)
        XCTAssertNotNil(artist, "object could not be initialized from the given JSON data.")
        XCTAssertEqual(artist?.name, "Cold War Kids")
        // Test computed vars:
        XCTAssertEqual(artist?.isSimplified, false)
    }
    
    func testAudioFeatures() {
        let audioFeatures = SKAudioFeatures(data: audioFeaturesData)
        XCTAssertNotNil(audioFeatures, "object could not be initialized from the given JSON data.")
        XCTAssertEqual(audioFeatures?.key, .Bb)
        XCTAssertEqual(audioFeatures?.mode, .minor)
        // Test computed var:
        XCTAssertEqual(audioFeatures?.duration, TimeInterval(203.782))
    }

    func testTrack() {
        let track = SKTrack(data: trackData)
        XCTAssertNotNil(track, "object could not be initialized from the given JSON data.")
        XCTAssertEqual(track?.name, "My Thing")
        // Test computed vars:
        XCTAssertEqual(track?.duration, TimeInterval(157.666))
        XCTAssertEqual(track?.contentRating, .clean)
        XCTAssertEqual(track?.isSimplified, false)
    }

}