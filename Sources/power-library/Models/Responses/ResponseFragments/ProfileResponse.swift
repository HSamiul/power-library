//
//  ProfileResponse.swift
//  
//
//  Created by Samiul Hoque on 8/6/24.
//

struct ProfileResponse: Decodable {
    
     let country: String
    
     let displayName: String
    
     let email: String
    
     let explicitContent: ExplicitContent
    
     let externalUrls: ExternalUrls
    
     let followers: Followers
    
     let href: String
    
     let id: String
    
     let images: [Image]
    
     let product: String
    
     let type: String
    
     let uri: String
}
