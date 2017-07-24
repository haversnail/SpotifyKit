//
//  Album.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/23/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var albumData: Data {
        return """
        {
          "album_type" : "album",
          "artists" : [ {
            "external_urls" : {
              "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
            },
            "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
            "id" : "7mnBLXK823vNxN3UWB7Gfz",
            "name" : "The Black Keys",
            "type" : "artist",
            "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
          } ],
          "copyrights" : [ {
            "text" : "2011 Nonesuch Records",
            "type" : "C"
          }, {
            "text" : "2011 Nonesuch Records",
            "type" : "P"
          } ],
          "external_ids" : {
            "upc" : "075597963304"
          },
          "external_urls" : {
            "spotify" : "https://open.spotify.com/album/5DLhV9yOvZ7IxVmljMXtNm"
          },
          "genres" : [ ],
          "href" : "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm",
          "id" : "5DLhV9yOvZ7IxVmljMXtNm",
          "images" : [ {
            "height" : 640,
            "url" : "https://i.scdn.co/image/c765b38b45009654a06f756110f8277c6b1ddd4a",
            "width" : 640
          }, {
            "height" : 300,
            "url" : "https://i.scdn.co/image/4e70d2befac151644e1b03c9669c88547688897d",
            "width" : 300
          }, {
            "height" : 64,
            "url" : "https://i.scdn.co/image/625f7f7be253150976583d65cef3649fa30c52d8",
            "width" : 64
          } ],
          "label" : "Nonesuch",
          "name" : "El Camino",
          "popularity" : 70,
          "release_date" : "2011-12-06",
          "release_date_precision" : "day",
          "tracks" : {
            "href" : "https://api.spotify.com/v1/albums/5DLhV9yOvZ7IxVmljMXtNm/tracks?offset=0&limit=50&market=US",
            "items" : [ {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 193653,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/5G1sTBGbZT5o4PNRc75RKI"
              },
              "href" : "https://api.spotify.com/v1/tracks/5G1sTBGbZT5o4PNRc75RKI",
              "id" : "5G1sTBGbZT5o4PNRc75RKI",
              "is_playable" : true,
              "name" : "Lonely Boy",
              "preview_url" : "https://p.scdn.co/mp3-preview/6b462b2d89ed30b669470c39c65b0f04d6ac740b?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 1,
              "type" : "track",
              "uri" : "spotify:track:5G1sTBGbZT5o4PNRc75RKI"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 221026,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/3UD4sghkq8dHUwvKxln1nB"
              },
              "href" : "https://api.spotify.com/v1/tracks/3UD4sghkq8dHUwvKxln1nB",
              "id" : "3UD4sghkq8dHUwvKxln1nB",
              "is_playable" : true,
              "name" : "Dead And Gone",
              "preview_url" : "https://p.scdn.co/mp3-preview/63e51cb357ba10decd9a1e73033de488a5790804?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 2,
              "type" : "track",
              "uri" : "spotify:track:3UD4sghkq8dHUwvKxln1nB"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 224333,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/5lN1EH25gdiqT1SFALMAq1"
              },
              "href" : "https://api.spotify.com/v1/tracks/5lN1EH25gdiqT1SFALMAq1",
              "id" : "5lN1EH25gdiqT1SFALMAq1",
              "is_playable" : true,
              "name" : "Gold On The Ceiling",
              "preview_url" : "https://p.scdn.co/mp3-preview/ff2b18fdee4aa8f3945a03b6adcb2b67e04b9448?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 3,
              "type" : "track",
              "uri" : "spotify:track:5lN1EH25gdiqT1SFALMAq1"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 251266,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/1PXsUXSM3LF2XNSkmIldPb"
              },
              "href" : "https://api.spotify.com/v1/tracks/1PXsUXSM3LF2XNSkmIldPb",
              "id" : "1PXsUXSM3LF2XNSkmIldPb",
              "is_playable" : true,
              "name" : "Little Black Submarines",
              "preview_url" : "https://p.scdn.co/mp3-preview/efdf4f0a648ca29cb6990e701c7b8b6a6cf040c3?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 4,
              "type" : "track",
              "uri" : "spotify:track:1PXsUXSM3LF2XNSkmIldPb"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 177240,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/1S8PKtVKvJWwOwfQpQxzWV"
              },
              "href" : "https://api.spotify.com/v1/tracks/1S8PKtVKvJWwOwfQpQxzWV",
              "id" : "1S8PKtVKvJWwOwfQpQxzWV",
              "is_playable" : true,
              "name" : "Money Maker",
              "preview_url" : "https://p.scdn.co/mp3-preview/bde2c4fa8400a405b25e09418d5949665da07956?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 5,
              "type" : "track",
              "uri" : "spotify:track:1S8PKtVKvJWwOwfQpQxzWV"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 197000,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/5HgAZuHFAU5qLLMYuIQkgq"
              },
              "href" : "https://api.spotify.com/v1/tracks/5HgAZuHFAU5qLLMYuIQkgq",
              "id" : "5HgAZuHFAU5qLLMYuIQkgq",
              "is_playable" : true,
              "name" : "Run Right Back",
              "preview_url" : "https://p.scdn.co/mp3-preview/26e16b2e6608d655f4648b85fcd7e751ddf5966d?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 6,
              "type" : "track",
              "uri" : "spotify:track:5HgAZuHFAU5qLLMYuIQkgq"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 205186,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/5LCuFER5mMzL0fGNpClksf"
              },
              "href" : "https://api.spotify.com/v1/tracks/5LCuFER5mMzL0fGNpClksf",
              "id" : "5LCuFER5mMzL0fGNpClksf",
              "is_playable" : true,
              "name" : "Sister",
              "preview_url" : "https://p.scdn.co/mp3-preview/b64a1403c709c25f0b02c278e16d2a6361683484?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 7,
              "type" : "track",
              "uri" : "spotify:track:5LCuFER5mMzL0fGNpClksf"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 225013,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/2ONpXycQzFmWiutUm7vpIC"
              },
              "href" : "https://api.spotify.com/v1/tracks/2ONpXycQzFmWiutUm7vpIC",
              "id" : "2ONpXycQzFmWiutUm7vpIC",
              "is_playable" : true,
              "name" : "Hell Of A Season",
              "preview_url" : "https://p.scdn.co/mp3-preview/2f644a6b8348f01a3306e0b71bef49d037793e7c?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 8,
              "type" : "track",
              "uri" : "spotify:track:2ONpXycQzFmWiutUm7vpIC"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 209680,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/6DnfupwdspmFT2PYRjFH2F"
              },
              "href" : "https://api.spotify.com/v1/tracks/6DnfupwdspmFT2PYRjFH2F",
              "id" : "6DnfupwdspmFT2PYRjFH2F",
              "is_playable" : true,
              "name" : "Stop Stop",
              "preview_url" : "https://p.scdn.co/mp3-preview/d0110b95d3566106448a402b08b07f0b8838cf5f?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 9,
              "type" : "track",
              "uri" : "spotify:track:6DnfupwdspmFT2PYRjFH2F"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 207040,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/5S7kFUo496CoItemffWQb9"
              },
              "href" : "https://api.spotify.com/v1/tracks/5S7kFUo496CoItemffWQb9",
              "id" : "5S7kFUo496CoItemffWQb9",
              "is_playable" : true,
              "name" : "Nova Baby",
              "preview_url" : "https://p.scdn.co/mp3-preview/2c2caba3bab7344e5af91c16da6bd924b95554f4?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 10,
              "type" : "track",
              "uri" : "spotify:track:5S7kFUo496CoItemffWQb9"
            }, {
              "artists" : [ {
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/artist/7mnBLXK823vNxN3UWB7Gfz"
                },
                "href" : "https://api.spotify.com/v1/artists/7mnBLXK823vNxN3UWB7Gfz",
                "id" : "7mnBLXK823vNxN3UWB7Gfz",
                "name" : "The Black Keys",
                "type" : "artist",
                "uri" : "spotify:artist:7mnBLXK823vNxN3UWB7Gfz"
              } ],
              "disc_number" : 1,
              "duration_ms" : 194586,
              "explicit" : false,
              "external_urls" : {
                "spotify" : "https://open.spotify.com/track/0hzBN7DGgtjBsTyZwTTKRS"
              },
              "href" : "https://api.spotify.com/v1/tracks/0hzBN7DGgtjBsTyZwTTKRS",
              "id" : "0hzBN7DGgtjBsTyZwTTKRS",
              "is_playable" : true,
              "name" : "Mind Eraser",
              "preview_url" : "https://p.scdn.co/mp3-preview/dfc4c8668d0f28fe7ee928156ec033ac73b9e334?cid=8897482848704f2a8f8d7c79726a70d4",
              "track_number" : 11,
              "type" : "track",
              "uri" : "spotify:track:0hzBN7DGgtjBsTyZwTTKRS"
            } ],
            "limit" : 50,
            "next" : null,
            "offset" : 0,
            "previous" : null,
            "total" : 11
          },
          "type" : "album",
          "uri" : "spotify:album:5DLhV9yOvZ7IxVmljMXtNm"
        }
        """.data(using: .utf8)!
    }
}
