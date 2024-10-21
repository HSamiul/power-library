//
//  PowerPlayerServiceProtocol.swift
//  power-library
//
//  Created by Samiul Hoque on 10/19/24.
//

import Foundation

@available(macOS 10.15, *)
public protocol PowerPlayerServiceProtocol: ObservableObject {
    
    var playbackState: PlaybackState { get }
    
    func watchPlaybackState() async throws
    
    func play(_ track: Track) async throws
    
    func enqueue(_ track: Track) async throws
        
    func getQueue() async throws -> Queue
}
