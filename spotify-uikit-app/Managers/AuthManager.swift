//
//  AuthManager.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "0d5352e04ca543bbb4dcc3c543d1b032"
        static let clientSecret = "d401630e197741c4b8c2645ef69a7955"
    }
    
    private init() {}
    
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://www.herisusanto.com"
        let urlString = "\(baseUrl)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: urlString)
    }
    
    var isSignIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void )) {
        
    }
    
    public func refreshAccessToken() {
        
    }
    
    public func cacheToken() {
        
    }
}
