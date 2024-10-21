//
//  SpotifyApiContext.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

struct SpotifyApiContext: Decodable {
    
    let type: String
    
    let href: String
    
    let externalUrls: SpotifyApiExternalUrls
    
    let uri: String
}

private extension SpotifyApiContext {
    
    enum CodingKeys: String, CodingKey {
        
        case type
        
        case href
        
        case externalUrls = "external_urls"
        
        case uri
    }
}
