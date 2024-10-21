//
//  SpotifyAuth.swift
//
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Sends HTTP requests to the Spotify API's authorization endpoints.
@available(iOS 13.0.0, *)
@available(macOS 13.0, *)
final class SpotifyAuthApi {
    
    /// Sends a request to Spotify's `/api/token` endpoint, exchanging an authorization code for an access token.
    ///
    /// - Parameters:
    ///   - authCode: An authorization code.
    ///   - redirectUrl: Your app's redirect URL.
    ///
    /// - Returns: The response to the request.
    @available(iOS 16.0, *)
    static func requestAccessToken(
        authCode: String,
        clientId: String,
        clientSecret: String,
        redirectUrl: URL
    ) async throws -> SpotifyApiAccessTokenResponse {
        let queryItems =  [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: authCode),
            URLQueryItem(name: "redirect_uri", value: redirectUrl.absoluteString)
        ]
         
        let url = accessTokenEndpoint.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue(
            "Basic \(encodedClientData(clientId: clientId, clientSecret: clientSecret))",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(SpotifyApiAccessTokenResponse.self, from: data)
        
        return response
    }
    
    /// Sends a request to Spotify's `/api/token` endpoint, exchanging a refresh token for an access token.
    ///
    /// - Parameters:
    ///   - refreshToken: A refresh token.
    ///   - redirectUri: Your app's redirect URL.
    @available(iOS 16.0, *)
    static func requestAccessToken(
        refreshToken: String,
        clientId: String,
        clientSecret: String,
        redirectUrl: URL
    ) async throws -> SpotifyApiAccessTokenResponse {
        let queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        let url = accessTokenEndpoint.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue(
            "Basic \(encodedClientData(clientId: clientId, clientSecret: clientSecret))",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(
            SpotifyApiAccessTokenResponse.self,
            from: data
        )
        
        return response
    }
    
    /// `"clientId:clientSecret"` in the encoding required by the `/api/token` endpoint.
    /// - Parameters:
    ///   - clientId: Your app's client ID.
    ///   - clientSecret: Your app's clieng secret.
    /// - Returns: Encoded `<clientId:clientSecret>` per the Spotify API specificaiton.
    static func encodedClientData(
        clientId: String,
        clientSecret: String
    ) -> String {
        let clientData = "\(clientId):\(clientSecret)"
        return Data(clientData.utf8).base64EncodedString()
    }
    
    /// Spotify's `/api/token` endpoint.
    static var accessTokenEndpoint: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        
        return components.url!
    }
}
