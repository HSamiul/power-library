//
//  SpotifyApiTracks.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

struct SpotifyApiTracks: Decodable {
    
    let href: String
    
    let limit: Int
    
    let next: String?
    
    let offset: Int
    
    let previous: String?
    
    let total: Int
    
    let items: [SpotifyApiTrack]
}
