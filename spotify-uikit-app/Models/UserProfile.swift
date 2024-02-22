//
//  UserProfile.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let displayName: String
    let email: String
    let explicitContent: [String: Int]
    let externalUrls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}

