//
//  Artist.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let externalUrls: [String: String]
    let images: [APIImage]?
}
