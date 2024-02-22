//
//  NetworkManager.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentProfile(completion: @escaping(Result<UserProfile, Error>) ->Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let profile = try decoder.decode(UserProfile.self, from: data)
                    print("GET Profile: \(profile)")
                    
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiUrl = url else {
                return
            }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
        
    }
}
