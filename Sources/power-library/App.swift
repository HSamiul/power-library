//
//  App.swift
//
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Your Spotify app.
public struct App {
    
    /// The client ID of your Spotify app.
    let clientId: String
    
    /// The client secret of your Spotify app.
    let clientSecret: String
    
    /// A redirect URL of your Spotify app.
    let redirectUrl: URL
    
    /// The scope of your Spotify app.
    let scope: String
}
