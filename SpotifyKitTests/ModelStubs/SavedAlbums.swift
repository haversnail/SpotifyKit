//
//  SavedAlbums.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/29/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var savedAlbumData: Data {
        return """
        {
          "href" : "https://api.spotify.com/v1/me/albums?offset=0&limit=20",
          "items" : [ {
            "added_at" : "2015-08-04T01:30:11Z",
            "album" : {
              "album_type" : "album",
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                },
                "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                "name" : "Cold War Kids",
                "type" : "artist",
                "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
              } ],
              "available_markets" : [ ],
              "copyrights" : [ {
                "text" : "(C) 2014 Downtown Records",
                "type" : "C"
              } ],
              "external_ids" : {
                "upc" : "886444802925"
              },
              "external_urls" : {
                "spotify" : "https://open.spotify.com/album/01x41UlgUnQ3QX5OLcIKFo"
              },
              "genres" : [ ],
              "href" : "https://api.spotify.com/v1/albums/01x41UlgUnQ3QX5OLcIKFo",
              "id" : "01x41UlgUnQ3QX5OLcIKFo",
              "images" : [ {
                "height" : 640,
                "url" : "https://i.scdn.co/image/4517816fb40750bc54014d239ca64ac409c273da",
                "width" : 640
              }, {
                "height" : 300,
                "url" : "https://i.scdn.co/image/e883e2aaee0a934cb4bcda04c88b490e1bf902f1",
                "width" : 300
              }, {
                "height" : 64,
                "url" : "https://i.scdn.co/image/3feaf52aade4ae1b4660d0e28fd1ad1abb371003",
                "width" : 64
              } ],
              "label" : "Downtown Records",
              "name" : "Hold My Home",
              "popularity" : 12,
              "release_date" : "2014-10-21",
              "release_date_precision" : "day",
              "tracks" : {
                "href" : "https://api.spotify.com/v1/albums/01x41UlgUnQ3QX5OLcIKFo/tracks?offset=0&limit=50",
                "items" : [ {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 188106,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/2bVZ9Mbq0roH4gJpGdioaH"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/2bVZ9Mbq0roH4gJpGdioaH",
                  "id" : "2bVZ9Mbq0roH4gJpGdioaH",
                  "name" : "All This Could Be Yours",
                  "preview_url" : null,
                  "track_number" : 1,
                  "type" : "track",
                  "uri" : "spotify:track:2bVZ9Mbq0roH4gJpGdioaH"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 200360,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/0aGSUNleFqs5HNEJcwqvXJ"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/0aGSUNleFqs5HNEJcwqvXJ",
                  "id" : "0aGSUNleFqs5HNEJcwqvXJ",
                  "name" : "First",
                  "preview_url" : null,
                  "track_number" : 2,
                  "type" : "track",
                  "uri" : "spotify:track:0aGSUNleFqs5HNEJcwqvXJ"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 208186,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/4W4ADEUUrMze7ENcVnoCBc"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/4W4ADEUUrMze7ENcVnoCBc",
                  "id" : "4W4ADEUUrMze7ENcVnoCBc",
                  "name" : "Hot Coals",
                  "preview_url" : null,
                  "track_number" : 3,
                  "type" : "track",
                  "uri" : "spotify:track:4W4ADEUUrMze7ENcVnoCBc"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 250066,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/5i5Nv3Dy3toiu22r0ALKYn"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/5i5Nv3Dy3toiu22r0ALKYn",
                  "id" : "5i5Nv3Dy3toiu22r0ALKYn",
                  "name" : "Drive Desperate",
                  "preview_url" : null,
                  "track_number" : 4,
                  "type" : "track",
                  "uri" : "spotify:track:5i5Nv3Dy3toiu22r0ALKYn"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 190560,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/6XFaVikwKqVAk0KLEN7wAr"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/6XFaVikwKqVAk0KLEN7wAr",
                  "id" : "6XFaVikwKqVAk0KLEN7wAr",
                  "name" : "Hotel Anywhere",
                  "preview_url" : null,
                  "track_number" : 5,
                  "type" : "track",
                  "uri" : "spotify:track:6XFaVikwKqVAk0KLEN7wAr"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 231080,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/4fXSqiV0lwQK4uTv3fBXJQ"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/4fXSqiV0lwQK4uTv3fBXJQ",
                  "id" : "4fXSqiV0lwQK4uTv3fBXJQ",
                  "name" : "Go Quietly",
                  "preview_url" : null,
                  "track_number" : 6,
                  "type" : "track",
                  "uri" : "spotify:track:4fXSqiV0lwQK4uTv3fBXJQ"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 174333,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/3Fga96eKJ4UtwhKXNzNl4Q"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/3Fga96eKJ4UtwhKXNzNl4Q",
                  "id" : "3Fga96eKJ4UtwhKXNzNl4Q",
                  "name" : "Nights & Weekends",
                  "preview_url" : null,
                  "track_number" : 7,
                  "type" : "track",
                  "uri" : "spotify:track:3Fga96eKJ4UtwhKXNzNl4Q"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 170120,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/5vyzCnN7XOY8N9UeJvDc3v"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/5vyzCnN7XOY8N9UeJvDc3v",
                  "id" : "5vyzCnN7XOY8N9UeJvDc3v",
                  "name" : "Hold My Home",
                  "preview_url" : null,
                  "track_number" : 8,
                  "type" : "track",
                  "uri" : "spotify:track:5vyzCnN7XOY8N9UeJvDc3v"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 216826,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/6j3HA7HRVWZ9OtXe9H4ScD"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/6j3HA7HRVWZ9OtXe9H4ScD",
                  "id" : "6j3HA7HRVWZ9OtXe9H4ScD",
                  "name" : "Flower Drum Song",
                  "preview_url" : null,
                  "track_number" : 9,
                  "type" : "track",
                  "uri" : "spotify:track:6j3HA7HRVWZ9OtXe9H4ScD"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 252026,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/0qQ2EKimGM7DHgrPEMCjK0"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/0qQ2EKimGM7DHgrPEMCjK0",
                  "id" : "0qQ2EKimGM7DHgrPEMCjK0",
                  "name" : "Harold Bloom",
                  "preview_url" : null,
                  "track_number" : 10,
                  "type" : "track",
                  "uri" : "spotify:track:0qQ2EKimGM7DHgrPEMCjK0"
                }, {
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
                    "id" : "6VDdCwrBM4qQaGxoAyxyJC",
                    "name" : "Cold War Kids",
                    "type" : "artist",
                    "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
                  } ],
                  "available_markets" : [ ],
                  "disc_number" : 1,
                  "duration_ms" : 290546,
                  "explicit" : false,
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/track/1N8F9fAimcsggWDbdehE9a"
                  },
                  "href" : "https://api.spotify.com/v1/tracks/1N8F9fAimcsggWDbdehE9a",
                  "id" : "1N8F9fAimcsggWDbdehE9a",
                  "name" : "Hear My Baby Call",
                  "preview_url" : null,
                  "track_number" : 11,
                  "type" : "track",
                  "uri" : "spotify:track:1N8F9fAimcsggWDbdehE9a"
                } ],
                "limit" : 50,
                "next" : null,
                "offset" : 0,
                "previous" : null,
                "total" : 11
              },
              "type" : "album",
              "uri" : "spotify:album:01x41UlgUnQ3QX5OLcIKFo"
            }
          } ],
          "limit" : 20,
          "next" : null,
          "offset" : 0,
          "previous" : null,
          "total" : 1
        }
        """.data(using: .utf8)!
    }
}
