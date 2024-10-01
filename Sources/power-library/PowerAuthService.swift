//
//  PowerAuthService.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation
import Combine

/// A service that can initiate and maintain authorization of a user's Spotify account.
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public final class PowerAuthService: ObservableObject {
    
    /// An access token.
    @Published var accessToken: String? = nil
    
    /// `accessToken != nil`
    public var isAuthorized = false
    
    /// Your Spotify application.
    private let app: SpotifyApp
    
    /// A refresh token.
    private var refreshToken: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes an instance of this class.
    /// - Parameter app: Your Spotify app.
    public init(_ app: SpotifyApp) {
        self.app = app
        
        $accessToken.sink { [weak self] accessToken in
            guard let self else { return }
            self.isAuthorized = accessToken != nil
        }
        .store(in: &cancellables)
    }
}

@available(iOS 13.0, *)
@available(macOS 13.0, *)
public extension PowerAuthService {
    
    /// Exchanges `authCode` for an access token and refreshes it indefinitely.
    /// - Parameter authCode: An authorization code.
    @available(iOS 16.0, *)
    @MainActor
    func authorize(authCode: String) async throws {
        let response = try await SpotifyAuthApi.requestAccessToken(
            authCode: authCode,
            clientId: app.clientId,
            clientSecret: app.clientSecret,
            redirectUrl: app.redirectUrl
        )
        
        accessToken = response.accessToken
        refreshToken = response.refreshToken
        
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            Task { try await self.refreshAccessToken() }
        }
    }
    
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

@available(iOS 13.0, *)
@available(macOS 13.0, *)
private extension PowerAuthService {
    
    @available(iOS 16.0, *)
    @MainActor
    /// Exchanges `refreshToken` for a new access token and refesh token.
    func refreshAccessToken() async throws {
        guard let refreshToken else {
            throw PowerAuthError.RefreshTokenMissing
        }
        
        let response = try await SpotifyAuthApi.requestAccessToken(
            refreshToken: refreshToken,
            clientId: app.clientId,
            clientSecret: app.clientSecret,
            redirectUrl: app.redirectUrl
        )
        
        accessToken = response.accessToken
        self.refreshToken = response.refreshToken
    }
}
