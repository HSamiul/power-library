//
//  Queue.swift
//  power-library
//
//  Created by Samiul Hoque on 10/2/24.
//

public struct Queue {
    
    public let currentlyPlaying: Track?
    
    public let queue: [Track]
}

public extension Queue {
    
    static func mock() -> Self {
        .init(
            currentlyPlaying: .mock(),
            queue: [.mock(), .mock(), .mock()]
        )
    }
}

extension Queue {
    
    init(_ apiResponse: SpotifyApiQueueResponse) {
        self.queue = apiResponse.queue.map { Track($0) }
        
        if let apiTrack = apiResponse.currentTrack {
            self.currentlyPlaying = Track(apiTrack)
        } else {
            self.currentlyPlaying = nil
        }
    }
}
