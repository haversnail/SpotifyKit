//
//  User.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/29/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

extension ObjectModelTests {
    var userData: Data {
        return """
        {
          "birthdate" : "1900-07-01",
          "country" : "US",
          "display_name" : null,
          "email" : "alex.havermale@icloud.com",
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
    }
}
