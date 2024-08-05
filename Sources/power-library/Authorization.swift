//
//  File.swift
//  
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Manages the authorization state of your application.
@available(iOS 16.0, *)
internal final class Authorization {
    
    private let app: App
    
    init(app: App) {
        self.app = app
    }
}

@available(iOS 16.0, *)
internal extension Authorization {
    
    /// The URL to log in to your app.
    var authorizeUrl: String {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/authorize"
        
        components.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: app.clientId),
            URLQueryItem(name: "scope", value: app.scope),
            URLQueryItem(name: "redirect_uri", value: app.redirectUrl.absoluteString),
            URLQueryItem(name: "show_dialog", value: "true")
        ]
        
        return components.url!.absoluteString
    }
}

@available(iOS 16.0, *)
private extension Authorization {
    
    /// Sends a request to Spotify's `/api/token` endpoint, exchanging an authorization code for an access token.
    ///
    /// - Parameters:
    ///   - authorizationCode: An authorization code.
    ///   - redirectUrl: Your app's redirect URL.
    ///
    /// - Returns: The response to the request.
    func requestAccessToken(authorizationCode: String) async throws -> AccessTokenResponse {
        let queryItems =  [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: authorizationCode),
            URLQueryItem(name: "redirect_uri", value: app.redirectUrl.absoluteString)
        ]
         
        let url = accessTokenRequestUrl.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(encodedClientData)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)

        return response
    }
    
    /// Sends a request to Spotify's `/api/token` endpoint, exchanging a refresh token for an access token.
    ///
    /// - Parameters:
    ///   - refreshToken: A refresh token.
    ///   - redirectUri: Your app's redirect URL.
    func requestAccessToken(refreshToken: String) async throws -> AccessTokenResponse {
        let queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        let url = accessTokenRequestUrl.appending(queryItems: queryItems)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(encodedClientData)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
        
        return response
    }
    
    /// Spotify's `/api/token` endpoint.
    var accessTokenRequestUrl: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        
        return components.url!
    }
    
    /// `"clientId:clientSecret"` in the encoding required by the `/api/token` endpoint.
    var encodedClientData: String {
        let clientData = "\(app.clientId):\(app.clientSecret)"
        return Data(clientData.utf8).base64EncodedString()
    }
}
