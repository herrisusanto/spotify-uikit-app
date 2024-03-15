//
//  SearchResult.swift
//  spotify-uikit-app
//
//  Created by loratech on 15/03/24.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
