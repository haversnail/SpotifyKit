//
//  Playlist.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var playlistData: Data {
        return """
        {
          "collaborative" : false,
          "description" : null,
          "external_urls" : {
            "spotify" : "http://open.spotify.com/user/ahavermale/playlist/1dm9phr0m51fcFcEEumCW7"
          },
          "followers" : {
            "href" : null,
            "total" : 1
          },
          "href" : "https://api.spotify.com/v1/users/ahavermale/playlists/1dm9phr0m51fcFcEEumCW7",
          "id" : "1dm9phr0m51fcFcEEumCW7",
          "images" : [ {
            "height" : 640,
            "url" : "https://mosaic.scdn.co/640/07b676744d50ad3b59e55e744c124765eb769056d116e5ec74862d1f64a5b996131ffc1d1758730cff3d65d3d2e007e719a3f293da4b97749f7d6c57655dd5a905f2f11185251cd405af0786a77dd3b7",
            "width" : 640
          }, {
            "height" : 300,
            "url" : "https://mosaic.scdn.co/300/07b676744d50ad3b59e55e744c124765eb769056d116e5ec74862d1f64a5b996131ffc1d1758730cff3d65d3d2e007e719a3f293da4b97749f7d6c57655dd5a905f2f11185251cd405af0786a77dd3b7",
            "width" : 300
          }, {
            "height" : 60,
            "url" : "https://mosaic.scdn.co/60/07b676744d50ad3b59e55e744c124765eb769056d116e5ec74862d1f64a5b996131ffc1d1758730cff3d65d3d2e007e719a3f293da4b97749f7d6c57655dd5a905f2f11185251cd405af0786a77dd3b7",
            "width" : 60
          } ],
          "name" : "Turn Up",
          "owner" : {
            "external_urls" : {
              "spotify" : "http://open.spotify.com/user/ahavermale"
            },
            "href" : "https://api.spotify.com/v1/users/ahavermale",
            "id" : "ahavermale",
            "type" : "user",
            "uri" : "spotify:user:ahavermale"
          },
          "public" : true,
          "snapshot_id" : "oiqM7mrQZgKOX6/vfwpFGro8Tq8F/yTzz4ehl058TDuRVbC2VXRaeNd9762SdMCA",
          "tracks" : {
            "href" : "https://api.spotify.com/v1/users/ahavermale/playlists/1dm9phr0m51fcFcEEumCW7/tracks?offset=0&limit=100",
            "items" : [ {
              "added_at" : "2015-12-13T06:49:44Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "album",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/738wLrAtLtCtFOLvQBXOXp"
                    },
                    "href" : "https://api.spotify.com/v1/artists/738wLrAtLtCtFOLvQBXOXp",
                    "id" : "738wLrAtLtCtFOLvQBXOXp",
                    "name" : "Major Lazer",
                    "type" : "artist",
                    "uri" : "spotify:artist:738wLrAtLtCtFOLvQBXOXp"
                  } ],
                  "available_markets" : [ ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/4DOcG4A40Wf3q2vPNGQwQg"
                  },
                  "href" : "https://api.spotify.com/v1/albums/4DOcG4A40Wf3q2vPNGQwQg",
                  "id" : "4DOcG4A40Wf3q2vPNGQwQg",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/25c94ed54d2cd65ff9ad182f6a72c62f5e657fbe",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/6a18417aa31ba778a28bc0edc48addbf87a7dd9f",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/627825639a712adac59443465bd8bc6400238060",
                    "width" : 64
                  } ],
                  "name" : "Peace Is The Mission",
                  "type" : "album",
                  "uri" : "spotify:album:4DOcG4A40Wf3q2vPNGQwQg"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/738wLrAtLtCtFOLvQBXOXp"
                  },
                  "href" : "https://api.spotify.com/v1/artists/738wLrAtLtCtFOLvQBXOXp",
                  "id" : "738wLrAtLtCtFOLvQBXOXp",
                  "name" : "Major Lazer",
                  "type" : "artist",
                  "uri" : "spotify:artist:738wLrAtLtCtFOLvQBXOXp"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/0bdfiayQAKewqEvaU6rXCv"
                  },
                  "href" : "https://api.spotify.com/v1/artists/0bdfiayQAKewqEvaU6rXCv",
                  "id" : "0bdfiayQAKewqEvaU6rXCv",
                  "name" : "MØ",
                  "type" : "artist",
                  "uri" : "spotify:artist:0bdfiayQAKewqEvaU6rXCv"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/540vIaP2JwjQb9dm3aArA4"
                  },
                  "href" : "https://api.spotify.com/v1/artists/540vIaP2JwjQb9dm3aArA4",
                  "id" : "540vIaP2JwjQb9dm3aArA4",
                  "name" : "DJ Snake",
                  "type" : "artist",
                  "uri" : "spotify:artist:540vIaP2JwjQb9dm3aArA4"
                } ],
                "available_markets" : [ ],
                "disc_number" : 1,
                "duration_ms" : 176561,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "QMUY41500008"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/4vS8VaBwJJV5Ry7UFIQuoo"
                },
                "href" : "https://api.spotify.com/v1/tracks/4vS8VaBwJJV5Ry7UFIQuoo",
                "id" : "4vS8VaBwJJV5Ry7UFIQuoo",
                "name" : "Lean On (feat. MØ & DJ Snake)",
                "popularity" : 26,
                "preview_url" : null,
                "track_number" : 4,
                "type" : "track",
                "uri" : "spotify:track:4vS8VaBwJJV5Ry7UFIQuoo"
              }
            }, {
              "added_at" : "2015-12-13T06:50:06Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/69GGBxA162lTqCwzJG5jLp"
                    },
                    "href" : "https://api.spotify.com/v1/artists/69GGBxA162lTqCwzJG5jLp",
                    "id" : "69GGBxA162lTqCwzJG5jLp",
                    "name" : "The Chainsmokers",
                    "type" : "artist",
                    "uri" : "spotify:artist:69GGBxA162lTqCwzJG5jLp"
                  } ],
                  "available_markets" : [ "AD", "AR", "AU", "BE", "BG", "BO", "BR", "CA", "CL", "CO", "CR", "CY", "CZ", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/2GFflENKz28RcMoSuulPZC"
                  },
                  "href" : "https://api.spotify.com/v1/albums/2GFflENKz28RcMoSuulPZC",
                  "id" : "2GFflENKz28RcMoSuulPZC",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/d116e5ec74862d1f64a5b996131ffc1d1758730c",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/ce510f8529b0773042a3cafc3c4ed994f1a4f8cc",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/727b6bf5e9e45c3e39f413c3acf94fc45408a545",
                    "width" : 64
                  } ],
                  "name" : "Roses",
                  "type" : "album",
                  "uri" : "spotify:album:2GFflENKz28RcMoSuulPZC"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/69GGBxA162lTqCwzJG5jLp"
                  },
                  "href" : "https://api.spotify.com/v1/artists/69GGBxA162lTqCwzJG5jLp",
                  "id" : "69GGBxA162lTqCwzJG5jLp",
                  "name" : "The Chainsmokers",
                  "type" : "artist",
                  "uri" : "spotify:artist:69GGBxA162lTqCwzJG5jLp"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/6jsjhAEteAlY0vCiLvMLBA"
                  },
                  "href" : "https://api.spotify.com/v1/artists/6jsjhAEteAlY0vCiLvMLBA",
                  "id" : "6jsjhAEteAlY0vCiLvMLBA",
                  "name" : "ROZES",
                  "type" : "artist",
                  "uri" : "spotify:artist:6jsjhAEteAlY0vCiLvMLBA"
                } ],
                "available_markets" : [ "AD", "AR", "AU", "BE", "BG", "BO", "BR", "CA", "CL", "CO", "CR", "CY", "CZ", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                "disc_number" : 1,
                "duration_ms" : 226738,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "USQX91500801"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/3vv9phIu6Y1vX3jcqaGz5Z"
                },
                "href" : "https://api.spotify.com/v1/tracks/3vv9phIu6Y1vX3jcqaGz5Z",
                "id" : "3vv9phIu6Y1vX3jcqaGz5Z",
                "name" : "Roses",
                "popularity" : 79,
                "preview_url" : "https://p.scdn.co/mp3-preview/551ca104a8e572832a6873d5d6b205c430e291fd?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 1,
                "type" : "track",
                "uri" : "spotify:track:3vv9phIu6Y1vX3jcqaGz5Z"
              }
            }, {
              "added_at" : "2015-12-13T06:50:23Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/5R3Hr2cnCCjt220Jmt2xLf"
                    },
                    "href" : "https://api.spotify.com/v1/artists/5R3Hr2cnCCjt220Jmt2xLf",
                    "id" : "5R3Hr2cnCCjt220Jmt2xLf",
                    "name" : "Dillon Francis",
                    "type" : "artist",
                    "uri" : "spotify:artist:5R3Hr2cnCCjt220Jmt2xLf"
                  } ],
                  "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GR", "GT", "HK", "HN", "HU", "ID", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/5qhkVsNI6tr7mNRiY4mNe8"
                  },
                  "href" : "https://api.spotify.com/v1/albums/5qhkVsNI6tr7mNRiY4mNe8",
                  "id" : "5qhkVsNI6tr7mNRiY4mNe8",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/ff3d65d3d2e007e719a3f293da4b97749f7d6c57",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/8efccdc656ec48a67bf0b3a48bc0bf0b9cb6af91",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/9f51d8e0123a68d305337beafa9bc8e0bf6c6840",
                    "width" : 64
                  } ],
                  "name" : "I Can't Take It",
                  "type" : "album",
                  "uri" : "spotify:album:5qhkVsNI6tr7mNRiY4mNe8"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5R3Hr2cnCCjt220Jmt2xLf"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5R3Hr2cnCCjt220Jmt2xLf",
                  "id" : "5R3Hr2cnCCjt220Jmt2xLf",
                  "name" : "Dillon Francis",
                  "type" : "artist",
                  "uri" : "spotify:artist:5R3Hr2cnCCjt220Jmt2xLf"
                } ],
                "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GR", "GT", "HK", "HN", "HU", "ID", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                "disc_number" : 1,
                "duration_ms" : 262653,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "USSM11405584"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/64YnbVj5b9w0S3YjdaCl5F"
                },
                "href" : "https://api.spotify.com/v1/tracks/64YnbVj5b9w0S3YjdaCl5F",
                "id" : "64YnbVj5b9w0S3YjdaCl5F",
                "name" : "I Can't Take It",
                "popularity" : 32,
                "preview_url" : "https://p.scdn.co/mp3-preview/4139403e9c48dd1937be035b35d3b6bf0a3df0aa?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 1,
                "type" : "track",
                "uri" : "spotify:track:64YnbVj5b9w0S3YjdaCl5F"
              }
            }, {
              "added_at" : "2015-12-13T06:50:35Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/5ChF3i92IPZHduM7jN3dpg"
                    },
                    "href" : "https://api.spotify.com/v1/artists/5ChF3i92IPZHduM7jN3dpg",
                    "id" : "5ChF3i92IPZHduM7jN3dpg",
                    "name" : "Nicky Romero",
                    "type" : "artist",
                    "uri" : "spotify:artist:5ChF3i92IPZHduM7jN3dpg"
                  } ],
                  "available_markets" : [ "AD", "AR", "BG", "BO", "BR", "CA", "CL", "CR", "CY", "CZ", "DO", "ES", "FR", "GB", "GR", "HK", "HU", "ID", "IE", "IS", "LI", "MC", "MT", "MY", "PE", "PH", "PL", "PT", "PY", "SG", "SK", "TR", "TW", "US", "UY" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/5UADnciSlpDjscCw7YeKcQ"
                  },
                  "href" : "https://api.spotify.com/v1/albums/5UADnciSlpDjscCw7YeKcQ",
                  "id" : "5UADnciSlpDjscCw7YeKcQ",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/655dd5a905f2f11185251cd405af0786a77dd3b7",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/1b012c59de3df30e3cdfc6032ae288e444c3fc3d",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/b61f29a5d136c05bd22380cd9f70ad816c1f0914",
                    "width" : 64
                  } ],
                  "name" : "Symphonica",
                  "type" : "album",
                  "uri" : "spotify:album:5UADnciSlpDjscCw7YeKcQ"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5ChF3i92IPZHduM7jN3dpg"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5ChF3i92IPZHduM7jN3dpg",
                  "id" : "5ChF3i92IPZHduM7jN3dpg",
                  "name" : "Nicky Romero",
                  "type" : "artist",
                  "uri" : "spotify:artist:5ChF3i92IPZHduM7jN3dpg"
                } ],
                "available_markets" : [ "AD", "AR", "BG", "BO", "BR", "CA", "CL", "CR", "CY", "CZ", "DO", "ES", "FR", "GB", "GR", "HK", "HU", "ID", "IE", "IS", "LI", "MC", "MT", "MY", "PE", "PH", "PL", "PT", "PY", "SG", "SK", "TR", "TW", "US", "UY" ],
                "disc_number" : 1,
                "duration_ms" : 255095,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "NLUW21300036"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/7qlMFAGA90wJA7T1txvLI2"
                },
                "href" : "https://api.spotify.com/v1/tracks/7qlMFAGA90wJA7T1txvLI2",
                "id" : "7qlMFAGA90wJA7T1txvLI2",
                "name" : "Symphonica - Bare Remix",
                "popularity" : 37,
                "preview_url" : "https://p.scdn.co/mp3-preview/37f8a9c1ce0d701cefaf0b1d3123e1970bbbb687?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 4,
                "type" : "track",
                "uri" : "spotify:track:7qlMFAGA90wJA7T1txvLI2"
              }
            }, {
              "added_at" : "2015-12-13T06:50:52Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/5yG7ZAZafVaAlMTeBybKAL"
                    },
                    "href" : "https://api.spotify.com/v1/artists/5yG7ZAZafVaAlMTeBybKAL",
                    "id" : "5yG7ZAZafVaAlMTeBybKAL",
                    "name" : "Iggy Azalea",
                    "type" : "artist",
                    "uri" : "spotify:artist:5yG7ZAZafVaAlMTeBybKAL"
                  } ],
                  "available_markets" : [ "CA", "MX", "US" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/1sr29HNTdCXnpEJmp7CRJl"
                  },
                  "href" : "https://api.spotify.com/v1/albums/1sr29HNTdCXnpEJmp7CRJl",
                  "id" : "1sr29HNTdCXnpEJmp7CRJl",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/19dcf20a6913f1c21c9b986c55e133b052f9ec23",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/69a156def2bb168b57963e7d2334eb190c0c53d4",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/f6d4ed5c42d6041f925ea16c1cca2d4124402fde",
                    "width" : 64
                  } ],
                  "name" : "Black Widow (Remixes)",
                  "type" : "album",
                  "uri" : "spotify:album:1sr29HNTdCXnpEJmp7CRJl"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5yG7ZAZafVaAlMTeBybKAL"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5yG7ZAZafVaAlMTeBybKAL",
                  "id" : "5yG7ZAZafVaAlMTeBybKAL",
                  "name" : "Iggy Azalea",
                  "type" : "artist",
                  "uri" : "spotify:artist:5yG7ZAZafVaAlMTeBybKAL"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5CCwRZC6euC8Odo6y9X8jr"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5CCwRZC6euC8Odo6y9X8jr",
                  "id" : "5CCwRZC6euC8Odo6y9X8jr",
                  "name" : "Rita Ora",
                  "type" : "artist",
                  "uri" : "spotify:artist:5CCwRZC6euC8Odo6y9X8jr"
                } ],
                "available_markets" : [ "CA", "MX", "US" ],
                "disc_number" : 1,
                "duration_ms" : 219628,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "GBUM71403500"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/0eMmwSfos94bIabNba0fGm"
                },
                "href" : "https://api.spotify.com/v1/tracks/0eMmwSfos94bIabNba0fGm",
                "id" : "0eMmwSfos94bIabNba0fGm",
                "name" : "Black Widow - Vice Remix",
                "popularity" : 32,
                "preview_url" : "https://p.scdn.co/mp3-preview/f2e71bf3cc9d09f2cb205df4cff50fdd553a648e?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 1,
                "type" : "track",
                "uri" : "spotify:track:0eMmwSfos94bIabNba0fGm"
              }
            }, {
              "added_at" : "2015-12-13T06:51:14Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/5zOAmDnZqXZwqLt3JXqrRB"
                    },
                    "href" : "https://api.spotify.com/v1/artists/5zOAmDnZqXZwqLt3JXqrRB",
                    "id" : "5zOAmDnZqXZwqLt3JXqrRB",
                    "name" : "Oiki",
                    "type" : "artist",
                    "uri" : "spotify:artist:5zOAmDnZqXZwqLt3JXqrRB"
                  } ],
                  "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/0MMHcvve2oeMUQzqpj36K7"
                  },
                  "href" : "https://api.spotify.com/v1/albums/0MMHcvve2oeMUQzqpj36K7",
                  "id" : "0MMHcvve2oeMUQzqpj36K7",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/c6a62cf7ccb29ac587c792dafc015694ae8403ff",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/236a659bbc581f92906fa4021dfe33417e72bdd9",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/2391281ebd0bbbe7eb512bc1791df44c28fa6371",
                    "width" : 64
                  } ],
                  "name" : "Get It Now EP",
                  "type" : "album",
                  "uri" : "spotify:album:0MMHcvve2oeMUQzqpj36K7"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5zOAmDnZqXZwqLt3JXqrRB"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5zOAmDnZqXZwqLt3JXqrRB",
                  "id" : "5zOAmDnZqXZwqLt3JXqrRB",
                  "name" : "Oiki",
                  "type" : "artist",
                  "uri" : "spotify:artist:5zOAmDnZqXZwqLt3JXqrRB"
                } ],
                "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
                "disc_number" : 1,
                "duration_ms" : 229629,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "GBZCL1200071"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/23sSQdz3esjEa1m2SCE9yY"
                },
                "href" : "https://api.spotify.com/v1/tracks/23sSQdz3esjEa1m2SCE9yY",
                "id" : "23sSQdz3esjEa1m2SCE9yY",
                "name" : "Groove",
                "popularity" : 43,
                "preview_url" : "https://p.scdn.co/mp3-preview/e5846c684f4161467f528e3cedce24ca5d040202?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 2,
                "type" : "track",
                "uri" : "spotify:track:23sSQdz3esjEa1m2SCE9yY"
              }
            }, {
              "added_at" : "2015-12-13T07:04:32Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/6cEuCEZu7PAE9ZSzLLc2oQ"
                    },
                    "href" : "https://api.spotify.com/v1/artists/6cEuCEZu7PAE9ZSzLLc2oQ",
                    "id" : "6cEuCEZu7PAE9ZSzLLc2oQ",
                    "name" : "R3HAB",
                    "type" : "artist",
                    "uri" : "spotify:artist:6cEuCEZu7PAE9ZSzLLc2oQ"
                  }, {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/4JprKwueQv8ws3n7N8BLVC"
                    },
                    "href" : "https://api.spotify.com/v1/artists/4JprKwueQv8ws3n7N8BLVC",
                    "id" : "4JprKwueQv8ws3n7N8BLVC",
                    "name" : "SOLANO",
                    "type" : "artist",
                    "uri" : "spotify:artist:4JprKwueQv8ws3n7N8BLVC"
                  } ],
                  "available_markets" : [ "AD", "AT", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CY", "CZ", "DE", "DO", "FR", "GB", "GR", "HU", "IE", "IS", "LI", "LU", "MC", "MT", "NL", "PT", "PY", "SK", "TR", "US", "UY" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/5GqaKx70x3KS24X6vtBHOq"
                  },
                  "href" : "https://api.spotify.com/v1/albums/5GqaKx70x3KS24X6vtBHOq",
                  "id" : "5GqaKx70x3KS24X6vtBHOq",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/a34499e6e93a573f2d716426220241377f9397d2",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/df2b8faebba239d835656ec7c3123ea787f5b86c",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/61c791f549bb990b6201d830edf97b47caa24c48",
                    "width" : 64
                  } ],
                  "name" : "Do It (Life In Color Anthem 2013)",
                  "type" : "album",
                  "uri" : "spotify:album:5GqaKx70x3KS24X6vtBHOq"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/6cEuCEZu7PAE9ZSzLLc2oQ"
                  },
                  "href" : "https://api.spotify.com/v1/artists/6cEuCEZu7PAE9ZSzLLc2oQ",
                  "id" : "6cEuCEZu7PAE9ZSzLLc2oQ",
                  "name" : "R3HAB",
                  "type" : "artist",
                  "uri" : "spotify:artist:6cEuCEZu7PAE9ZSzLLc2oQ"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/4JprKwueQv8ws3n7N8BLVC"
                  },
                  "href" : "https://api.spotify.com/v1/artists/4JprKwueQv8ws3n7N8BLVC",
                  "id" : "4JprKwueQv8ws3n7N8BLVC",
                  "name" : "SOLANO",
                  "type" : "artist",
                  "uri" : "spotify:artist:4JprKwueQv8ws3n7N8BLVC"
                } ],
                "available_markets" : [ "AD", "AT", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CY", "CZ", "DE", "DO", "FR", "GB", "GR", "HU", "IE", "IS", "LI", "LU", "MC", "MT", "NL", "PT", "PY", "SK", "TR", "US", "UY" ],
                "disc_number" : 1,
                "duration_ms" : 270000,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "NLZ541200081"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/0gsNhrPTTkJNk3YLMWUvPT"
                },
                "href" : "https://api.spotify.com/v1/tracks/0gsNhrPTTkJNk3YLMWUvPT",
                "id" : "0gsNhrPTTkJNk3YLMWUvPT",
                "name" : "Do It (Life In Color Anthem 2013) - Original Mix",
                "popularity" : 27,
                "preview_url" : "https://p.scdn.co/mp3-preview/437e826aaab013ea3611715718e637ec227519a6?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 1,
                "type" : "track",
                "uri" : "spotify:track:0gsNhrPTTkJNk3YLMWUvPT"
              }
            }, {
              "added_at" : "2015-12-13T07:04:43Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "single",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/60d24wfXkVzDSfLS6hyCjZ"
                    },
                    "href" : "https://api.spotify.com/v1/artists/60d24wfXkVzDSfLS6hyCjZ",
                    "id" : "60d24wfXkVzDSfLS6hyCjZ",
                    "name" : "Martin Garrix",
                    "type" : "artist",
                    "uri" : "spotify:artist:60d24wfXkVzDSfLS6hyCjZ"
                  } ],
                  "available_markets" : [ "CA", "MX", "US" ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/55HXtmTsfepv0mY9vIIFhi"
                  },
                  "href" : "https://api.spotify.com/v1/albums/55HXtmTsfepv0mY9vIIFhi",
                  "id" : "55HXtmTsfepv0mY9vIIFhi",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/ac1bcc75724708579e0612d78e2bae633ad17327",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/596ee16c6de3b32be102bb5f51035c6672e07e96",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/3e4827f128e9be40303b7e1935a37a59f91c9261",
                    "width" : 64
                  } ],
                  "name" : "Animals (Extended)",
                  "type" : "album",
                  "uri" : "spotify:album:55HXtmTsfepv0mY9vIIFhi"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/60d24wfXkVzDSfLS6hyCjZ"
                  },
                  "href" : "https://api.spotify.com/v1/artists/60d24wfXkVzDSfLS6hyCjZ",
                  "id" : "60d24wfXkVzDSfLS6hyCjZ",
                  "name" : "Martin Garrix",
                  "type" : "artist",
                  "uri" : "spotify:artist:60d24wfXkVzDSfLS6hyCjZ"
                } ],
                "available_markets" : [ "CA", "MX", "US" ],
                "disc_number" : 1,
                "duration_ms" : 303826,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "AUNV01301212"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/6JEntXLt4z98CcDtIH9sU7"
                },
                "href" : "https://api.spotify.com/v1/tracks/6JEntXLt4z98CcDtIH9sU7",
                "id" : "6JEntXLt4z98CcDtIH9sU7",
                "name" : "Animals - Extended",
                "popularity" : 62,
                "preview_url" : "https://p.scdn.co/mp3-preview/4dab7ed43b695473e65b89995da32c1e09239337?cid=8897482848704f2a8f8d7c79726a70d4",
                "track_number" : 1,
                "type" : "track",
                "uri" : "spotify:track:6JEntXLt4z98CcDtIH9sU7"
              }
            }, {
              "added_at" : "2015-12-13T07:35:52Z",
              "added_by" : {
                "external_urls" : {
                  "spotify" : "http://open.spotify.com/user/ahavermale"
                },
                "href" : "https://api.spotify.com/v1/users/ahavermale",
                "id" : "ahavermale",
                "type" : "user",
                "uri" : "spotify:user:ahavermale"
              },
              "is_local" : false,
              "track" : {
                "album" : {
                  "album_type" : "album",
                  "artists" : [ {
                    "external_urls" : {
                      "spotify" : "https://open.spotify.com/artist/5fMUXHkw8R8eOP2RNVYEZX"
                    },
                    "href" : "https://api.spotify.com/v1/artists/5fMUXHkw8R8eOP2RNVYEZX",
                    "id" : "5fMUXHkw8R8eOP2RNVYEZX",
                    "name" : "Diplo",
                    "type" : "artist",
                    "uri" : "spotify:artist:5fMUXHkw8R8eOP2RNVYEZX"
                  } ],
                  "available_markets" : [ ],
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/album/5M0Jehr5jJAwdd23KwvayA"
                  },
                  "href" : "https://api.spotify.com/v1/albums/5M0Jehr5jJAwdd23KwvayA",
                  "id" : "5M0Jehr5jJAwdd23KwvayA",
                  "images" : [ {
                    "height" : 640,
                    "url" : "https://i.scdn.co/image/81067bcb1e1eccb76f5cf5518c78c6ca1ecd5ae6",
                    "width" : 640
                  }, {
                    "height" : 300,
                    "url" : "https://i.scdn.co/image/fc440546e875279a28123a3337ccd9a8fad23e0d",
                    "width" : 300
                  }, {
                    "height" : 64,
                    "url" : "https://i.scdn.co/image/9b1da9086fa39b46f887afdec38c2bd7a668ad8a",
                    "width" : 64
                  } ],
                  "name" : "Revolution",
                  "type" : "album",
                  "uri" : "spotify:album:5M0Jehr5jJAwdd23KwvayA"
                },
                "artists" : [ {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/5fMUXHkw8R8eOP2RNVYEZX"
                  },
                  "href" : "https://api.spotify.com/v1/artists/5fMUXHkw8R8eOP2RNVYEZX",
                  "id" : "5fMUXHkw8R8eOP2RNVYEZX",
                  "name" : "Diplo",
                  "type" : "artist",
                  "uri" : "spotify:artist:5fMUXHkw8R8eOP2RNVYEZX"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/6jPriOYMyUL9kNonBI1CNd"
                  },
                  "href" : "https://api.spotify.com/v1/artists/6jPriOYMyUL9kNonBI1CNd",
                  "id" : "6jPriOYMyUL9kNonBI1CNd",
                  "name" : "Faustix",
                  "type" : "artist",
                  "uri" : "spotify:artist:6jPriOYMyUL9kNonBI1CNd"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/26fsavNxrXVdRK7wL3jZKb"
                  },
                  "href" : "https://api.spotify.com/v1/artists/26fsavNxrXVdRK7wL3jZKb",
                  "id" : "26fsavNxrXVdRK7wL3jZKb",
                  "name" : "Imanos",
                  "type" : "artist",
                  "uri" : "spotify:artist:26fsavNxrXVdRK7wL3jZKb"
                }, {
                  "external_urls" : {
                    "spotify" : "https://open.spotify.com/artist/07cXXY7NDK9oWLUvPfUVvx"
                  },
                  "href" : "https://api.spotify.com/v1/artists/07cXXY7NDK9oWLUvPfUVvx",
                  "id" : "07cXXY7NDK9oWLUvPfUVvx",
                  "name" : "Kai",
                  "type" : "artist",
                  "uri" : "spotify:artist:07cXXY7NDK9oWLUvPfUVvx"
                } ],
                "available_markets" : [ ],
                "disc_number" : 1,
                "duration_ms" : 263716,
                "explicit" : false,
                "external_ids" : {
                  "isrc" : "USZ4V1300249"
                },
                "external_urls" : {
                  "spotify" : "https://open.spotify.com/track/5zG4pMcM2QILFOFL3Y3ZMf"
                },
                "href" : "https://api.spotify.com/v1/tracks/5zG4pMcM2QILFOFL3Y3ZMf",
                "id" : "5zG4pMcM2QILFOFL3Y3ZMf",
                "name" : "Revolution (feat. Faustix, Imanos & Kai)",
                "popularity" : 19,
                "preview_url" : null,
                "track_number" : 2,
                "type" : "track",
                "uri" : "spotify:track:5zG4pMcM2QILFOFL3Y3ZMf"
              }
            } ],
            "limit" : 100,
            "next" : null,
            "offset" : 0,
            "previous" : null,
            "total" : 9
          },
          "type" : "playlist",
          "uri" : "spotify:user:ahavermale:playlist:1dm9phr0m51fcFcEEumCW7"
        }
        """.data(using: .utf8)!
    }
}
