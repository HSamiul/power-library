//
//  SpotifyApiDevice.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

struct SpotifyApiDevice: Decodable {
    
    let id: String?
    
    let isActive: Bool?
    
    let isPrivateSession: Bool
    
    let isRestricted: Bool
    
    let name: String
    
    let type: String
    
    let volumePercent: Int
    
    let supportsVolume: Bool
}

private extension SpotifyApiDevice {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case isActive = "is_active"
        
        case isPrivateSession = "is_private_session"
        
        case isRestricted = "is_restricted"
        
        case name
        
        case type
        
        case volumePercent = "volume_percent"
        
        case supportsVolume = "supports_volume"
    }
}
