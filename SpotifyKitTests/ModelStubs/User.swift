//
//  User.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/29/17.
//  Copyright © 2017 Alex Havermale.
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

let currentUserData = """
{
  "birthdate" : "1900-07-01",
  "country" : "US",
  "display_name" : null,
  "email" : "test@gmail.com",
  "external_urls" : {
    "spotify" : "https://open.spotify.com/user/ahavermale"
  },
  "followers" : {
    "href" : null,
    "total" : 0
  },
  "href" : "https://api.spotify.com/v1/users/ahavermale",
  "id" : "ahavermale",
  "images" : [ ],
  "product" : "premium",
  "type" : "user",
  "uri" : "spotify:user:ahavermale"
}
""".data(using: .utf8)!

let userData = """
{
  "display_name" : "Nike+ Run Club",
  "external_urls" : {
    "spotify" : "https://open.spotify.com/user/nikerunclub"
  },
  "followers" : {
    "href" : null,
    "total" : 1213120
  },
  "href" : "https://api.spotify.com/v1/users/nikerunclub",
  "id" : "nikerunclub",
  "images" : [ {
    "height" : null,
    "url" : "https://profile-images.scdn.co/images/userprofile/default/4b4f6210ce5461975a509edfc43b0010f7126a53",
    "width" : null
  } ],
  "type" : "user",
  "uri" : "spotify:user:nikerunclub"
}
""".data(using: .utf8)!
