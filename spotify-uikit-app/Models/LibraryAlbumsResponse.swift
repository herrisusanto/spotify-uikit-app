//
//  LibraryAlbumsResponse.swift
//  spotify-uikit-app
//
//  Created by loratech on 19/03/24.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let addedAt: String
    let album: Album
}
