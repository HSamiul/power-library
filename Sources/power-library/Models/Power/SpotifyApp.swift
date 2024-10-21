//
//  SpotifyApp.swift
//
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Your Spotify app.
public struct SpotifyApp {
    
    /// The client ID of your Spotify app.
    let clientId: String
    
    /// The client secret of your Spotify app.
    let clientSecret: String
    
    /// A redirect URL of your Spotify app.
    let redirectUrl: URL
    
    /// The scope of your Spotify app.
    let scope: String
    
    public init(
        clientId: String,
        clientSecret: String,
        redirectUrl: URL,
        scope: String
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectUrl = redirectUrl
        self.scope = scope
    }
}
