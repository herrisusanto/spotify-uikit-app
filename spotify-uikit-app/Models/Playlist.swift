//
//  Playlist.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
