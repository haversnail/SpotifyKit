//
//  Artist.swift
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

let artistData = """
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

let simplifiedArtistData = """
{
  "external_urls" : {
    "spotify" : "https://open.spotify.com/artist/6VDdCwrBM4qQaGxoAyxyJC"
  },
  "href" : "https://api.spotify.com/v1/artists/6VDdCwrBM4qQaGxoAyxyJC",
  "id" : "6VDdCwrBM4qQaGxoAyxyJC",
  "name" : "Cold War Kids",
  "type" : "artist",
  "uri" : "spotify:artist:6VDdCwrBM4qQaGxoAyxyJC"
}
""".data(using: .utf8)!

let artistArrayData = """
{
  "artists" : [ {
    "external_urls" : {
      "spotify" : "https://open.spotify.com/artist/3vbKDsSS70ZX9D2OcvbZmS"
    },
    "followers" : {
      "href" : null,
      "total" : 657741
    },
    "genres" : [ "alternative rock", "anti-folk", "blues-rock", "electronic", "folk christmas", "garage rock", "indie christmas", "indie rock", "modern rock", "neo-psychedelic", "permanent wave", "pop rock", "rock" ],
    "href" : "https://api.spotify.com/v1/artists/3vbKDsSS70ZX9D2OcvbZmS",
    "id" : "3vbKDsSS70ZX9D2OcvbZmS",
    "images" : [ {
      "height" : 637,
      "url" : "https://i.scdn.co/image/0f9a6de96397097f0a717bdbd4b15fe9d97ca5d0",
      "width" : 640
    }, {
      "height" : 319,
      "url" : "https://i.scdn.co/image/7a51cc5f85b602a6058f79ac13211c4e06175944",
      "width" : 320
    }, {
      "height" : 159,
      "url" : "https://i.scdn.co/image/bd9d8b22499c4b3d1cb2358a7f50d061b77a247d",
      "width" : 160
    } ],
    "name" : "Beck",
    "popularity" : 78,
    "type" : "artist",
    "uri" : "spotify:artist:3vbKDsSS70ZX9D2OcvbZmS"
  }, {
    "external_urls" : {
      "spotify" : "https://open.spotify.com/artist/7jdFEYD2LTYjfwxOdlVjmc"
    },
    "followers" : {
      "href" : null,
      "total" : 404673
    },
    "genres" : [ ],
    "href" : "https://api.spotify.com/v1/artists/7jdFEYD2LTYjfwxOdlVjmc",
    "id" : "7jdFEYD2LTYjfwxOdlVjmc",
    "images" : [ {
      "height" : 640,
      "url" : "https://i.scdn.co/image/f0b1df5f5c775bff70b7f67325fafd07d212ee53",
      "width" : 640
    }, {
      "height" : 320,
      "url" : "https://i.scdn.co/image/58dba98f04b4c2975ed271ff1df5e64a3333e0eb",
      "width" : 320
    }, {
      "height" : 160,
      "url" : "https://i.scdn.co/image/0d7bd4fd618e133e328f47f3f32ca2bd08aedc85",
      "width" : 160
    } ],
    "name" : "Kaleo",
    "popularity" : 76,
    "type" : "artist",
    "uri" : "spotify:artist:7jdFEYD2LTYjfwxOdlVjmc"
  }, {
    "external_urls" : {
      "spotify" : "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q"
    },
    "followers" : {
      "href" : null,
      "total" : 5882272
    },
    "genres" : [ "modern rock", "pop", "vegas indie" ],
    "href" : "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q",
    "id" : "53XhwfbYqKCa1cC15pYq2q",
    "images" : [ {
      "height" : 640,
      "url" : "https://i.scdn.co/image/de3c2c4f4e822edab6fd8c2103102413502635ea",
      "width" : 640
    }, {
      "height" : 320,
      "url" : "https://i.scdn.co/image/0242e9f3cdaeb9abd0c9724248213c8e364fc921",
      "width" : 320
    }, {
      "height" : 160,
      "url" : "https://i.scdn.co/image/affb5c546adf0b6f718282528e56f24854026be1",
      "width" : 160
    } ],
    "name" : "Imagine Dragons",
    "popularity" : 95,
    "type" : "artist",
    "uri" : "spotify:artist:53XhwfbYqKCa1cC15pYq2q"
  } ]
}
""".data(using: .utf8)!
