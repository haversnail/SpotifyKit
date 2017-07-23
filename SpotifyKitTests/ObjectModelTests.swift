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
        let album = SKAlbum(data: kAlbumData)
        XCTAssertNotNil(album, "object could not be initialized from the given JSON data")
        XCTAssertEqual(album?.name, "El Camino")
    }
    
//    func testAlbumSimplified() {
//
//    }
    
    func testArtist() {
        let artist = SKArtist(data: kArtistData)
        XCTAssertNotNil(artist, "object could not be initialized from the given JSON data")
        XCTAssertEqual(artist?.name, "Cold War Kids")
    }
    
//    func testArtistSimplified() {
//
//    }
    
    func testTrack() {
        let track = SKTrack(data: kTrackData)
        XCTAssertNotNil(track, "object could not be initialized from the given JSON data")
        XCTAssertEqual(track?.name, "My Thing")
    }
    
//    func testTrackSimplified() {
//
//    }
    
}
