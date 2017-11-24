//
//  Device.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/20/17.
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

/// A representation of a device that supports a Spotify player.
public struct SKDevice: JSONDecodable {
    
    /// The possible devices that can support a Spotify player.
    public enum DeviceType: String, Codable {
        
        /// A device that supports a desktop Spotify player.
        case computer = "Computer"
        
        /// A device that supports a mobile Spotify player, such as a smartphone or tablet.
        case mobile = "Smartphone"
        
        /// A device that supports a speaker-based Spotify player, such as a portable Bluetooth speaker.
        case speaker = "Speaker"
        
        /// A device that supports a TV-based Spotify player, such as a Chromecast-enabled Smart TV.
        case tv = "CastVideo"
        
        /// An unknown device type.
        case unknown
        
        public init(rawValue: String) {
            switch rawValue {
                case "Computer":   self = .computer
                case "Smartphone": self = .mobile
                case "Speaker":    self = .speaker
                case "CastVideo":  self = .tv
                default:
                    print("Discovered unknown device type: \"\(rawValue)\"")
                    self = .unknown
            }
        }
    }
    
    /// The device ID, or `nil` if unavailable.
    public let id: String?
    
    /// A Boolean value indicating if this device is the currently active device.
    public let isActive: Bool
    
    /// A Boolean value indicating whether controlling this device via the [Spotify Web API](https://developer.spotify.com/web-api/) is restricted. If `true`, then no Web API commands will be accepted by this device.
    public let isRestricted: Bool
    
    /// The name of the device.
    public let name: String
    
    /// The device type. For possible values, see `DeviceType`.
    public let type: DeviceType
    
    /// The current volume in percent, or `nil` if unavailable.
    private let _volume: Int?

    /// The device's current volume, ranging from `0.0` to `1.0` on a linear scale, or `nil` if unavailable.
    public var volume: Float? {
        switch _volume {
            case .some(let v): return Float(v / 100)
            case .none: return nil
        }
    }

    // MARK: Keys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case isRestricted = "is_restricted"
        case name
        case type
        case _volume = "volume_percent"
    }
}
