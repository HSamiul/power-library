//
//  ExplicitContent.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

internal struct SpotifyApiExplicitContent: Decodable {

    let filterEnabled: Bool
    
    let filterLocked: Bool
}


private extension SpotifyApiExplicitContent {
    
    enum CodingKeys: String, CodingKey {
        
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }

}
