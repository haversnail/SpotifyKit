//
//  Device.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/20/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

/// A representation of a device that supports a Spotify player.
public struct SKDevice: JSONDecodable {
    
    /// The possible devices that can support a Spotify player.
    public struct DeviceType: RawRepresentable, Codable {
        
        /// A device that supports a desktop Spotify player.
        public static let computer = DeviceType(rawValue: "Computer")
        
        /// A device that supports a mobile Spotify player, such as a smartphone or tablet.
        public static let mobile = DeviceType(rawValue: "Smartphone")
        
        /// A device that supports a speaker-based Spotify player, such as a portable Bluetooth speaker.
        public static let speaker = DeviceType(rawValue: "Speaker")
        
        /// A device that supports a TV-based Spotify player, such as a Chromecast-enabled Smart TV.
        public static let tv = DeviceType(rawValue: "CastVideo")
        
        public var rawValue: String
        public init?(rawValue: String) {
            self.rawValue = rawValue
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
