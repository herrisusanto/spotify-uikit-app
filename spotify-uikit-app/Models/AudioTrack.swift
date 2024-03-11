//
//  AudioTrack.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: [String: String]
    let id: String
    let name: String
    let popularity: Int
}
