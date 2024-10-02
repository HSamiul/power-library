//
//  Track.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

public struct Track: Hashable {
    
    public let trackName: String
    
    public let artistName: String
    
    public let imageUrl: URL
}

public extension Track {
    
    static var mock = Track(
        trackName: "Fine China",
        artistName: "Juice WRLD",
        imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b2738b27d35aa2c6dcf99895d664")!
    )
}
