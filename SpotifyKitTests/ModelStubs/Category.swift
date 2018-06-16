//
//  Category.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/26/17.
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

let categoryData = """
{
  "href" : "https://api.spotify.com/v1/browse/categories/indie_alt",
  "icons" : [ {
    "height" : 274,
    "url" : "https://t.scdn.co/media/derived/indie-274x274_add35b2b767ff7f3897262ad86809bdb_0_0_274_274.jpg",
    "width" : 274
  } ],
  "id" : "indie_alt",
  "name" : "Indie"
}
""".data(using: .utf8)!
