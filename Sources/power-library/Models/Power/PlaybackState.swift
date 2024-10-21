//
//  PlaybackState.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

public struct PlaybackState {
    
    /// `true` if a track is currently playing. `false`, otherwise.
    public var isPlaying: Bool
    
    /// The currently playing track, if one is playing. `nil`, otherwise.
    public var track: Track?
    
    /// The progress, in milliseconds, into the current track if one is playing. `nil`, otherwise.
    public var trackProgress: Int?
}

public extension PlaybackState {
    
    static func initial() -> Self {
        .init(isPlaying: false)
    }
    
    static func mock() -> Self {
        .init(
            isPlaying: true,
            track: .mock(),
            trackProgress: 72000
        )
    }
}

public extension PlaybackState {
    
    var formattedTrackDuration: String? {
        guard let trackProgress else { return nil }
        
        let totalSeconds = trackProgress / 1000
        
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension PlaybackState {
    
    init(_ apiResponse: SpotifyApiPlaybackStateResponse) {
        self.isPlaying = apiResponse.isPlaying
        self.trackProgress = apiResponse.progressMs
        
        if let apiTrack = apiResponse.item {
            self.track = .init(apiTrack)
        }
    }
}
