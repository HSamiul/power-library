//
//  SpotifyApiActions.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

struct SpotifyApiActions: Decodable {
    
    let interruptingPlayback: Bool?
    
    let pausing: Bool?
    
    let resuming: Bool?
    
    let seeking: Bool?
    
    let skippingNext: Bool?
    
    let skippingPrev: Bool?
    
    let togglingRepeatContext: Bool?
    
    let togglingShuffle: Bool?
    
    let togglingRepeatTrack: Bool?
    
    let transferringPlayback: Bool?
}

private extension SpotifyApiActions {
    
    enum CodingKeys: String, CodingKey {
        
        case interruptingPlayback = "interrupting_playback"
        
        case pausing
        
        case resuming
        
        case seeking
        
        case skippingNext = "skipping_next"
        
        case skippingPrev = "skipping_prev"
        
        case togglingRepeatContext = "toggling_repeat_context"
        
        case togglingShuffle = "toggling_shuffle"
        
        case togglingRepeatTrack = "toggling_repeat_track"
        
        case transferringPlayback = "transferring_playback"
    }
}
