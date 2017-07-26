//
//  Category.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/26/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var categoryData: Data {
        return """
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
    }
}
