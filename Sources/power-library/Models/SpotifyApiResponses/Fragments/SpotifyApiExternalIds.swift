//
//  SpotifyApiExternalIds.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

struct SpotifyApiExternalIds: Decodable {
    
    let isrc: String
    
    let ean: String?
    
    let upc: String?
}
