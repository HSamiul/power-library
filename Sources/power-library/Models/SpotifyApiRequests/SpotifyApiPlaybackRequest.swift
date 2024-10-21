//
//  SpotifyApiPlayRequest.swift
//  power-library
//
//  Created by Samiul Hoque on 10/2/24.
//

struct SpotifyApiPlaybackRequest: Encodable {
    
    let contextUri: String?
    
    let uris: [String]?
    
    /* let offset: Int? -- Not an Int; an object I don't feel like making */
    
    let positionMs: Int
    
    init(contextUri: String? = nil, uris: [String]? = nil, positionMs: Int) {
        self.contextUri = contextUri
        self.uris = uris
        self.positionMs = positionMs
    }
}

private extension SpotifyApiPlaybackRequest {
    
    enum CodingKeys: String, CodingKey {
        
        case contextUri = "context_uri"
        
        case uris = "uris"
        
        case positionMs = "position_ms"
    }
}
