//
//  Constants.swift
//  spotify-uikit-app
//
//  Created by loratech on 22/02/24.
//

import Foundation
import UIKit

struct Constants {
    static let clientID = "0d5352e04ca543bbb4dcc3c543d1b032"
    static let clientSecret = "d401630e197741c4b8c2645ef69a7955"
    static let tokenApiUrl = "https://accounts.spotify.com/api/token"
    static let redirectUri = "https://www.herisusanto.com"
    static let baseUrl = "https://accounts.spotify.com/authorize"
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read"
    
    static let baseApiUrl = "https://api.spotify.com/v1"
}

enum Images {
    static let spotifyIconWhite = UIImageView(image: UIImage(named: "Spotify_Icon_RGB_White"))
    static let spotifyIconBlack = UIImageView(image: UIImage(named: "Spotify_Icon_RGB_Black"))
    static let spotifyIconGreen = UIImageView(image: UIImage(named: "Spotify_Icon_RGB_Green"))
    
    static let spotifyLogoWhite = UIImageView(image: UIImage(named: "Spotify_Logo_RGB_White"))
    static let spotifyLogoBlack = UIImageView(image: UIImage(named: "Spotify_Logo_RGB_Black"))
    static let spotifyLogoGreen = UIImageView(image: UIImage(named: "Spotify_Logo_RGB_Green"))
    
    static let googleLogo = UIImage(named: "ios_neutral_rd_na")
    static let facebookLogo = UIImage(named: "facebook")
    static let spotifyLogo = UIImage(named: "Spotify_Icon_RGB_Green")
}

enum Colors {
    static let primaryBlack = UIColor(named: "primaryBlack")
    static let primaryWhite = UIColor(named: "primaryWhite")
    static let primaryGreen = UIColor(named: "primaryGreen")
}
