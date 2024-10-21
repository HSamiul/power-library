//
//  PowerPlayerService.swift
//  power-library
//
//  Created by Samiul Hoque on 10/1/24.
//

import Foundation
import Combine
@available(macOS 13.0, *)
@available(iOS 16.0, *)
public final class PowerPlayerService: PowerPlayerServiceProtocol {
    
    @Published public var playbackState = PlaybackState.initial()
    
    private var playbackListeners: [(PlaybackState) -> Void] = []
    
    private var authService: any PowerAuthServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(_ authService: any PowerAuthServiceProtocol) {
        self.authService = authService
        watchPlaybackState()
        
        $playbackState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self else { return }
            
                for listener in playbackListeners {
                    listener(state)
                }
            }
            .store(in: &cancellables)
    }
}

@available(macOS 13.0, *)
@available(iOS 16.0, *)
public extension PowerPlayerService {
    
    func registerPlaybackListener(_ callback: @escaping (PlaybackState) -> Void) {
        callback(playbackState)
        playbackListeners.append(callback)
    }
    
    func watchPlaybackState() {
        Task { try await setPlaybackState() }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let progress = self.playbackState.trackProgress, self.playbackState.isPlaying {
                self.playbackState.trackProgress! += 1000
                
                if let track = self.playbackState.track, progress > track.trackDuration {
                    Task {
                        do { try await self.setPlaybackState() }
                        catch { print(error) }
                    }
                }
            }
        }

        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            Task {
                do { try await self.setPlaybackState() }
                catch { print(error) }
            }
        }
    }
    
    func play(_ track: Track) async throws {
        try await SpotifyPlayerApi.requestPlay(
            trackUri: track.trackUri,
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
    }
    
    func resume() async throws {
        try await SpotifyPlayerApi.requestResume(
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
    }
    
    func pause() async throws {
        try await SpotifyPlayerApi.requestPause(
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
    }
    
    func seek(to position: Int) async throws {
        try await SpotifyPlayerApi.requestSeek(
            to: position,
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
    }
    
    func playPrevious() async throws {
        try await SpotifyPlayerApi.requestPlayPrevious(
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
    }
    
    func playNext() async throws {
        try await SpotifyPlayerApi.requestPlayNext(
            accessToken: authService.accessToken!
        )
        
        try await setPlaybackState()
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

@available(macOS 13.0, *)
private extension PowerPlayerService {
    
    func setPlaybackState() async throws {
        let response = try await SpotifyPlayerApi.requestState(
            accessToken: authService.accessToken!
        )
        
        playbackState = PlaybackState(response)
    }
}
