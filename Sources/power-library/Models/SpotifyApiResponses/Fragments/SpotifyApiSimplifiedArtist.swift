//
//  SpotifyApiSimplifiedArtist.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

struct SpotifyApiSimplifiedArtist: Decodable {
    
    let externalUrls: SpotifyApiExternalUrls
    
    let href: String
    
    let id: String
    
    let name: String
    
    let type: String
    
    let uri: String
}

private extension SpotifyApiSimplifiedArtist {
    
    enum CodingKeys: String, CodingKey {
        
        case externalUrls = "external_urls"
        
        case href
        
        case id
        
        case name
        
        case type
        
        case uri
    }
}
