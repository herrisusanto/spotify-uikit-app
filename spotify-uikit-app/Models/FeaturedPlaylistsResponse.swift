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



struct User: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
}
