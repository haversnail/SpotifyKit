//
//  Album.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/23/17.
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

let albumData = """
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
    
    
let albumArrayData = """
{
  "albums" : [ {
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
    "popularity" : 71,
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
  }, {
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
    "popularity" : 14,
    "release_date" : "2014-10-21",
    "release_date_precision" : "day",
    "tracks" : {
      "href" : "https://api.spotify.com/v1/albums/01x41UlgUnQ3QX5OLcIKFo/tracks?offset=0&limit=50&market=US",
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
        "disc_number" : 1,
        "duration_ms" : 188106,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/1bbcAQuGuAxKS1HM96B8uh"
        },
        "href" : "https://api.spotify.com/v1/tracks/1bbcAQuGuAxKS1HM96B8uh",
        "id" : "1bbcAQuGuAxKS1HM96B8uh",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/2bVZ9Mbq0roH4gJpGdioaH"
          },
          "href" : "https://api.spotify.com/v1/tracks/2bVZ9Mbq0roH4gJpGdioaH",
          "id" : "2bVZ9Mbq0roH4gJpGdioaH",
          "type" : "track",
          "uri" : "spotify:track:2bVZ9Mbq0roH4gJpGdioaH"
        },
        "name" : "All This Could Be Yours",
        "preview_url" : "https://p.scdn.co/mp3-preview/b96ee60a696bff29eba0c6f23179468bad73d109?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 1,
        "type" : "track",
        "uri" : "spotify:track:1bbcAQuGuAxKS1HM96B8uh"
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
        "disc_number" : 1,
        "duration_ms" : 200360,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/3omXshBamrREltcf24gYDC"
        },
        "href" : "https://api.spotify.com/v1/tracks/3omXshBamrREltcf24gYDC",
        "id" : "3omXshBamrREltcf24gYDC",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/0aGSUNleFqs5HNEJcwqvXJ"
          },
          "href" : "https://api.spotify.com/v1/tracks/0aGSUNleFqs5HNEJcwqvXJ",
          "id" : "0aGSUNleFqs5HNEJcwqvXJ",
          "type" : "track",
          "uri" : "spotify:track:0aGSUNleFqs5HNEJcwqvXJ"
        },
        "name" : "First",
        "preview_url" : "https://p.scdn.co/mp3-preview/ee25473cc7d176aa27654960edebe9cae1ddac04?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 2,
        "type" : "track",
        "uri" : "spotify:track:3omXshBamrREltcf24gYDC"
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
        "disc_number" : 1,
        "duration_ms" : 208186,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/4en5ctJhiQ22NQXyaQfP3h"
        },
        "href" : "https://api.spotify.com/v1/tracks/4en5ctJhiQ22NQXyaQfP3h",
        "id" : "4en5ctJhiQ22NQXyaQfP3h",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/4W4ADEUUrMze7ENcVnoCBc"
          },
          "href" : "https://api.spotify.com/v1/tracks/4W4ADEUUrMze7ENcVnoCBc",
          "id" : "4W4ADEUUrMze7ENcVnoCBc",
          "type" : "track",
          "uri" : "spotify:track:4W4ADEUUrMze7ENcVnoCBc"
        },
        "name" : "Hot Coals",
        "preview_url" : "https://p.scdn.co/mp3-preview/c140e8c5657220693acff24d3b2cd4598c05dcfa?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 3,
        "type" : "track",
        "uri" : "spotify:track:4en5ctJhiQ22NQXyaQfP3h"
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
        "disc_number" : 1,
        "duration_ms" : 250066,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/0tvnwVLYmxltTClAgDQ6iZ"
        },
        "href" : "https://api.spotify.com/v1/tracks/0tvnwVLYmxltTClAgDQ6iZ",
        "id" : "0tvnwVLYmxltTClAgDQ6iZ",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/5i5Nv3Dy3toiu22r0ALKYn"
          },
          "href" : "https://api.spotify.com/v1/tracks/5i5Nv3Dy3toiu22r0ALKYn",
          "id" : "5i5Nv3Dy3toiu22r0ALKYn",
          "type" : "track",
          "uri" : "spotify:track:5i5Nv3Dy3toiu22r0ALKYn"
        },
        "name" : "Drive Desperate",
        "preview_url" : "https://p.scdn.co/mp3-preview/ce1012ee2d9b526be77ac6860113db2511c34bd0?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 4,
        "type" : "track",
        "uri" : "spotify:track:0tvnwVLYmxltTClAgDQ6iZ"
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
        "disc_number" : 1,
        "duration_ms" : 190560,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/2lQiYJ1j0YDbI0XFCjHOqp"
        },
        "href" : "https://api.spotify.com/v1/tracks/2lQiYJ1j0YDbI0XFCjHOqp",
        "id" : "2lQiYJ1j0YDbI0XFCjHOqp",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/6XFaVikwKqVAk0KLEN7wAr"
          },
          "href" : "https://api.spotify.com/v1/tracks/6XFaVikwKqVAk0KLEN7wAr",
          "id" : "6XFaVikwKqVAk0KLEN7wAr",
          "type" : "track",
          "uri" : "spotify:track:6XFaVikwKqVAk0KLEN7wAr"
        },
        "name" : "Hotel Anywhere",
        "preview_url" : "https://p.scdn.co/mp3-preview/d744a4d731fa045b6ea3475f4df89ffcc322db1f?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 5,
        "type" : "track",
        "uri" : "spotify:track:2lQiYJ1j0YDbI0XFCjHOqp"
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
        "disc_number" : 1,
        "duration_ms" : 231080,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/00QVLE1c8gZh3tAoxCpPPx"
        },
        "href" : "https://api.spotify.com/v1/tracks/00QVLE1c8gZh3tAoxCpPPx",
        "id" : "00QVLE1c8gZh3tAoxCpPPx",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/4fXSqiV0lwQK4uTv3fBXJQ"
          },
          "href" : "https://api.spotify.com/v1/tracks/4fXSqiV0lwQK4uTv3fBXJQ",
          "id" : "4fXSqiV0lwQK4uTv3fBXJQ",
          "type" : "track",
          "uri" : "spotify:track:4fXSqiV0lwQK4uTv3fBXJQ"
        },
        "name" : "Go Quietly",
        "preview_url" : "https://p.scdn.co/mp3-preview/67ce34a99cc83c454fc64c76917e5d053cec2fc9?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 6,
        "type" : "track",
        "uri" : "spotify:track:00QVLE1c8gZh3tAoxCpPPx"
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
        "disc_number" : 1,
        "duration_ms" : 174333,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/3FsVv1bvnLZfizQC5sbkmH"
        },
        "href" : "https://api.spotify.com/v1/tracks/3FsVv1bvnLZfizQC5sbkmH",
        "id" : "3FsVv1bvnLZfizQC5sbkmH",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/3Fga96eKJ4UtwhKXNzNl4Q"
          },
          "href" : "https://api.spotify.com/v1/tracks/3Fga96eKJ4UtwhKXNzNl4Q",
          "id" : "3Fga96eKJ4UtwhKXNzNl4Q",
          "type" : "track",
          "uri" : "spotify:track:3Fga96eKJ4UtwhKXNzNl4Q"
        },
        "name" : "Nights & Weekends",
        "preview_url" : "https://p.scdn.co/mp3-preview/f63952ced1a6fdc198156976d1d89ddfbde5a72a?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 7,
        "type" : "track",
        "uri" : "spotify:track:3FsVv1bvnLZfizQC5sbkmH"
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
        "disc_number" : 1,
        "duration_ms" : 170120,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/0rdDsipOqcoq9Zdq5Nzp4b"
        },
        "href" : "https://api.spotify.com/v1/tracks/0rdDsipOqcoq9Zdq5Nzp4b",
        "id" : "0rdDsipOqcoq9Zdq5Nzp4b",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/5vyzCnN7XOY8N9UeJvDc3v"
          },
          "href" : "https://api.spotify.com/v1/tracks/5vyzCnN7XOY8N9UeJvDc3v",
          "id" : "5vyzCnN7XOY8N9UeJvDc3v",
          "type" : "track",
          "uri" : "spotify:track:5vyzCnN7XOY8N9UeJvDc3v"
        },
        "name" : "Hold My Home",
        "preview_url" : "https://p.scdn.co/mp3-preview/e1f0e40bcafa2b17cadb8248e02465665a22472d?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 8,
        "type" : "track",
        "uri" : "spotify:track:0rdDsipOqcoq9Zdq5Nzp4b"
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
        "disc_number" : 1,
        "duration_ms" : 216826,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/2tYs3OlGM8064SZmnpmFub"
        },
        "href" : "https://api.spotify.com/v1/tracks/2tYs3OlGM8064SZmnpmFub",
        "id" : "2tYs3OlGM8064SZmnpmFub",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/6j3HA7HRVWZ9OtXe9H4ScD"
          },
          "href" : "https://api.spotify.com/v1/tracks/6j3HA7HRVWZ9OtXe9H4ScD",
          "id" : "6j3HA7HRVWZ9OtXe9H4ScD",
          "type" : "track",
          "uri" : "spotify:track:6j3HA7HRVWZ9OtXe9H4ScD"
        },
        "name" : "Flower Drum Song",
        "preview_url" : "https://p.scdn.co/mp3-preview/8a3cd1ef2d0cee3161e927e22cf245083de1c673?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 9,
        "type" : "track",
        "uri" : "spotify:track:2tYs3OlGM8064SZmnpmFub"
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
        "disc_number" : 1,
        "duration_ms" : 252026,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/37VVnzWHrFEIsPLKPbEhcr"
        },
        "href" : "https://api.spotify.com/v1/tracks/37VVnzWHrFEIsPLKPbEhcr",
        "id" : "37VVnzWHrFEIsPLKPbEhcr",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/0qQ2EKimGM7DHgrPEMCjK0"
          },
          "href" : "https://api.spotify.com/v1/tracks/0qQ2EKimGM7DHgrPEMCjK0",
          "id" : "0qQ2EKimGM7DHgrPEMCjK0",
          "type" : "track",
          "uri" : "spotify:track:0qQ2EKimGM7DHgrPEMCjK0"
        },
        "name" : "Harold Bloom",
        "preview_url" : "https://p.scdn.co/mp3-preview/9fbc51911bcffc878f97e74ae4360f9755df5192?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 10,
        "type" : "track",
        "uri" : "spotify:track:37VVnzWHrFEIsPLKPbEhcr"
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
        "disc_number" : 1,
        "duration_ms" : 290546,
        "explicit" : false,
        "external_urls" : {
          "spotify" : "https://open.spotify.com/track/6YgrUfBxbPr8G9KvqtbYlx"
        },
        "href" : "https://api.spotify.com/v1/tracks/6YgrUfBxbPr8G9KvqtbYlx",
        "id" : "6YgrUfBxbPr8G9KvqtbYlx",
        "is_playable" : true,
        "linked_from" : {
          "external_urls" : {
            "spotify" : "https://open.spotify.com/track/1N8F9fAimcsggWDbdehE9a"
          },
          "href" : "https://api.spotify.com/v1/tracks/1N8F9fAimcsggWDbdehE9a",
          "id" : "1N8F9fAimcsggWDbdehE9a",
          "type" : "track",
          "uri" : "spotify:track:1N8F9fAimcsggWDbdehE9a"
        },
        "name" : "Hear My Baby Call",
        "preview_url" : "https://p.scdn.co/mp3-preview/f94638df96586a7852dc414aa4a43009869b54b7?cid=8897482848704f2a8f8d7c79726a70d4",
        "track_number" : 11,
        "type" : "track",
        "uri" : "spotify:track:6YgrUfBxbPr8G9KvqtbYlx"
      } ],
      "limit" : 50,
      "next" : null,
      "offset" : 0,
      "previous" : null,
      "total" : 11
    },
    "type" : "album",
    "uri" : "spotify:album:01x41UlgUnQ3QX5OLcIKFo"
  } ]
}
""".data(using: .utf8)!
