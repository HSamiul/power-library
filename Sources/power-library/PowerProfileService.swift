//
//  PowerProfileService.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

/// A service that provides a user's profile information.
@available(iOS 13.0, *)
@available(macOS 13.0, *)
public final class PowerProfileService: ObservableObject {
    
    private var authService: PowerAuthService
    
    public init(_ authService: PowerAuthService) {
        self.authService = authService
    }
}

@available(iOS 13.0, *)
@available(macOS 13.0, *)
public extension PowerProfileService {

    @MainActor
    func loadProfile() async throws -> Profile {
        let response = try await SpotifyProfileApi.requestUserProfile(
            accessToken: authService.accessToken!
        )
        
        return Profile(response)
    }
}
