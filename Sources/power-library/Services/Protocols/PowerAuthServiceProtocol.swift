//
//  AuthServiceProtocol.swift
//  power
//
//  Created by Samiul Hoque on 10/19/24.
//

import Foundation

@available(macOS 13.0, *)
public protocol PowerAuthServiceProtocol: ObservableObject {
    
    var accessToken: String? { get }
    
    var isAuthorized: Bool { get }
    
    var authorizeUrl: String { get }
    
    func authorize(authCode: String) async throws
}
