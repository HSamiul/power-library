//
//  PowerSearchService.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

public final class PowerSearchService {
    
    private var authService: PowerAuthService
    
    public init(authService: PowerAuthService) {
        self.authService = authService
    }
}


public extension PowerSearchService {
    
    func search(query: String) async throws -> [Track] {
        let response = SpotifySearchApi.search(
            query: query,
            accessToken: authService.accessToken!
        )
        
        let apiTracks = return response.tracks.items
        
        let tracks = items.map { apiTrack in
            Track(
                trackName: apiTrack.name,
                artistName: apiTrack.artists.first!.name
            )
        }
        
        return tracks
    }
}
