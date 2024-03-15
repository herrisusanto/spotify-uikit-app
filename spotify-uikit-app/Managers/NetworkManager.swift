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
    // MARK:  - Albums
    public func getAlbumDetails(for album: Album, completion: @escaping(Result<AlbumDetailsResponse, Error>) -> Void) {
        let url = URL(string: Constants.baseApiUrl + "/albums/" + album.id)
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK:  - Playlists
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping(Result<PlaylistDetailsResponse, Error>) -> Void) {
        let url = URL(string: Constants.baseApiUrl + "/playlists/" + playlist.id)
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK:  - Profile
    public func getCurrentProfile(completion: @escaping(Result<UserProfile, Error>) ->Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    //                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    //                    print("Data: \(result)")
                    let profile = try decoder.decode(UserProfile.self, from: data)
                    completion(.success(profile))
                } catch {
                    //                    completion(.failure(error))
                }

            }
            task.resume()
        }
    }

    // MARK:  Category
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let url = URL(string: Constants.baseApiUrl + "/browse/categories?limit=50")
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(CategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getCategoryPlaylist(with category: Category,completion: @escaping (Result<[Playlist], Error>) -> Void) {
        let url = URL(string: Constants.baseApiUrl + "/browse/categories/\(category.id)/playlists?limit=50")
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(CategoryPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    // MARK:  - Search

    public func search(with query: String, completion: @escaping(Result<[SearchResult], Error>) -> Void) {
        let url = URL(string: Constants.baseApiUrl + "/search?limit=50&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(SearchResultResponse.self, from: data)
                    
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap({.track(model: $0)}))
                    searchResults.append(contentsOf: result.albums.items.compactMap({.album(model: $0)}))
                    searchResults.append(contentsOf: result.artists.items.compactMap({.artist(model: $0)}))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({.playlist(model: $0)}))

                    completion(.success(searchResults))
                } catch {
                    print(error.localizedDescription)
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
    // MARK:  Browse
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in

                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }

            }
            task.resume()
        }
    }

    public func getFeaturedPlayLists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/browse/featured-playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getRecommendations(genres: Set<String>,completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseApiUrl + "/recommendations?limit=50&seed_genres=\(seeds)"), type: .GET) { request in  
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                   
                    let result = try decoder.decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
