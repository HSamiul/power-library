//
//  SpotifyApiPlaybackStateResponse.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

struct SpotifyApiPlaybackStateResponse: Decodable {
    
    let device: SpotifyApiDevice
    
    let repeatState: String
    
    let shuffleState: Bool
    
    let context: SpotifyApiContext?
    
    let timestamp: Int
    
    let progressMs: Int?
    
    let isPlaying: Bool
    
    let item: SpotifyApiTrack?
    
    let currentlyPlayingType: String
    
    let actions: SpotifyApiActions
}

private extension SpotifyApiPlaybackStateResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case device
        
        case repeatState = "repeat_state"
        
        case shuffleState = "shuffle_state"
        
        case context
        
        case timestamp
        
        case progressMs = "progress_ms"
        
        case isPlaying = "is_playing"
        
        case item
        
        case currentlyPlayingType = "currently_playing_type"
        
        case actions
    }
}
