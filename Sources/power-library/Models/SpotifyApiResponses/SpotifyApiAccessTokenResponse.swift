//
//  SpotifyApiAccessTokenResponse.swift
//
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Response received from Spotify's `api/token` endpoint.
struct SpotifyApiAccessTokenResponse: Decodable {
    
    let accessToken: String
    
    let tokenType: String
    
    let expiresIn: Int
    
    let refreshToken: String?
    
    let scope: String
}

private extension SpotifyApiAccessTokenResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        
        case tokenType = "token_type"
        
        case expiresIn = "expires_in"
        
        case refreshToken = "refresh_token"
        
        case scope = "scope"
    }
}
