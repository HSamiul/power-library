//
//  SpotifyPlayerService.swift
//  power-library
//
//  Created by Samiul Hoque on 10/1/24.
//

public final class SpotifyPlayerService {
    
    private var authService: PowerAuthService
    
    public init(authService: PowerAuthService) {
        self.authService = authService
    }
}

public extension SpotifyPlayerService {
    
    func enqueue(track: SpotifyTrack) async throws {
        
        try await SpotifyPlayerApi.requestEnqueue(
            trackUri: track.uri,
            accessToken: authService.accessToken
        )
    }
}
