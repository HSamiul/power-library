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
    
    static func requestPlay(trackUri: String, accessToken: String) async throws {
        let body = SpotifyApiPlayRequest(uris: [trackUri], positionMs: 0)
        
        var request = URLRequest(url: playEndpoint)
        
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
    
    static func requestEnqueue(trackUri: String, accessToken: String) async throws {
        let queryItems = [
            URLQueryItem(name: "uri", value: trackUri)
        ]
        
        let url = queueEndpoint.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func requestQueue(accessToken: String) async throws -> SpotifyApiQueueResponse {
        
        var request = URLRequest(url: queueEndpoint)
        
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
@available(iOS 16.0, *)
private extension SpotifyPlayerApi {

    static var playEndpoint: URL {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/me/player/play"
        
        return components.url!
    }
    
    static var queueEndpoint: URL {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/me/player/queue"
        
        return components.url!
    }
}
