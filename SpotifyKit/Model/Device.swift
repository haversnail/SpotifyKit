//
//  Device.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/20/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

public struct SKDevice: JSONDecodable {
    
    // MARK: - Embedded Types
    
    public enum DeviceType: String, Codable {
        case computer = "Computer"
        case mobile = "Smartphone"
        case speaker = "Speaker"
        case tv = "CastVideo"
        case unknown
        
        public init(rawValue: String) {
            switch rawValue {
                case "Computer":    self = .computer
                case "Smartphone":  self = .mobile
                case "Speaker":     self = .speaker
                case "CastVideo":   self = .tv
                default: self = .unknown
            }
        }
    }
    
    // MARK: - Object Properties
    
    /// The device ID, or `nil` if unavailable.
    public let id: String?
    
    /// A Boolean value indicating if this device is the currently active device.
    public let isActive: Bool
    
    /// A Boolean value indicating whether controlling this device via the [Spotify Web API][API] is restricted. If `true`, then no [Web API][API] commands will be accepted by this device.
    ///
    /// [API]: https://developer.spotify.com/web-api/
    public let isRestricted: Bool
    
    /// The name of the device.
    public let name: String
    
    /// The device type. For possible values, see `DeviceType`.
    public let type: DeviceType
    
    /// The current volume in percent, or `nil` if unavailable.
    public let volume: Int?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case isRestricted = "is_restricted"
        case name
        case type
        case volume = "volume_percent"
    }
}
