//
//  CategoriesResponse.swift
//  spotify-uikit-app
//
//  Created by loratech on 14/03/24.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}


struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
