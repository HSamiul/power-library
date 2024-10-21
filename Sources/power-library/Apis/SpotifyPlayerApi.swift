//
//  SpotifyPlayerApi.swift
//  power-library
//
//  Created by Samiul Hoque on 10/1/24.
//

import Foundation

@available(macOS 13.0, *)
@available(iOS 16.0, *)
final class SpotifyPlayerApi {
    
    static func requestState(accessToken: String) async throws -> SpotifyApiPlaybackStateResponse {
        
        var request = URLRequest(url: playerEndpoint)
        
        request.httpMethod = "GET"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(SpotifyApiPlaybackStateResponse.self, from: data)
        
        return response
    }

    static func requestPlay(
        trackUri: String,
        accessToken: String)
    async throws {
        try await requestPlayback(
            trackUris: [trackUri],
            accessToken: accessToken
        )
    }
    
    static func requestResume(accessToken: String) async throws {
        try await requestPlayback(accessToken: accessToken)
    }
    
    static func requestPause(accessToken: String) async throws {
        print("API: Pausing")
        let url = playerEndpoint.appending(path: "pause")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
    }
    
    static func requestSeek(
        to position: Int,
        accessToken: String
    ) async throws {
        let queryItems = [
            URLQueryItem(name: "position_ms", value: "\(position)")
        ]
        
        let url = playerEndpoint
            .appending(path: "seek")
            .appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func requestPlayPrevious(accessToken: String) async throws {
        let url = playerEndpoint.appending(path: "previous")
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func requestPlayNext(accessToken: String) async throws {
        let url = playerEndpoint.appending(path: "next")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func requestEnqueue(trackUri: String, accessToken: String) async throws {
        let queryItems = [
            URLQueryItem(name: "uri", value: trackUri)
        ]
        
        let url = playerEndpoint
            .appending(path: "queue")
            .appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func requestQueue(accessToken: String) async throws -> SpotifyApiQueueResponse {
        let url = playerEndpoint.appending(path: "queue")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(SpotifyApiQueueResponse.self, from: data)
        
        return response
    }
}

@available(macOS 13.0, *)
private extension SpotifyPlayerApi {
    
    static func requestPlayback(
        trackUris: [String]? = nil,
        accessToken: String
    ) async throws {
        let url = playerEndpoint.appending(path: "play")
        let body = SpotifyApiPlaybackRequest(uris: trackUris, positionMs: 0)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.httpBody = try JSONEncoder().encode(body)
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
}

@available(macOS 13.0, *)
@available(iOS 16.0, *)
private extension SpotifyPlayerApi {

    static var playerEndpoint: URL {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/me/player"
        
        return components.url!
    }
}
