//
//  SpotifyApiTrack.swift
//  power-library
//
//  Created by Samiul Hoque on 9/30/24.
//

struct SpotifyApiTrack: Decodable {
    
    let album: SpotifyApiAlbum
    
    let artists: [SpotifyApiSimplifiedArtist]
    
    let availableMarkets: [String]
    
    let discNumber: Int
    
    let durationMs: Int
    
    let explicit: Bool
    
    let externalIds: SpotifyApiExternalIds
    
    let externalUrls: SpotifyApiExternalUrls
    
    let href: String
    
    let id: String
    
    let isPlayable: Bool?
    
    let linkedFrom: SpotifyApiLinkedFrom?
    
    let restrictions: SpotifyApiRestrictions?
    
    let name: String
    
    let popularity: Int
    
    let previewUrl: String?
    
    let trackNumber: Int
    
    let type: String
    
    let uri: String
    
    let isLocal: Bool?
}

private extension SpotifyApiTrack {
    
    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMs = "duration_ms"
        case explicit
        case externalIds = "external_ids"
        case externalUrls = "external_urls"
        case href
        case id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions
        case name
        case popularity
        case previewUrl = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
        case isLocal
    }
}
