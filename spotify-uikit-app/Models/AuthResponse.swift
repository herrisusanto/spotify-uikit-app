//
//  AuthResponse.swift
//  spotify-uikit-app
//
//  Created by loratech on 22/02/24.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
}
