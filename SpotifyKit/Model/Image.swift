//
//  Image.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 7/22/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKImage: JSONDecodable {
    
    /// The source URL of the image.
    public let url: URL
    
    /// The image height in pixels. If unknown, this value will be `nil`.
    public let height: Int?
    
    /// The image width in pixels. If unknown, this value will be `nil`.
    public let width: Int?
}
