//
//  PowerPlayerService.swift
//  power-library
//
//  Created by Samiul Hoque on 10/1/24.
//

@available(macOS 13.0, *)
@available(iOS 16.0, *)
public final class PowerPlayerService {
    
    private var authService: PowerAuthService
    
    public init(_ authService: PowerAuthService) {
        self.authService = authService
    }
}

@available(macOS 13.0, *)
@available(iOS 16.0, *)
public extension PowerPlayerService {
    
    func play(_ track: Track) async throws {
        try await SpotifyPlayerApi.requestPlay(
            trackUri: track.trackUri,
            accessToken: authService.accessToken!
        )
    }
    
    func enqueue(_ track: Track) async throws {
        try await SpotifyPlayerApi.requestEnqueue(
            trackUri: track.trackUri,
            accessToken: authService.accessToken!
        )
    }
    
    func getQueue() async throws -> Queue {
        let response = try await SpotifyPlayerApi.requestQueue(
            accessToken: authService.accessToken!
        )
        
        let queue = Queue(response)
        
        return queue
    }
}
