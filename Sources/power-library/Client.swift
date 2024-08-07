//
//  Client.swift
//  
//
//  Created by Samiul Hoque on 8/6/24.
//

import Foundation

/// The client to interact with the Spotify app.
///
/// Typical usage:
/// ```
/// let client = Client(app: <your_app>)
/// try await client.authorize(authorizationCode: <auth_code>)
/// ...
/// ```
@available(iOS 16.0, *)
class Client {
    
    let profile: Profile
    
    private let app: App
    
    private let auth: Authorization
    
    init(app: App) {
        self.profile = Profile()
        self.app = app
        self.auth = Authorization(app: app)
    }
    
    func authorize(authorizationCode: String) async throws {
        try await auth.authorize(authorizationCode: authorizationCode)
    }
}
