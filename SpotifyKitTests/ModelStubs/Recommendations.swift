//
//  Recommendations.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/30/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var recommendationsData: Data {
        return """
        {
          "tracks" : [ {
            "album" : {
              "album_type" : "ALBUM",
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/4NHQUGzhtTLFvgF5SZesLK"
                },
                "href" : "https://api.spotify.com/v1/artists/4NHQUGzhtTLFvgF5SZesLK",
                "id" : "4NHQUGzhtTLFvgF5SZesLK",
                "name" : "Tove Lo",
                "type" : "artist",
                "uri" : "spotify:artist:4NHQUGzhtTLFvgF5SZesLK"
              } ],
              "external_urls" : {
                "spotify" : "https://open.spotify.com/album/1tuekzsMZQOuiMejKP6t2Y"
              },
              "href" : "https://api.spotify.com/v1/albums/1tuekzsMZQOuiMejKP6t2Y",
              "id" : "1tuekzsMZQOuiMejKP6t2Y",
              "images" : [ {
                "height" : 640,
                "url" : "https://i.scdn.co/image/46cadf3fab5d422211c19207beca72b823120c00",
                "width" : 640
              }, {
                "height" : 300,
                "url" : "https://i.scdn.co/image/34306a13b7dcaeea8d064bc2710d0c27f355982e",
                "width" : 300
              }, {
                "height" : 64,
                "url" : "https://i.scdn.co/image/423613b1ab4ebd855bfe61bc2c7a7c398647bb9a",
                "width" : 64
              } ],
              "name" : "Lady Wood",
              "type" : "album",
              "uri" : "spotify:album:1tuekzsMZQOuiMejKP6t2Y"
            },
            "artists" : [ {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/artist/4NHQUGzhtTLFvgF5SZesLK"
              },
              "href" : "https://api.spotify.com/v1/artists/4NHQUGzhtTLFvgF5SZesLK",
              "id" : "4NHQUGzhtTLFvgF5SZesLK",
              "name" : "Tove Lo",
              "type" : "artist",
              "uri" : "spotify:artist:4NHQUGzhtTLFvgF5SZesLK"
            } ],
            "disc_number" : 1,
            "duration_ms" : 252771,
            "explicit" : false,
            "external_ids" : {
              "isrc" : "SEUM71601202"
            },
            "external_urls" : {
              "spotify" : "https://open.spotify.com/track/79NqxckK3lcOV0DTVXPuEE"
            },
            "href" : "https://api.spotify.com/v1/tracks/79NqxckK3lcOV0DTVXPuEE",
            "id" : "79NqxckK3lcOV0DTVXPuEE",
            "is_playable" : true,
            "linked_from" : {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/30XdrKqZLyKojgKvAkRtno"
              },
              "href" : "https://api.spotify.com/v1/tracks/30XdrKqZLyKojgKvAkRtno",
              "id" : "30XdrKqZLyKojgKvAkRtno",
              "type" : "track",
              "uri" : "spotify:track:30XdrKqZLyKojgKvAkRtno"
            },
            "name" : "Imaginary Friend",
            "popularity" : 56,
            "preview_url" : null,
            "track_number" : 9,
            "type" : "track",
            "uri" : "spotify:track:79NqxckK3lcOV0DTVXPuEE"
          }, {
            "album" : {
              "album_type" : "ALBUM",
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/6nS5roXSAGhTGr34W6n7Et"
                },
                "href" : "https://api.spotify.com/v1/artists/6nS5roXSAGhTGr34W6n7Et",
                "id" : "6nS5roXSAGhTGr34W6n7Et",
                "name" : "Disclosure",
                "type" : "artist",
                "uri" : "spotify:artist:6nS5roXSAGhTGr34W6n7Et"
              } ],
              "external_urls" : {
                "spotify" : "https://open.spotify.com/album/08ipn1MH7xqgoqhUbtvCTy"
              },
              "href" : "https://api.spotify.com/v1/albums/08ipn1MH7xqgoqhUbtvCTy",
              "id" : "08ipn1MH7xqgoqhUbtvCTy",
              "images" : [ {
                "height" : 640,
                "url" : "https://i.scdn.co/image/6d925ed1f3ca268417286d2db37dacb3f3c6cd62",
                "width" : 640
              }, {
                "height" : 300,
                "url" : "https://i.scdn.co/image/e0f898464733b25341882e2e84832daaf62ed642",
                "width" : 300
              }, {
                "height" : 64,
                "url" : "https://i.scdn.co/image/c8f5e3fb012a792ec0e3c080c29b46f7060feaea",
                "width" : 64
              } ],
              "name" : "Caracal (Deluxe)",
              "type" : "album",
              "uri" : "spotify:album:08ipn1MH7xqgoqhUbtvCTy"
            },
            "artists" : [ {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/artist/6nS5roXSAGhTGr34W6n7Et"
              },
              "href" : "https://api.spotify.com/v1/artists/6nS5roXSAGhTGr34W6n7Et",
              "id" : "6nS5roXSAGhTGr34W6n7Et",
              "name" : "Disclosure",
              "type" : "artist",
              "uri" : "spotify:artist:6nS5roXSAGhTGr34W6n7Et"
            } ],
            "disc_number" : 1,
            "duration_ms" : 309458,
            "explicit" : false,
            "external_ids" : {
              "isrc" : "GBUM71503572"
            },
            "external_urls" : {
              "spotify" : "https://open.spotify.com/track/78GyX18u4pQwlnVYBaGjbb"
            },
            "href" : "https://api.spotify.com/v1/tracks/78GyX18u4pQwlnVYBaGjbb",
            "id" : "78GyX18u4pQwlnVYBaGjbb",
            "is_playable" : true,
            "name" : "Echoes",
            "popularity" : 42,
            "preview_url" : null,
            "track_number" : 10,
            "type" : "track",
            "uri" : "spotify:track:78GyX18u4pQwlnVYBaGjbb"
          }, {
            "album" : {
              "album_type" : "ALBUM",
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/28j8lBWDdDSHSSt5oPlsX2"
                },
                "href" : "https://api.spotify.com/v1/artists/28j8lBWDdDSHSSt5oPlsX2",
                "id" : "28j8lBWDdDSHSSt5oPlsX2",
                "name" : "ZHU",
                "type" : "artist",
                "uri" : "spotify:artist:28j8lBWDdDSHSSt5oPlsX2"
              } ],
              "external_urls" : {
                "spotify" : "https://open.spotify.com/album/1X4yodq8QzdlHOf2EgwhWU"
              },
              "href" : "https://api.spotify.com/v1/albums/1X4yodq8QzdlHOf2EgwhWU",
              "id" : "1X4yodq8QzdlHOf2EgwhWU",
              "images" : [ {
                "height" : 640,
                "url" : "https://i.scdn.co/image/7494bdbd5da6e49e7f0e7f22f514a8da5ca5bc4f",
                "width" : 640
              }, {
                "height" : 300,
                "url" : "https://i.scdn.co/image/35c73634dfb206c419c90862e17f152952b9a56f",
                "width" : 300
              }, {
                "height" : 64,
                "url" : "https://i.scdn.co/image/d60d0e1ece12e72b5722494b6a9fc027775e80f3",
                "width" : 64
              } ],
              "name" : "Genesis Series",
              "type" : "album",
              "uri" : "spotify:album:1X4yodq8QzdlHOf2EgwhWU"
            },
            "artists" : [ {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/artist/28j8lBWDdDSHSSt5oPlsX2"
              },
              "href" : "https://api.spotify.com/v1/artists/28j8lBWDdDSHSSt5oPlsX2",
              "id" : "28j8lBWDdDSHSSt5oPlsX2",
              "name" : "ZHU",
              "type" : "artist",
              "uri" : "spotify:artist:28j8lBWDdDSHSSt5oPlsX2"
            }, {
              "external_urls" : {
                "spotify" : "https://open.spotify.com/artist/7wFDo161xYdeaiLz3KIHoM"
              },
              "href" : "https://api.spotify.com/v1/artists/7wFDo161xYdeaiLz3KIHoM",
              "id" : "7wFDo161xYdeaiLz3KIHoM",
              "name" : "Gallant",
              "type" : "artist",
              "uri" : "spotify:artist:7wFDo161xYdeaiLz3KIHoM"
            } ],
            "disc_number" : 1,
            "duration_ms" : 267240,
            "explicit" : false,
            "external_ids" : {
              "isrc" : "USSM11506934"
            },
            "external_urls" : {
              "spotify" : "https://open.spotify.com/track/1Xgx2y4xlqDxQizsXPiRAw"
            },
            "href" : "https://api.spotify.com/v1/tracks/1Xgx2y4xlqDxQizsXPiRAw",
            "id" : "1Xgx2y4xlqDxQizsXPiRAw",
            "is_playable" : true,
            "name" : "Testarossa Music",
            "popularity" : 44,
            "preview_url" : "https://p.scdn.co/mp3-preview/12a623c5a3a0b186856fea218c92902cc5ea6358?cid=8897482848704f2a8f8d7c79726a70d4",
            "track_number" : 3,
            "type" : "track",
            "uri" : "spotify:track:1Xgx2y4xlqDxQizsXPiRAw"
          } ],
          "seeds" : [ {
            "initialPoolSize" : 250,
            "afterFilteringSize" : 250,
            "afterRelinkingSize" : 249,
            "id" : "4NHQUGzhtTLFvgF5SZesLK",
            "type" : "ARTIST",
            "href" : "https://api.spotify.com/v1/artists/4NHQUGzhtTLFvgF5SZesLK"
          }, {
            "initialPoolSize" : 250,
            "afterFilteringSize" : 250,
            "afterRelinkingSize" : 238,
            "id" : "0c6xIDDpzE81m2q797ordA",
            "type" : "TRACK",
            "href" : "https://api.spotify.com/v1/tracks/0c6xIDDpzE81m2q797ordA"
          }, {
            "initialPoolSize" : 517,
            "afterFilteringSize" : 313,
            "afterRelinkingSize" : 312,
            "id" : "classical",
            "type" : "GENRE",
            "href" : null
          }, {
            "initialPoolSize" : 100,
            "afterFilteringSize" : 100,
            "afterRelinkingSize" : 100,
            "id" : "country",
            "type" : "GENRE",
            "href" : null
          } ]
        }
        """.data(using: .utf8)!
    }
}
