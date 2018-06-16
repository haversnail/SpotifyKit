//
//  Track.swift
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

let trackData = """
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
    
let trackArrayData = """
{
  "tracks" : [ {
    "artists" : [ {
      "external_urls" : {
        "spotify" : "https://open.spotify.com/artist/6FQqZYVfTNQ1pCqfkwVFEa"
      },
      "href" : "https://api.spotify.com/v1/artists/6FQqZYVfTNQ1pCqfkwVFEa",
      "id" : "6FQqZYVfTNQ1pCqfkwVFEa",
      "name" : "Foals",
      "type" : "artist",
      "uri" : "spotify:artist:6FQqZYVfTNQ1pCqfkwVFEa"
    } ],
    "disc_number" : 1,
    "duration_ms" : 244293,
    "explicit" : false,
    "external_urls" : {
      "spotify" : "https://open.spotify.com/track/53L6A3I9vf7rgEZnMzx54E"
    },
    "href" : "https://api.spotify.com/v1/tracks/53L6A3I9vf7rgEZnMzx54E",
    "id" : "53L6A3I9vf7rgEZnMzx54E",
    "name" : "Mountain At My Gates",
    "popularity" : 72,
    "preview_url" : "https://p.scdn.co/mp3-preview/8814a6a480833a971a92e75476787a8d5ad82987?cid=8897482848704f2a8f8d7c79726a70d4",
    "track_number" : 2,
    "type" : "track",
    "uri" : "spotify:track:53L6A3I9vf7rgEZnMzx54E"
  }, {
    "artists" : [ {
      "external_urls" : {
        "spotify" : "https://open.spotify.com/artist/4kI8Ie27vjvonwaB2ePh8T"
      },
      "href" : "https://api.spotify.com/v1/artists/4kI8Ie27vjvonwaB2ePh8T",
      "id" : "4kI8Ie27vjvonwaB2ePh8T",
      "name" : "Portugal. The Man",
      "type" : "artist",
      "uri" : "spotify:artist:4kI8Ie27vjvonwaB2ePh8T"
    } ],
    "disc_number" : 1,
    "duration_ms" : 163250,
    "explicit" : false,
    "external_urls" : {
      "spotify" : "https://open.spotify.com/track/7FESgYLcOufHqKlwrvJN60"
    },
    "href" : "https://api.spotify.com/v1/tracks/7FESgYLcOufHqKlwrvJN60",
    "id" : "7FESgYLcOufHqKlwrvJN60",
    "name" : "Feel It Still",
    "popularity" : 89,
    "preview_url" : "https://p.scdn.co/mp3-preview/5b50706cd5bbadf1c77cba0d7a5b883c84d2c808?cid=8897482848704f2a8f8d7c79726a70d4",
    "track_number" : 1,
    "type" : "track",
    "uri" : "spotify:track:7FESgYLcOufHqKlwrvJN60"
  }, {
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
    "external_urls" : {
      "spotify" : "https://open.spotify.com/track/7g1YqCZblmFepoevFFVP7t"
    },
    "href" : "https://api.spotify.com/v1/tracks/7g1YqCZblmFepoevFFVP7t",
    "id" : "7g1YqCZblmFepoevFFVP7t",
    "name" : "My Thing",
    "popularity" : 16,
    "preview_url" : "https://p.scdn.co/mp3-preview/36b1991141d0721a7e55530d6fe9786d1cdd3593?cid=8897482848704f2a8f8d7c79726a70d4",
    "track_number" : 1,
    "type" : "track",
    "uri" : "spotify:track:7g1YqCZblmFepoevFFVP7t"
  } ]
}
""".data(using: .utf8)!
