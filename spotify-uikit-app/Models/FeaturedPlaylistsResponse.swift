//
//  FeaturedPlaylistsResponse.swift
//  spotify-uikit-app
//
//  Created by loratech on 11/03/24.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}

struct User: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
}
