//
//  Artist.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var artistData: Data {
        return """
        {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
          },
          "followers" : {
            "href" : null,
            "total" : 326125
          },
          "genres" : [ "garage rock", "indie folk", "indie pop", "indie rock", "indietronica", "la indie", "modern rock", "piano rock", "shimmer pop", "stomp and holler" ],
          "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
          "id" : "6VDdCwrBM4qQaGxoAyxyJC",
          "images" : [ {
            "height" : 640,
            "url" : "https://i.scdn.co/image/84c1bdd4f601303b7babad834f743f16b483dcd2",
            "width" : 640
          }, {
            "height" : 320,
            "url" : "https://i.scdn.co/image/e9b2265ec64da68a9475eb5805acdde30eb0b97b",
            "width" : 320
          }, {
            "height" : 160,
            "url" : "https://i.scdn.co/image/a890df35444fa9542e6b640c345b6dd719017b96",
            "width" : 160
          } ],
          "name" : "Cold War Kids",
          "popularity" : 70,
          "type" : "artist",
          "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
        }
        """.data(using: .utf8)!
    }
}
