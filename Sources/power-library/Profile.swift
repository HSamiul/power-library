//
//  Profile.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

import Foundation

/// The user's profile.
class Profile {
    
    /// The user's display name.
    var displayName: String? = nil
    
    /// An array of the user's profile picture, varying in size.
    var profilePictures: [Image]? = nil
}

@available(iOS 15.0, *)
private extension Profile {
    
    /// Sends an HTTP request to Spotify's `/me` endpoint.
    ///
    /// - Parameter accessToken: An access token to a user's account.
    ///
    /// - Returns: The response to the request.
    func requestUserProfile(accessToken: String) async throws -> ProfileResponse {
        var request = URLRequest(url: profileEndpoint)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
        
        return response
    }
    
    var profileEndpoint: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spotify.com"
        components.path = "/v1/me"
        
        return components.url!
    }
}
