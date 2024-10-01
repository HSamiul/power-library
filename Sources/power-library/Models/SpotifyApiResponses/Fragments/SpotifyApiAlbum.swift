//
//  SpotifyApiAlbum.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

struct SpotifyApiAlbum: Decodable {
    
    let albumType: String
    
    let totalTracks: Int
    
    let availableMarkets: [String]
    
    let externalUrls: SpotifyApiExternalUrls
    
    let href: String
    
    let id: String
    
    let images: [SpotifyApiImage]
    
    let name: String
    
    let releaseDate: String
    
    let releaseDatePrecision: String
    
    let restrictions: SpotifyApiRestrictions?
    
    let type: String
    
    let uri: String
    
    let artists: [SpotifyApiSimplifiedArtist]
}

private extension SpotifyApiAlbum {
    
    enum CodingKeys: String, CodingKey {
        
        case albumType = "album_type"
        
        case totalTracks = "total_tracks"
        
        case availableMarkets = "available_markets"
        
        case externalUrls = "external_urls"
        
        case href = "href"
        
        case id = "id"
        
        case images = "images"
        
        case name = "name"
        
        case releaseDate = "release_date"
        
        case releaseDatePrecision = "release_date_precision"
        
        case restrictions = "restrictions"
        
        case type = "type"
        
        case uri = "uri"
        
        case artists = "artists"
    }
}
