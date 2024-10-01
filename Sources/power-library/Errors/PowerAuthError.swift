//
//  AuthorizationError.swift
//
//
//  Created by Samiul Hoque on 8/5/24.
//

import Foundation

/// Errors that may be thrown by `Authorization` .
enum PowerAuthError: LocalizedError {
    
    /// An access token was attemped to be refreshed, but there is no refresh token.
    case RefreshTokenMissing
    
    var errorDescription: String? {
        switch self {
        case .RefreshTokenMissing:
            return "An access token was attemped to be refreshed, but there is no refresh token."
        }
    }
}
