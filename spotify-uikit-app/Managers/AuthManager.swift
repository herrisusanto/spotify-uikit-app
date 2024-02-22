//
//  AuthManager.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    private var refreshingToken: Bool = false
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public var signInUrl: URL? {
        let urlString = "\(Constants.baseUrl)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectUri)&show_dialog=TRUE"
        return URL(string: urlString)
    }
    
    var isSignIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void )) {
        // MARK:  Get token
        guard let url = URL(string: Constants.tokenApiUrl) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.herisusanto.com")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failed to get base 64 string.")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(AuthResponse.self, from: data)
                print("Successfully refreshed!")
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print("Error is here: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
        
    }
    
    public func refreshIfNeeded(completion: @escaping(Bool) -> Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        // MARK:  Refresh token
        guard let url = URL(string: Constants.tokenApiUrl) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems  = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            self.refreshingToken = false
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(AuthResponse.self, from: data)
                self.onRefreshBlocks.forEach{ $0(result.accessToken)}
                self.onRefreshBlocks.removeAll()
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
            
        }
        task.resume()
    }
    
    public func cacheToken(result: AuthResponse) {
        PersistenceManager.save(result.accessToken, forKey: .accessToken)
        if let refreshToken = result.refreshToken {
            PersistenceManager.save(refreshToken as Any, forKey: .refreshToken)
        }
        PersistenceManager.save(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: .expirationToken)
         
        
    }
    // MARK:  Supplies valid token to be used with Network Manager
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // MARK:  Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            // MARK:  Refresh token
            refreshIfNeeded { [weak self] success in
                guard let self = self else { return }
                if let token = self.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
}
