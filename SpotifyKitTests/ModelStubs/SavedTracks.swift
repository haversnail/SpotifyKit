//
//  SavedTracks.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/25/17.
//  Copyright © 2018 Alex Havermale.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

let savedTrackData = """
{
  "href" : "https://api.spotify.com/v1/me/tracks?offset=0&limit=20",
  "items" : [ {
    "added_at" : "2017-07-16T04:14:18Z",
    "track" : {
      "album" : {
        "album_type" : "single",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/1Hsdzj7Dlq2I7tHP7501T4"
          },
          "href" : "https://api.spotify.com/v1/artists/1Hsdzj7Dlq2I7tHP7501T4",
          "id" : "1Hsdzj7Dlq2I7tHP7501T4",
          "name" : "Niall Horan",
          "type" : "artist",
          "uri" : "spotify:artist:1Hsdzj7Dlq2I7tHP7501T4"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/6nkXOiymyczxK1XCZW5HEk"
        },
        "href" : "https://api.spotify.com/v1/albums/6nkXOiymyczxK1XCZW5HEk",
        "id" : "6nkXOiymyczxK1XCZW5HEk",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/d9d8c852cbabe26a09699e1403a7cad69539a7de",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/aa42adbdd526eee8b85837719c737551cc54d3d5",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/469f4277529b24fb6aa630f99be87a58792ff871",
          "width" : 64
        } ],
        "name" : "Slow Hands",
        "type" : "album",
        "uri" : "spotify:album:6nkXOiymyczxK1XCZW5HEk"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/1Hsdzj7Dlq2I7tHP7501T4"
        },
        "href" : "https://api.spotify.com/v1/artists/1Hsdzj7Dlq2I7tHP7501T4",
        "id" : "1Hsdzj7Dlq2I7tHP7501T4",
        "name" : "Niall Horan",
        "type" : "artist",
        "uri" : "spotify:artist:1Hsdzj7Dlq2I7tHP7501T4"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 188174,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUG11700631"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/27vTihlWXiz9f9lJM3XGVU"
      },
      "href" : "https://api.spotify.com/v1/tracks/27vTihlWXiz9f9lJM3XGVU",
      "id" : "27vTihlWXiz9f9lJM3XGVU",
      "name" : "Slow Hands",
      "popularity" : 87,
      "preview_url" : "https://p.scdn.co/mp3-preview/659e46145518ca359367aaa7a37ed50faf77c6cc?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:27vTihlWXiz9f9lJM3XGVU"
    }
  }, {
    "added_at" : "2017-07-16T04:13:48Z",
    "track" : {
      "album" : {
        "album_type" : "single",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/1Hsdzj7Dlq2I7tHP7501T4"
          },
          "href" : "https://api.spotify.com/v1/artists/1Hsdzj7Dlq2I7tHP7501T4",
          "id" : "1Hsdzj7Dlq2I7tHP7501T4",
          "name" : "Niall Horan",
          "type" : "artist",
          "uri" : "spotify:artist:1Hsdzj7Dlq2I7tHP7501T4"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/02TJBSiAtYZK35RaoOkvpG"
        },
        "href" : "https://api.spotify.com/v1/albums/02TJBSiAtYZK35RaoOkvpG",
        "id" : "02TJBSiAtYZK35RaoOkvpG",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/ac9c5b6bbbc1991d953d4c63acbc3276e4c3e701",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/6e26721a7325e8fe2294a5dbc10089677d66d40a",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/1d795e8d5ad72e89eccb6a4352354e351b3d56dd",
          "width" : 64
        } ],
        "name" : "This Town",
        "type" : "album",
        "uri" : "spotify:album:02TJBSiAtYZK35RaoOkvpG"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/1Hsdzj7Dlq2I7tHP7501T4"
        },
        "href" : "https://api.spotify.com/v1/artists/1Hsdzj7Dlq2I7tHP7501T4",
        "id" : "1Hsdzj7Dlq2I7tHP7501T4",
        "name" : "Niall Horan",
        "type" : "artist",
        "uri" : "spotify:artist:1Hsdzj7Dlq2I7tHP7501T4"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 232600,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUG11601029"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5dTJMpqiELczVuHJP3OAEu"
      },
      "href" : "https://api.spotify.com/v1/tracks/5dTJMpqiELczVuHJP3OAEu",
      "id" : "5dTJMpqiELczVuHJP3OAEu",
      "name" : "This Town",
      "popularity" : 76,
      "preview_url" : "https://p.scdn.co/mp3-preview/07156cbdc223ea2135d3ffe67189278f5a1019a7?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:5dTJMpqiELczVuHJP3OAEu"
    }
  }, {
    "added_at" : "2017-07-16T04:12:59Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6KImCVD70vtIoJWnq6nGn3"
          },
          "href" : "https://api.spotify.com/v1/artists/6KImCVD70vtIoJWnq6nGn3",
          "id" : "6KImCVD70vtIoJWnq6nGn3",
          "name" : "Harry Styles",
          "type" : "artist",
          "uri" : "spotify:artist:6KImCVD70vtIoJWnq6nGn3"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/1FZKIm3JVDCxTchXDo5jOV"
        },
        "href" : "https://api.spotify.com/v1/albums/1FZKIm3JVDCxTchXDo5jOV",
        "id" : "1FZKIm3JVDCxTchXDo5jOV",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/d4e1e36b7115e645dc6fd432cdd3ea7c0c4d939a",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/2faf14c121b01bde63b55fdc9fbb3ddeec2ad48d",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/f842de1f2db71f3b1a0eb6172b4d33615edaa0ca",
          "width" : 64
        } ],
        "name" : "Harry Styles",
        "type" : "album",
        "uri" : "spotify:album:1FZKIm3JVDCxTchXDo5jOV"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/6KImCVD70vtIoJWnq6nGn3"
        },
        "href" : "https://api.spotify.com/v1/artists/6KImCVD70vtIoJWnq6nGn3",
        "id" : "6KImCVD70vtIoJWnq6nGn3",
        "name" : "Harry Styles",
        "type" : "artist",
        "uri" : "spotify:artist:6KImCVD70vtIoJWnq6nGn3"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 224866,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USSM11703956"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5kRPPEWFJIMox5qIkQkiz5"
      },
      "href" : "https://api.spotify.com/v1/tracks/5kRPPEWFJIMox5qIkQkiz5",
      "id" : "5kRPPEWFJIMox5qIkQkiz5",
      "name" : "Sweet Creature",
      "popularity" : 79,
      "preview_url" : "https://p.scdn.co/mp3-preview/c6545e608f8a8790f65edb274e92bdc6d4b133d5?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 5,
      "type" : "track",
      "uri" : "spotify:track:5kRPPEWFJIMox5qIkQkiz5"
    }
  }, {
    "added_at" : "2017-07-16T04:12:24Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6KImCVD70vtIoJWnq6nGn3"
          },
          "href" : "https://api.spotify.com/v1/artists/6KImCVD70vtIoJWnq6nGn3",
          "id" : "6KImCVD70vtIoJWnq6nGn3",
          "name" : "Harry Styles",
          "type" : "artist",
          "uri" : "spotify:artist:6KImCVD70vtIoJWnq6nGn3"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/1FZKIm3JVDCxTchXDo5jOV"
        },
        "href" : "https://api.spotify.com/v1/albums/1FZKIm3JVDCxTchXDo5jOV",
        "id" : "1FZKIm3JVDCxTchXDo5jOV",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/d4e1e36b7115e645dc6fd432cdd3ea7c0c4d939a",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/2faf14c121b01bde63b55fdc9fbb3ddeec2ad48d",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/f842de1f2db71f3b1a0eb6172b4d33615edaa0ca",
          "width" : 64
        } ],
        "name" : "Harry Styles",
        "type" : "album",
        "uri" : "spotify:album:1FZKIm3JVDCxTchXDo5jOV"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/6KImCVD70vtIoJWnq6nGn3"
        },
        "href" : "https://api.spotify.com/v1/artists/6KImCVD70vtIoJWnq6nGn3",
        "id" : "6KImCVD70vtIoJWnq6nGn3",
        "name" : "Harry Styles",
        "type" : "artist",
        "uri" : "spotify:artist:6KImCVD70vtIoJWnq6nGn3"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 340706,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USSM11703595"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5Ohxk2dO5COHF1krpoPigN"
      },
      "href" : "https://api.spotify.com/v1/tracks/5Ohxk2dO5COHF1krpoPigN",
      "id" : "5Ohxk2dO5COHF1krpoPigN",
      "name" : "Sign of the Times",
      "popularity" : 86,
      "preview_url" : "https://p.scdn.co/mp3-preview/af237206f611b722f48620ece049aff3b8650e77?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 2,
      "type" : "track",
      "uri" : "spotify:track:5Ohxk2dO5COHF1krpoPigN"
    }
  }, {
    "added_at" : "2017-07-14T16:21:03Z",
    "track" : {
      "album" : {
        "album_type" : "single",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0C8ZW7ezQVs4URX5aX7Kqx"
          },
          "href" : "https://api.spotify.com/v1/artists/0C8ZW7ezQVs4URX5aX7Kqx",
          "id" : "0C8ZW7ezQVs4URX5aX7Kqx",
          "name" : "Selena Gomez",
          "type" : "artist",
          "uri" : "spotify:artist:0C8ZW7ezQVs4URX5aX7Kqx"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/1iuzMKNzVo8HJ67eW32YMr"
        },
        "href" : "https://api.spotify.com/v1/albums/1iuzMKNzVo8HJ67eW32YMr",
        "id" : "1iuzMKNzVo8HJ67eW32YMr",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/9dd1e1d6fb23eba7e77ea2d59fef6b721696b2fa",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/a71a59d6e21de92a24bbbf9a5225c2a34fc84fa7",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/2bef947d4575c8417547fd0f68d673057bee1716",
          "width" : 64
        } ],
        "name" : "Bad Liar",
        "type" : "album",
        "uri" : "spotify:album:1iuzMKNzVo8HJ67eW32YMr"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0C8ZW7ezQVs4URX5aX7Kqx"
        },
        "href" : "https://api.spotify.com/v1/artists/0C8ZW7ezQVs4URX5aX7Kqx",
        "id" : "0C8ZW7ezQVs4URX5aX7Kqx",
        "name" : "Selena Gomez",
        "type" : "artist",
        "uri" : "spotify:artist:0C8ZW7ezQVs4URX5aX7Kqx"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 214647,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71704121"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/2fZQIJew3nkNe99s2PKzul"
      },
      "href" : "https://api.spotify.com/v1/tracks/2fZQIJew3nkNe99s2PKzul",
      "id" : "2fZQIJew3nkNe99s2PKzul",
      "name" : "Bad Liar",
      "popularity" : 88,
      "preview_url" : "https://p.scdn.co/mp3-preview/10d3eec1b509098a7e4704c99e21f6547e6510e9?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:2fZQIJew3nkNe99s2PKzul"
    }
  }, {
    "added_at" : "2017-07-10T02:34:12Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6vWDO969PvNqNYHIOW5v0m"
          },
          "href" : "https://api.spotify.com/v1/artists/6vWDO969PvNqNYHIOW5v0m",
          "id" : "6vWDO969PvNqNYHIOW5v0m",
          "name" : "Beyoncé",
          "type" : "artist",
          "uri" : "spotify:artist:6vWDO969PvNqNYHIOW5v0m"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/2UJwKSBUz6rtW4QLK74kQu"
        },
        "href" : "https://api.spotify.com/v1/albums/2UJwKSBUz6rtW4QLK74kQu",
        "id" : "2UJwKSBUz6rtW4QLK74kQu",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/98be8968e1c29e6ef80831c5867733d2e687b508",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/a986d5fe5780115541b5c33e89ed66272e5d4c0f",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/20787cddd28d8b7335f9cc8baff2b097d27558d1",
          "width" : 64
        } ],
        "name" : "BEYONCÉ [Platinum Edition]",
        "type" : "album",
        "uri" : "spotify:album:2UJwKSBUz6rtW4QLK74kQu"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/6vWDO969PvNqNYHIOW5v0m"
        },
        "href" : "https://api.spotify.com/v1/artists/6vWDO969PvNqNYHIOW5v0m",
        "id" : "6vWDO969PvNqNYHIOW5v0m",
        "name" : "Beyoncé",
        "type" : "artist",
        "uri" : "spotify:artist:6vWDO969PvNqNYHIOW5v0m"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 319466,
      "explicit" : true,
      "external_ids" : {
        "isrc" : "USSM11307803"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5hgnY0mVcVetszbb85qeDg"
      },
      "href" : "https://api.spotify.com/v1/tracks/5hgnY0mVcVetszbb85qeDg",
      "id" : "5hgnY0mVcVetszbb85qeDg",
      "name" : "Partition",
      "popularity" : 72,
      "preview_url" : "https://p.scdn.co/mp3-preview/8ecd5010e5a46f1c84f42bcfed50505395825d7a?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 6,
      "type" : "track",
      "uri" : "spotify:track:5hgnY0mVcVetszbb85qeDg"
    }
  }, {
    "added_at" : "2017-07-02T11:37:33Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q"
          },
          "href" : "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q",
          "id" : "53XhwfbYqKCa1cC15pYq2q",
          "name" : "Imagine Dragons",
          "type" : "artist",
          "uri" : "spotify:artist:53XhwfbYqKCa1cC15pYq2q"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/51s30K7a36ORx6AAaPBRRY"
        },
        "href" : "https://api.spotify.com/v1/albums/51s30K7a36ORx6AAaPBRRY",
        "id" : "51s30K7a36ORx6AAaPBRRY",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/84989ed4cca6518fa540bb3c8a7a73127695e937",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/049e099bf5a62637f4d2b629b9e76c5f8e198f88",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/8d078b173edc3a3780801f5f01ce9b4b9ce3d016",
          "width" : 64
        } ],
        "name" : "Evolve",
        "type" : "album",
        "uri" : "spotify:album:51s30K7a36ORx6AAaPBRRY"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q"
        },
        "href" : "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q",
        "id" : "53XhwfbYqKCa1cC15pYq2q",
        "name" : "Imagine Dragons",
        "type" : "artist",
        "uri" : "spotify:artist:53XhwfbYqKCa1cC15pYq2q"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 187146,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71704167"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5VnDkUNyX6u5Sk0yZiP8XB"
      },
      "href" : "https://api.spotify.com/v1/tracks/5VnDkUNyX6u5Sk0yZiP8XB",
      "id" : "5VnDkUNyX6u5Sk0yZiP8XB",
      "name" : "Thunder",
      "popularity" : 86,
      "preview_url" : "https://p.scdn.co/mp3-preview/daf9962fa32c82670e87d85166c1058b52a96419?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 9,
      "type" : "track",
      "uri" : "spotify:track:5VnDkUNyX6u5Sk0yZiP8XB"
    }
  }, {
    "added_at" : "2017-07-02T11:36:52Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/6Wr3hh341P84m3EI8qdn9O"
          },
          "href" : "https://api.spotify.com/v1/artists/6Wr3hh341P84m3EI8qdn9O",
          "id" : "6Wr3hh341P84m3EI8qdn9O",
          "name" : "Rise Against",
          "type" : "artist",
          "uri" : "spotify:artist:6Wr3hh341P84m3EI8qdn9O"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/1vHYkIhnwbpzrC3hGguDN6"
        },
        "href" : "https://api.spotify.com/v1/albums/1vHYkIhnwbpzrC3hGguDN6",
        "id" : "1vHYkIhnwbpzrC3hGguDN6",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/8bd92d3256a5f5ce9dd793684452c1121368b91e",
          "width" : 629
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/34c1275d125f01fa04ed3185af787aefedc86449",
          "width" : 295
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/f48246025daf16caf040df661648b583b06c747f",
          "width" : 63
        } ],
        "name" : "Siren Song Of The Counter-Culture",
        "type" : "album",
        "uri" : "spotify:album:1vHYkIhnwbpzrC3hGguDN6"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/6Wr3hh341P84m3EI8qdn9O"
        },
        "href" : "https://api.spotify.com/v1/artists/6Wr3hh341P84m3EI8qdn9O",
        "id" : "6Wr3hh341P84m3EI8qdn9O",
        "name" : "Rise Against",
        "type" : "artist",
        "uri" : "spotify:artist:6Wr3hh341P84m3EI8qdn9O"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 200066,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USDW10400796"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/6GrrkiCRO3HYdgRpO4eKEL"
      },
      "href" : "https://api.spotify.com/v1/tracks/6GrrkiCRO3HYdgRpO4eKEL",
      "id" : "6GrrkiCRO3HYdgRpO4eKEL",
      "name" : "Swing Life Away",
      "popularity" : 60,
      "preview_url" : "https://p.scdn.co/mp3-preview/2157ddf46cf110ed3e61e4d7c540e6cce4dedfdb?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 11,
      "type" : "track",
      "uri" : "spotify:track:6GrrkiCRO3HYdgRpO4eKEL"
    }
  }, {
    "added_at" : "2017-07-01T19:56:00Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/5BcAKTbp20cv7tC5VqPFoC"
          },
          "href" : "https://api.spotify.com/v1/artists/5BcAKTbp20cv7tC5VqPFoC",
          "id" : "5BcAKTbp20cv7tC5VqPFoC",
          "name" : "Macklemore & Ryan Lewis",
          "type" : "artist",
          "uri" : "spotify:artist:5BcAKTbp20cv7tC5VqPFoC"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/2kqn09pydzvKvB3xWbAxY4"
        },
        "href" : "https://api.spotify.com/v1/albums/2kqn09pydzvKvB3xWbAxY4",
        "id" : "2kqn09pydzvKvB3xWbAxY4",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/7f2fc9c49e8016a239fd7c3b098bd356980f8e8b",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/0ae6a6a694a03323cb1320b8e50df925e6d8e019",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/b9ad172fa718c27c69916603b5ad903413d94dbb",
          "width" : 64
        } ],
        "name" : "This Unruly Mess I've Made",
        "type" : "album",
        "uri" : "spotify:album:2kqn09pydzvKvB3xWbAxY4"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/5BcAKTbp20cv7tC5VqPFoC"
        },
        "href" : "https://api.spotify.com/v1/artists/5BcAKTbp20cv7tC5VqPFoC",
        "id" : "5BcAKTbp20cv7tC5VqPFoC",
        "name" : "Macklemore & Ryan Lewis",
        "type" : "artist",
        "uri" : "spotify:artist:5BcAKTbp20cv7tC5VqPFoC"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/6QeZTS8BrU3r2TYJdA68j9"
        },
        "href" : "https://api.spotify.com/v1/artists/6QeZTS8BrU3r2TYJdA68j9",
        "id" : "6QeZTS8BrU3r2TYJdA68j9",
        "name" : "Grandmaster Caz",
        "type" : "artist",
        "uri" : "spotify:artist:6QeZTS8BrU3r2TYJdA68j9"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0AWhixY9hX7LEPyPMjh4O0"
        },
        "href" : "https://api.spotify.com/v1/artists/0AWhixY9hX7LEPyPMjh4O0",
        "id" : "0AWhixY9hX7LEPyPMjh4O0",
        "name" : "Grandmaster Melle Mel",
        "type" : "artist",
        "uri" : "spotify:artist:0AWhixY9hX7LEPyPMjh4O0"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/3NoeRIxHApi6qe4yan2Vnn"
        },
        "href" : "https://api.spotify.com/v1/artists/3NoeRIxHApi6qe4yan2Vnn",
        "id" : "3NoeRIxHApi6qe4yan2Vnn",
        "name" : "Eric Nally",
        "type" : "artist",
        "uri" : "spotify:artist:3NoeRIxHApi6qe4yan2Vnn"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/2RE8NwNxsOyuNZDD0jRxHP"
        },
        "href" : "https://api.spotify.com/v1/artists/2RE8NwNxsOyuNZDD0jRxHP",
        "id" : "2RE8NwNxsOyuNZDD0jRxHP",
        "name" : "Kool Moe Dee",
        "type" : "artist",
        "uri" : "spotify:artist:2RE8NwNxsOyuNZDD0jRxHP"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 292593,
      "explicit" : true,
      "external_ids" : {
        "isrc" : "GMM881500002"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5pfJsMwoRYKampPay8amX0"
      },
      "href" : "https://api.spotify.com/v1/tracks/5pfJsMwoRYKampPay8amX0",
      "id" : "5pfJsMwoRYKampPay8amX0",
      "name" : "Downtown (feat. Melle Mel, Grandmaster Caz, Kool Moe Dee & Eric Nally)",
      "popularity" : 73,
      "preview_url" : "https://p.scdn.co/mp3-preview/40ca4e22a5276cc715a6616f0698ca9be99f79c4?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 2,
      "type" : "track",
      "uri" : "spotify:track:5pfJsMwoRYKampPay8amX0"
    }
  }, {
    "added_at" : "2017-07-01T19:54:49Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/4BxCuXFJrSWGi1KHcVqaU4"
          },
          "href" : "https://api.spotify.com/v1/artists/4BxCuXFJrSWGi1KHcVqaU4",
          "id" : "4BxCuXFJrSWGi1KHcVqaU4",
          "name" : "Kodaline",
          "type" : "artist",
          "uri" : "spotify:artist:4BxCuXFJrSWGi1KHcVqaU4"
        } ],
        "available_markets" : [ "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/29Tc7Ue6KVfc5mzXxoMgEL"
        },
        "href" : "https://api.spotify.com/v1/albums/29Tc7Ue6KVfc5mzXxoMgEL",
        "id" : "29Tc7Ue6KVfc5mzXxoMgEL",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/a9f7701e1176921ecdbf9d67ca73062948d81f3a",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/b4d3bb12d58d48277968924cd5b64c22bb13d871",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/586a8d8adaf0e6f741557893ee93a9fa6f9b47a6",
          "width" : 64
        } ],
        "name" : "In A Perfect World",
        "type" : "album",
        "uri" : "spotify:album:29Tc7Ue6KVfc5mzXxoMgEL"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/4BxCuXFJrSWGi1KHcVqaU4"
        },
        "href" : "https://api.spotify.com/v1/artists/4BxCuXFJrSWGi1KHcVqaU4",
        "id" : "4BxCuXFJrSWGi1KHcVqaU4",
        "name" : "Kodaline",
        "type" : "artist",
        "uri" : "spotify:artist:4BxCuXFJrSWGi1KHcVqaU4"
      } ],
      "available_markets" : [ "US" ],
      "disc_number" : 1,
      "duration_ms" : 305746,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "GBDVX1200008"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/2PwXOevGUSkU8qaYZjgLq2"
      },
      "href" : "https://api.spotify.com/v1/tracks/2PwXOevGUSkU8qaYZjgLq2",
      "id" : "2PwXOevGUSkU8qaYZjgLq2",
      "name" : "All I Want",
      "popularity" : 70,
      "preview_url" : "https://p.scdn.co/mp3-preview/ee5e210cdea9f22e545ea435c0467dcecdeb41ca?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 2,
      "type" : "track",
      "uri" : "spotify:track:2PwXOevGUSkU8qaYZjgLq2"
    }
  }, {
    "added_at" : "2017-07-01T19:50:54Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/5Pwc4xIPtQLFEnJriah9YJ"
          },
          "href" : "https://api.spotify.com/v1/artists/5Pwc4xIPtQLFEnJriah9YJ",
          "id" : "5Pwc4xIPtQLFEnJriah9YJ",
          "name" : "OneRepublic",
          "type" : "artist",
          "uri" : "spotify:artist:5Pwc4xIPtQLFEnJriah9YJ"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/2bbhW5ifCwOYM8DMkqoYBF"
        },
        "href" : "https://api.spotify.com/v1/albums/2bbhW5ifCwOYM8DMkqoYBF",
        "id" : "2bbhW5ifCwOYM8DMkqoYBF",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/8b6238186da6c5c9b0ff756065883aa1a8fbd339",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/3f4ed4e1bfe1acc966762ca838b49e2c3550a1c0",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/29e961f88981da505ba8f7290db2a568c2a1e428",
          "width" : 64
        } ],
        "name" : "Native",
        "type" : "album",
        "uri" : "spotify:album:2bbhW5ifCwOYM8DMkqoYBF"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/5Pwc4xIPtQLFEnJriah9YJ"
        },
        "href" : "https://api.spotify.com/v1/artists/5Pwc4xIPtQLFEnJriah9YJ",
        "id" : "5Pwc4xIPtQLFEnJriah9YJ",
        "name" : "OneRepublic",
        "type" : "artist",
        "uri" : "spotify:artist:5Pwc4xIPtQLFEnJriah9YJ"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 257839,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71301306"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/6sy3LkhNFjJWlaeSMNwQ62"
      },
      "href" : "https://api.spotify.com/v1/tracks/6sy3LkhNFjJWlaeSMNwQ62",
      "id" : "6sy3LkhNFjJWlaeSMNwQ62",
      "name" : "Counting Stars",
      "popularity" : 76,
      "preview_url" : "https://p.scdn.co/mp3-preview/7d912bf0960b8e0b4f783a4f866b3650f0e00b2e?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:6sy3LkhNFjJWlaeSMNwQ62"
    }
  }, {
    "added_at" : "2017-07-01T19:46:56Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
          },
          "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
          "id" : "0RpddSzUHfncUWNJXKOsjy",
          "name" : "Neon Trees",
          "type" : "artist",
          "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/6Xi4dJ9SudvC0ZoE5Krh3G"
        },
        "href" : "https://api.spotify.com/v1/albums/6Xi4dJ9SudvC0ZoE5Krh3G",
        "id" : "6Xi4dJ9SudvC0ZoE5Krh3G",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/a2e7181041221fd29e8d1162660e4f88cdc55255",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/5fa7beb7ad0ef0c56b93b37207e4988e1f5fcf4f",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/3a3cf69219faa58611e55f96daeda2f8dab9dfa1",
          "width" : 64
        } ],
        "name" : "Pop Psychology",
        "type" : "album",
        "uri" : "spotify:album:6Xi4dJ9SudvC0ZoE5Krh3G"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
        },
        "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
        "id" : "0RpddSzUHfncUWNJXKOsjy",
        "name" : "Neon Trees",
        "type" : "artist",
        "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 185320,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71403710"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/49aUxHONjkn75EJFd30RRr"
      },
      "href" : "https://api.spotify.com/v1/tracks/49aUxHONjkn75EJFd30RRr",
      "id" : "49aUxHONjkn75EJFd30RRr",
      "name" : "Text Me In The Morning",
      "popularity" : 43,
      "preview_url" : "https://p.scdn.co/mp3-preview/99beb3ad4b3fb2640a2a117014e016dfd8156c33?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 2,
      "type" : "track",
      "uri" : "spotify:track:49aUxHONjkn75EJFd30RRr"
    }
  }, {
    "added_at" : "2017-07-01T19:45:23Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
          },
          "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
          "id" : "0RpddSzUHfncUWNJXKOsjy",
          "name" : "Neon Trees",
          "type" : "artist",
          "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/7xpjpdislqMXOCw5xsDt4g"
        },
        "href" : "https://api.spotify.com/v1/albums/7xpjpdislqMXOCw5xsDt4g",
        "id" : "7xpjpdislqMXOCw5xsDt4g",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/722f069ef2fec928f7cb7c1a66e96b58de4d06b5",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/fe7eb8e6493045f97c862d54c5f92bb3f4ea4ae1",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/bbba08ee98bc4d84385cb661699cf4b673cc5ccf",
          "width" : 64
        } ],
        "name" : "Habits",
        "type" : "album",
        "uri" : "spotify:album:7xpjpdislqMXOCw5xsDt4g"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
        },
        "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
        "id" : "0RpddSzUHfncUWNJXKOsjy",
        "name" : "Neon Trees",
        "type" : "artist",
        "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 212293,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71001801"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/1fBl642IhJOE5U319Gy2Go"
      },
      "href" : "https://api.spotify.com/v1/tracks/1fBl642IhJOE5U319Gy2Go",
      "id" : "1fBl642IhJOE5U319Gy2Go",
      "name" : "Animal",
      "popularity" : 63,
      "preview_url" : "https://p.scdn.co/mp3-preview/ef9ec69607d6a702529135a859c149eed2198a68?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:1fBl642IhJOE5U319Gy2Go"
    }
  }, {
    "added_at" : "2017-07-01T19:45:03Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
          },
          "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
          "id" : "0RpddSzUHfncUWNJXKOsjy",
          "name" : "Neon Trees",
          "type" : "artist",
          "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/7hPNlDBLv1EW8GakiIzFnn"
        },
        "href" : "https://api.spotify.com/v1/albums/7hPNlDBLv1EW8GakiIzFnn",
        "id" : "7hPNlDBLv1EW8GakiIzFnn",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/79bacc54355382d7abd7b9bd0a466cae390bb9af",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/00c2bd951c68d323a68ebb7ceb9a8cb914fa40af",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/174d14e40ba57c602f2e092d5109bbb684f70de3",
          "width" : 64
        } ],
        "name" : "Picture Show (Deluxe Edition)",
        "type" : "album",
        "uri" : "spotify:album:7hPNlDBLv1EW8GakiIzFnn"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
        },
        "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
        "id" : "0RpddSzUHfncUWNJXKOsjy",
        "name" : "Neon Trees",
        "type" : "artist",
        "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 177280,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71119189"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/3528IXKpbb7OMjdjWYlbfD"
      },
      "href" : "https://api.spotify.com/v1/tracks/3528IXKpbb7OMjdjWYlbfD",
      "id" : "3528IXKpbb7OMjdjWYlbfD",
      "name" : "Everybody Talks",
      "popularity" : 68,
      "preview_url" : "https://p.scdn.co/mp3-preview/b2dacb8f300802739f5648c374d7e51c4442d739?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:3528IXKpbb7OMjdjWYlbfD"
    }
  }, {
    "added_at" : "2017-07-01T14:10:32Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q"
          },
          "href" : "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q",
          "id" : "53XhwfbYqKCa1cC15pYq2q",
          "name" : "Imagine Dragons",
          "type" : "artist",
          "uri" : "spotify:artist:53XhwfbYqKCa1cC15pYq2q"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/51s30K7a36ORx6AAaPBRRY"
        },
        "href" : "https://api.spotify.com/v1/albums/51s30K7a36ORx6AAaPBRRY",
        "id" : "51s30K7a36ORx6AAaPBRRY",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/84989ed4cca6518fa540bb3c8a7a73127695e937",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/049e099bf5a62637f4d2b629b9e76c5f8e198f88",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/8d078b173edc3a3780801f5f01ce9b4b9ce3d016",
          "width" : 64
        } ],
        "name" : "Evolve",
        "type" : "album",
        "uri" : "spotify:album:51s30K7a36ORx6AAaPBRRY"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q"
        },
        "href" : "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q",
        "id" : "53XhwfbYqKCa1cC15pYq2q",
        "name" : "Imagine Dragons",
        "type" : "artist",
        "uri" : "spotify:artist:53XhwfbYqKCa1cC15pYq2q"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 204346,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71700626"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/1NtIMM4N0cFa1dNzN15chl"
      },
      "href" : "https://api.spotify.com/v1/tracks/1NtIMM4N0cFa1dNzN15chl",
      "id" : "1NtIMM4N0cFa1dNzN15chl",
      "name" : "Believer",
      "popularity" : 87,
      "preview_url" : "https://p.scdn.co/mp3-preview/9723a765a7228f524b5a186f015219dbc7e0aae1?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:1NtIMM4N0cFa1dNzN15chl"
    }
  }, {
    "added_at" : "2017-07-01T14:10:04Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
          },
          "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
          "id" : "0RpddSzUHfncUWNJXKOsjy",
          "name" : "Neon Trees",
          "type" : "artist",
          "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/6Xi4dJ9SudvC0ZoE5Krh3G"
        },
        "href" : "https://api.spotify.com/v1/albums/6Xi4dJ9SudvC0ZoE5Krh3G",
        "id" : "6Xi4dJ9SudvC0ZoE5Krh3G",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/a2e7181041221fd29e8d1162660e4f88cdc55255",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/5fa7beb7ad0ef0c56b93b37207e4988e1f5fcf4f",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/3a3cf69219faa58611e55f96daeda2f8dab9dfa1",
          "width" : 64
        } ],
        "name" : "Pop Psychology",
        "type" : "album",
        "uri" : "spotify:album:6Xi4dJ9SudvC0ZoE5Krh3G"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0RpddSzUHfncUWNJXKOsjy"
        },
        "href" : "https://api.spotify.com/v1/artists/0RpddSzUHfncUWNJXKOsjy",
        "id" : "0RpddSzUHfncUWNJXKOsjy",
        "name" : "Neon Trees",
        "type" : "artist",
        "uri" : "spotify:artist:0RpddSzUHfncUWNJXKOsjy"
      } ],
      "available_markets" : [ "CA", "MX", "US" ],
      "disc_number" : 1,
      "duration_ms" : 228840,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71319540"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/0K1KOCeJBj3lpDYxEX9qP2"
      },
      "href" : "https://api.spotify.com/v1/tracks/0K1KOCeJBj3lpDYxEX9qP2",
      "id" : "0K1KOCeJBj3lpDYxEX9qP2",
      "name" : "Sleeping With A Friend",
      "popularity" : 59,
      "preview_url" : "https://p.scdn.co/mp3-preview/d0de3f15802077125dfec5313e45e421231fafe1?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:0K1KOCeJBj3lpDYxEX9qP2"
    }
  }, {
    "added_at" : "2017-06-19T06:00:09Z",
    "track" : {
      "album" : {
        "album_type" : "single",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/2DlGxzQSjYe5N6G9nkYghR"
          },
          "href" : "https://api.spotify.com/v1/artists/2DlGxzQSjYe5N6G9nkYghR",
          "id" : "2DlGxzQSjYe5N6G9nkYghR",
          "name" : "Jennifer Lopez",
          "type" : "artist",
          "uri" : "spotify:artist:2DlGxzQSjYe5N6G9nkYghR"
        } ],
        "available_markets" : [ "CA", "MX", "US" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/5afRtOFscJUQq7nCbHR5Rn"
        },
        "href" : "https://api.spotify.com/v1/albums/5afRtOFscJUQq7nCbHR5Rn",
        "id" : "5afRtOFscJUQq7nCbHR5Rn",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/fe73e43ea06209fa8b6513911f9bde4e31b5e945",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/07cfdd55794b4505b81739ce0004f54decc78632",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/7cc633771f39ef9b0a1b308cad2b6a7c3bc0fdfa",
          "width" : 64
        } ],
        "name" : "Booty",
        "type" : "album",
        "uri" : "spotify:album:5afRtOFscJUQq7nCbHR5Rn"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/2DlGxzQSjYe5N6G9nkYghR"
        },
        "href" : "https://api.spotify.com/v1/artists/2DlGxzQSjYe5N6G9nkYghR",
        "id" : "2DlGxzQSjYe5N6G9nkYghR",
        "name" : "Jennifer Lopez",
        "type" : "artist",
        "uri" : "spotify:artist:2DlGxzQSjYe5N6G9nkYghR"
      }, {
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
      "disc_number" : 1,
      "duration_ms" : 209699,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USUM71413813"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/6dshconh2KBbGxVh7GtSTC"
      },
      "href" : "https://api.spotify.com/v1/tracks/6dshconh2KBbGxVh7GtSTC",
      "id" : "6dshconh2KBbGxVh7GtSTC",
      "name" : "Booty",
      "popularity" : 62,
      "preview_url" : "https://p.scdn.co/mp3-preview/dff96e78755dbb735460dbc36b1957292c2f3799?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:6dshconh2KBbGxVh7GtSTC"
    }
  }, {
    "added_at" : "2017-06-19T05:59:58Z",
    "track" : {
      "album" : {
        "album_type" : "album",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/07YZf4WDAMNwqr4jfgOZ8y"
          },
          "href" : "https://api.spotify.com/v1/artists/07YZf4WDAMNwqr4jfgOZ8y",
          "id" : "07YZf4WDAMNwqr4jfgOZ8y",
          "name" : "Jason Derulo",
          "type" : "artist",
          "uri" : "spotify:artist:07YZf4WDAMNwqr4jfgOZ8y"
        } ],
        "available_markets" : [ "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IT", "JP", "LT", "LU", "LV", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/59eUYETmE1zi31ESb3SUkI"
        },
        "href" : "https://api.spotify.com/v1/albums/59eUYETmE1zi31ESb3SUkI",
        "id" : "59eUYETmE1zi31ESb3SUkI",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/d4e179cf14800ae015c18029aa7f6b35a3c1a29a",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/6db4601516dd20b3bc19279bfdbcb168c2335c3c",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/943ec26cc94b2a222d4d1fcba682aeba4b2310eb",
          "width" : 64
        } ],
        "name" : "Everything Is 4",
        "type" : "album",
        "uri" : "spotify:album:59eUYETmE1zi31ESb3SUkI"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/07YZf4WDAMNwqr4jfgOZ8y"
        },
        "href" : "https://api.spotify.com/v1/artists/07YZf4WDAMNwqr4jfgOZ8y",
        "id" : "07YZf4WDAMNwqr4jfgOZ8y",
        "name" : "Jason Derulo",
        "type" : "artist",
        "uri" : "spotify:artist:07YZf4WDAMNwqr4jfgOZ8y"
      } ],
      "available_markets" : [ "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IT", "JP", "LT", "LU", "LV", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 200492,
      "explicit" : true,
      "external_ids" : {
        "isrc" : "USWB11504036"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/1dl3vuXJS9anUXE7XnNP75"
      },
      "href" : "https://api.spotify.com/v1/tracks/1dl3vuXJS9anUXE7XnNP75",
      "id" : "1dl3vuXJS9anUXE7XnNP75",
      "name" : "Get Ugly",
      "popularity" : 72,
      "preview_url" : "https://p.scdn.co/mp3-preview/8ab11d3d98e01500a849f8713eabb6af766bdbf4?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:1dl3vuXJS9anUXE7XnNP75"
    }
  }, {
    "added_at" : "2017-06-18T05:48:53Z",
    "track" : {
      "album" : {
        "album_type" : "single",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/07YZf4WDAMNwqr4jfgOZ8y"
          },
          "href" : "https://api.spotify.com/v1/artists/07YZf4WDAMNwqr4jfgOZ8y",
          "id" : "07YZf4WDAMNwqr4jfgOZ8y",
          "name" : "Jason Derulo",
          "type" : "artist",
          "uri" : "spotify:artist:07YZf4WDAMNwqr4jfgOZ8y"
        }, {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/0hCNtLu0JehylgoiP8L4Gh"
          },
          "href" : "https://api.spotify.com/v1/artists/0hCNtLu0JehylgoiP8L4Gh",
          "id" : "0hCNtLu0JehylgoiP8L4Gh",
          "name" : "Nicki Minaj",
          "type" : "artist",
          "uri" : "spotify:artist:0hCNtLu0JehylgoiP8L4Gh"
        }, {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/7c0XG5cIJTrrAgEC3ULPiq"
          },
          "href" : "https://api.spotify.com/v1/artists/7c0XG5cIJTrrAgEC3ULPiq",
          "id" : "7c0XG5cIJTrrAgEC3ULPiq",
          "name" : "Ty Dolla $ign",
          "type" : "artist",
          "uri" : "spotify:artist:7c0XG5cIJTrrAgEC3ULPiq"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/2e5CxfyEwBW115beiwh7Mc"
        },
        "href" : "https://api.spotify.com/v1/albums/2e5CxfyEwBW115beiwh7Mc",
        "id" : "2e5CxfyEwBW115beiwh7Mc",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/87d0b1856d2c2ce55fdb4c8129e47a6df6f33aff",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/8662260c958cbc63a0f0c671cc95de5bf14f59f2",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/2800e9f3f5aadf99620ef196b0d94e602128539f",
          "width" : 64
        } ],
        "name" : "Swalla (feat. Nicki Minaj & Ty Dolla $ign)",
        "type" : "album",
        "uri" : "spotify:album:2e5CxfyEwBW115beiwh7Mc"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/07YZf4WDAMNwqr4jfgOZ8y"
        },
        "href" : "https://api.spotify.com/v1/artists/07YZf4WDAMNwqr4jfgOZ8y",
        "id" : "07YZf4WDAMNwqr4jfgOZ8y",
        "name" : "Jason Derulo",
        "type" : "artist",
        "uri" : "spotify:artist:07YZf4WDAMNwqr4jfgOZ8y"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/0hCNtLu0JehylgoiP8L4Gh"
        },
        "href" : "https://api.spotify.com/v1/artists/0hCNtLu0JehylgoiP8L4Gh",
        "id" : "0hCNtLu0JehylgoiP8L4Gh",
        "name" : "Nicki Minaj",
        "type" : "artist",
        "uri" : "spotify:artist:0hCNtLu0JehylgoiP8L4Gh"
      }, {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/7c0XG5cIJTrrAgEC3ULPiq"
        },
        "href" : "https://api.spotify.com/v1/artists/7c0XG5cIJTrrAgEC3ULPiq",
        "id" : "7c0XG5cIJTrrAgEC3ULPiq",
        "name" : "Ty Dolla $ign",
        "type" : "artist",
        "uri" : "spotify:artist:7c0XG5cIJTrrAgEC3ULPiq"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 216408,
      "explicit" : true,
      "external_ids" : {
        "isrc" : "USWB11700237"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/6kex4EBAj0WHXDKZMEJaaF"
      },
      "href" : "https://api.spotify.com/v1/tracks/6kex4EBAj0WHXDKZMEJaaF",
      "id" : "6kex4EBAj0WHXDKZMEJaaF",
      "name" : "Swalla (feat. Nicki Minaj & Ty Dolla $ign)",
      "popularity" : 96,
      "preview_url" : "https://p.scdn.co/mp3-preview/9aa4e0500aae8b33d04f031c454688890ab06468?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 1,
      "type" : "track",
      "uri" : "spotify:track:6kex4EBAj0WHXDKZMEJaaF"
    }
  }, {
    "added_at" : "2017-06-17T00:40:41Z",
    "track" : {
      "album" : {
        "album_type" : "compilation",
        "artists" : [ {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/artist/4EnEZVjo3w1cwcQYePccay"
          },
          "href" : "https://api.spotify.com/v1/artists/4EnEZVjo3w1cwcQYePccay",
          "id" : "4EnEZVjo3w1cwcQYePccay",
          "name" : "N.W.A.",
          "type" : "artist",
          "uri" : "spotify:artist:4EnEZVjo3w1cwcQYePccay"
        } ],
        "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/1RcZMUVcZrMxf1shgPN4o0"
        },
        "href" : "https://api.spotify.com/v1/albums/1RcZMUVcZrMxf1shgPN4o0",
        "id" : "1RcZMUVcZrMxf1shgPN4o0",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/18ce2931823963c4099f7be06150b98ab72949ee",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/b4cb8d8e727e04aa1b1e4754ffa3fe44a01e2cad",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/eab9e28869448bb0b4b6c4dee7152fd6c76ecab9",
          "width" : 64
        } ],
        "name" : "The Best Of N.W.A: The Strength Of Street Knowledge",
        "type" : "album",
        "uri" : "spotify:album:1RcZMUVcZrMxf1shgPN4o0"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/7B4hKK0S9QYnaoqa9OuwgX"
        },
        "href" : "https://api.spotify.com/v1/artists/7B4hKK0S9QYnaoqa9OuwgX",
        "id" : "7B4hKK0S9QYnaoqa9OuwgX",
        "name" : "Eazy-E",
        "type" : "artist",
        "uri" : "spotify:artist:7B4hKK0S9QYnaoqa9OuwgX"
      } ],
      "available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "US", "UY" ],
      "disc_number" : 1,
      "duration_ms" : 336960,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "USPO18700101"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/4SZ3B3y1TbwTK4OIXMOVEy"
      },
      "href" : "https://api.spotify.com/v1/tracks/4SZ3B3y1TbwTK4OIXMOVEy",
      "id" : "4SZ3B3y1TbwTK4OIXMOVEy",
      "name" : "Boyz-N-The-Hood",
      "popularity" : 60,
      "preview_url" : "https://p.scdn.co/mp3-preview/d453438b323a636135853280ac0eb7acacfe567a?cid=8897482848704f2a8f8d7c79726a70d4",
      "track_number" : 12,
      "type" : "track",
      "uri" : "spotify:track:4SZ3B3y1TbwTK4OIXMOVEy"
    }
  } ],
  "limit" : 20,
  "next" : "https://api.spotify.com/v1/me/tracks?offset=20&limit=20",
  "offset" : 0,
  "previous" : null,
  "total" : 433
}
""".data(using: .utf8)!
