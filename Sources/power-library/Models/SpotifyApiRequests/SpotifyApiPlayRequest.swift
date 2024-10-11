//
//  SpotifyApiPlayRequest.swift
//  power-library
//
//  Created by Samiul Hoque on 10/2/24.
//

struct SpotifyApiPlayRequest: Encodable {
    
    let contextUri: String? = nil
    
    let uris: [String]?
    
    /* let offset: Int? -- Not an Int; an object I don't feel like making */
    
    let positionMs: Int
}

private extension SpotifyApiPlayRequest {
    
    enum CodingKeys: String, CodingKey {
        
        case contextUri = "context_uri"
        
        case uris = "uris"
        
        case positionMs = "position_ms"
    }
}
