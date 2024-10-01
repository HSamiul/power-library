//
//  PowerSearchService.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

@available(macOS 13.0, *)
public final class PowerSearchService {
    
    private var authService: PowerAuthService
    
    public init(_ authService: PowerAuthService) {
        self.authService = authService
    }
}


@available(macOS 13.0, *)
public extension PowerSearchService {
    
    func search(query: String) async throws -> [Track] {
        let response = try await SpotifySearchApi.requestSearch(
            query: query,
            accessToken: authService.accessToken!
        )
        
        let apiTracks = response.tracks.items
        
        let tracks = apiTracks.map { apiTrack in
            Track(
                trackName: apiTrack.name,
                artistName: apiTrack.artists.first!.name,
                imageUrl: URL(string: apiTrack.album.images.last!.url)!
            )
        }
        
        return tracks
    }
}
