//
//  NewReleasesResponse.swift
//  spotify-uikit-app
//
//  Created by loratech on 11/03/24.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    let artists: [Artist]
}



