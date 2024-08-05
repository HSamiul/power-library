//
//  File.swift
//  
//
//  Created by Samiul Hoque on 8/4/24.
//

import Foundation

/// Manages the authorization state of your application.
private final class Authorization {
    
    private let app: App
    
    init(app: App) {
        self.app = app
    }
}

extension Authorization {
    
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
            URLQueryItem(name: "redirect_uri", value: app.redirectUrl),
            URLQueryItem(name: "show_dialog", value: "true")
        ]
        
        return components.url!.absoluteString
    }
}
