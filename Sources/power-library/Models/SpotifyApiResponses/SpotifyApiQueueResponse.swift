//
//  SpotifyApiQueueResponse.swift
//  power-library
//
//  Created by Samiul Hoque on 10/2/24.
//

struct SpotifyApiQueueResponse: Decodable {
    
    let currentTrack: SpotifyApiTrack?
    
    let queue: [SpotifyApiTrack]
}

private extension SpotifyApiQueueResponse {
    
    enum codingkeys: String, CodingKey {
        
        case currentTrack = "currently_playing"
        
        case queue = "queue"
    }
}
