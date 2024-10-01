//
//  SpotifySearchApi.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

/// Sends HTTP requests to the Spotify API's search endpoints.
@available(macOS 13.0, *)
@available(iOS 16.0, *)
public class SpotifySearchApi {
    
    public static func requestSearch(
        query: String,
        accessToken: String
    ) async throws -> SpotifyApiSearchResponse {
        
        let queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: "track"),
            URLQueryItem(name: "limit", value: "5")
        ]
        
        let url = searchEndpoint.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        print(try JSONSerialization.jsonObject(with: data))
        
        let response = try JSONDecoder().decode(
            SpotifyApiSearchResponse.self,
            from: data
        )
        
        return response
    }
}

@available(macOS 13.0, *)
@available(iOS 16.0, *)
public extension SpotifySearchApi {
    
    static var searchEndpoint: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/search"
        
        return components.url!
    }
}
