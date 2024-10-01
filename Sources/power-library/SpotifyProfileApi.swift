//
//  SpotifyProfile.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

import Foundation

/// The user's profile.
@available(macOS 13.0, *)
public class SpotifyProfileApi: ObservableObject {
    
    /// The user's display name.
    @Published public var displayName: String? = nil {
        
        didSet {
            print("Display name set! \(displayName)")
        }
    }
    
    /// The user's email address.
    @Published public var email: String? = nil
    
    /// An array of the user's profile picture, varying in size.
    @Published public var profilePicture: SpotifyImage? = nil
}

@available(macOS 13.0, *)
internal extension SpotifyProfileApi {
    
    func fetchProfile(accessToken: String) async throws {
        let response = try await requestUserProfile(accessToken: accessToken)
        
        displayName = response.displayName
        profilePicture = response.images.first
        email = response.email
        
        print("\(displayName) \(profilePicture?.url) \(email)")
    }
}

@available(macOS 13.0, *)
private extension SpotifyProfileApi {
    
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
