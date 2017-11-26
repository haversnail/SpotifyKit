//
//  Image.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
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

/// A structure representing an image used by a Spotify item, such as a playlist's cover image.
///
/// - SeeAlso: The Web API [Image](https://developer.spotify.com/web-api/user-guide/#image-object) object.
public struct SKImage: JSONDecodable {
    
    /// The source URL of the image.
    public let url: URL
    
    /// The image height in pixels. If unknown, this value will be `nil`.
    public let height: Int?
    
    /// The image width in pixels. If unknown, this value will be `nil`.
    public let width: Int?
}
