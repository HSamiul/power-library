//
//  File.swift
//  
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// The details of your Spotify app needed to authorize it.
public struct SpotifyApp {
    
    /// The client ID of your Spotify app.
    private let clientId: String
    
    /// The client secret of your Spotify app.
    private let clientSecret: String
    
    /// A redirect URL of your Spotify app.
    private let redirectUrl: String
    
    /// The scope of your Spotify app.
    private let scope: String
}
