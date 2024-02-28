//
//  UserProfile.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

struct UserProfile: Codable {
    let country, display_name, email: String
    let explicit_content: ExplicitContent
    let external_urls: ExternalUrls
    let followers: Followers
    let href, id: String
    let images: [Image]
    let product, type, uri: String
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filter_enabled, filter_locked: Bool
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Followers
struct Followers: Codable {
    let href: String
    let total: Int
}

// MARK: - Image
struct Image: Codable {
    let url: String
    let height, width: Int
}

