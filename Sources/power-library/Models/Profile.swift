//
//  Profile.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

import Foundation

public struct Profile {
    
    /// The user's display name.
    public var displayName: String
    
    /// The user's email address.
    public var email: String
    
    /// A URL containing the user's profile picture.
    public var profilePictureUrl: URL
}

extension Profile {
    
    init(
        displayName: String,
        email: String,
        profilePicture: SpotifyApiImage
    ) {
        self.displayName = displayName
        self.email = email
        self.profilePictureUrl = URL(string: profilePicture.url)!
    }
    
    init(_ response: SpotifyApiProfileResponse) {
        self.displayName = response.displayName
        self.email = response.email
        self.profilePictureUrl = URL(string: response.images.last!.url)!
    }
}
