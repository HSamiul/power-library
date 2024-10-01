//
//  PowerProfileService.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//


public final class ProfileService: ObservableObject {
    
    /// The user's display name.
    @Published public var displayName: String? = nil
    
    /// The user's email address.
    @Published public var email: String? = nil
    
    /// An array of the user's profile picture, varying in size.
    @Published public var profilePicture: SpotifyImage? = nil
    
    private var authService: PowerAuthService
    
    init(authService: PowerAuthService) {
        self.authService = authService
        Task { try await fetchProfile() }
    }
}

public extension ProfileService {
    
    func fetchProfile() async throws {
        let response = try await requestUserProfile(accessToken: authService.accessToken!)
        
        displayName = response.displayName
        profilePicture = response.images.first
        email = response.email
        
        print("\(displayName) \(profilePicture?.url) \(email)")
    }
}
