//
//  SpotifyProfile.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

import Foundation

/// Sends HTTP requests to the Spotify API's profile and user endpoints.
@available(iOS 13.0, *)
@available(macOS 13.0, *)
class SpotifyProfileApi: ObservableObject {

    /// Sends an HTTP request to Spotify's `/me` endpoint.
    ///
    /// - Parameter accessToken: An access token to a user's account.
    ///
    /// - Returns: The response to the request.
    static func requestUserProfile(accessToken: String) async throws -> SpotifyApiProfileResponse {
        var request = URLRequest(url: profileEndpoint)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(SpotifyApiProfileResponse.self, from: data)
        
        return response
    }
}

@available(iOS 13.0, *)
@available(macOS 13.0, *)
private extension SpotifyProfileApi {
    
    static var profileEndpoint: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/me"
        
        return components.url!
    }
}
