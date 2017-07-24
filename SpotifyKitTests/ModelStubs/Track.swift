//
//  Track.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var trackData: Data {
        return """
        {
          "album" : {
            "album_type" : "album",
            "artists" : [ {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/artist/3le6xeRZTGOKsUrIHSHEKs"
              },
              "href" : "https://api.spotify.com/v1/artists/3le6xeRZTGOKsUrIHSHEKs",
              "id" : "3le6xeRZTGOKsUrIHSHEKs",
              "name" : "Vibrolux",
              "type" : "artist",
              "uri" : "spotify:artist:3le6xeRZTGOKsUrIHSHEKs"
            } ],
            "external_urls" : {
              "spotify" : "https://open.spotify.com/album/2iZq3oEOQvi24pwnMAtyob"
            },
            "href" : "https://api.spotify.com/v1/albums/2iZq3oEOQvi24pwnMAtyob",
            "id" : "2iZq3oEOQvi24pwnMAtyob",
            "images" : [ {
              "height" : 640,
              "url" : "https://i.scdn.co/image/d609a0ec6b2384809aab8d307aa79076cebafa9e",
              "width" : 640
            }, {
              "height" : 300,
              "url" : "https://i.scdn.co/image/0f2acc67ed53c4f377e93b1a64ff7d0a79dd8d5f",
              "width" : 300
            }, {
              "height" : 64,
              "url" : "https://i.scdn.co/image/d17dadb14de09957ae28bbd80d86a3dac8b09753",
              "width" : 64
            } ],
            "name" : "Mountain",
            "type" : "album",
            "uri" : "spotify:album:2iZq3oEOQvi24pwnMAtyob"
          },
          "artists" : [ {
            "external_urls" : {
              "spotify" : "https://open.spotify.com/artist/3le6xeRZTGOKsUrIHSHEKs"
            },
            "href" : "https://api.spotify.com/v1/artists/3le6xeRZTGOKsUrIHSHEKs",
            "id" : "3le6xeRZTGOKsUrIHSHEKs",
            "name" : "Vibrolux",
            "type" : "artist",
            "uri" : "spotify:artist:3le6xeRZTGOKsUrIHSHEKs"
          } ],
          "disc_number" : 1,
          "duration_ms" : 157666,
          "explicit" : false,
          "external_ids" : {
            "isrc" : "uscgh1386337"
          },
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/7g1YqCZblmFepoevFFVP7t"
          },
          "href" : "https://api.spotify.com/v1/tracks/7g1YqCZblmFepoevFFVP7t",
          "id" : "7g1YqCZblmFepoevFFVP7t",
          "is_playable" : true,
          "name" : "My Thing",
          "popularity" : 14,
          "preview_url" : "https://p.scdn.co/mp3-preview/36b1991141d0721a7e55530d6fe9786d1cdd3593?cid=8897482848704f2a8f8d7c79726a70d4",
          "track_number" : 1,
          "type" : "track",
          "uri" : "spotify:track:7g1YqCZblmFepoevFFVP7t"
        }
        """.data(using: .utf8)!
    }
}
