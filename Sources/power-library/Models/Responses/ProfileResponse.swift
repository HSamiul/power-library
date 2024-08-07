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

private extension ProfileResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case country = "country"
        
        case displayName = "display_name"
        
        case email = "email"
        
        case explicitContent = "explicit_content"
        
        case externalUrls = "external_urls"
        
        case followers = "followers"
        
        case href = "href"
        
        case id = "id"
        
        case images = "images"
        
        case product = "product"
        
        case type = "type"
        
        case uri = "uri"
    }
}
