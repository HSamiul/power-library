//
//  Track.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

public struct Track: Identifiable, Equatable {
    
    public let id = UUID()
    
    public let trackName: String
    
    public let artistName: String
    
    public let imageUrl: URL
    
    public let trackUri: String
    
    public let trackDuration: Int
}

public extension Track {
    
    static func mock() -> Track {
        .init(
            trackName: "Fine China",
            artistName: "Juice WRLD",
            imageUrl: URL(string: "https://upload.wikimedia.org/wikipedia/en/0/04/Juice_Wrld_-_Death_Race_for_Love.png")!,
            trackUri: "",
            trackDuration: 192000
        )
    }
    
    var formattedTrackDuration: String {
        let totalSeconds = trackDuration / 1000
        
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Track {
    
    init(_ apiTrack: SpotifyApiTrack) {
        self.trackName = apiTrack.name
        self.artistName = apiTrack.artists.first!.name
        self.imageUrl = URL(string: apiTrack.album.images.first!.url)!
        self.trackUri = apiTrack.uri
        self.trackDuration = apiTrack.durationMs
    }
}
