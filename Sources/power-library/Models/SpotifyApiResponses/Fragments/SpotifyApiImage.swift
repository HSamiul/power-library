//
//  SpotifyImage.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

internal struct SpotifyApiImage: Decodable {
    
    internal let url: String
    
    internal let height: Int?
    
    internal let width: Int?
}
