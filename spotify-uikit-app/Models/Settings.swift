//
//  Settings.swift
//  spotify-uikit-app
//
//  Created by loratech on 22/02/24.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
