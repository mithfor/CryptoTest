//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 08.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.


import UIKit

enum NetworkError: String, Error {
    case endpoint = "Bad endpoint"
    case badResponse = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorites = "No favorites. Please try again"
    case alreadyInFavorites = "This user is already in your favorites!"
}

class NetworkManager {
    
    static let shared           = NetworkManager()
    let cache                   = NSCache<NSString, UIImage>()
    private let baseURL: String = "api.coincap.io/v2/"
    
    private init() {}
    
    func fetchAssets( page: Int,
                      completed: @escaping (Result<[Asset], NetworkError>) -> Void) {
        
        let endpoint = baseURL + "/assets"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.endpoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Asset].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
//    func getUserInfo(for username: String,
//                     completed: @escaping (Result<User, GFError>) -> Void) {
//
//          let endpoint = baseURL + "\(username)"
//
//          guard let url = URL(string: endpoint) else {
//              completed(.failure(.invalidUserName))
//              return
//          }
//
//          let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//              if let _ = error {
//                  completed(.failure(.unableToComplete))
//                  return
//              }
//
//              guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200 else {
//                      completed(.failure(.invalidResponse))
//                      return
//              }
//
//              guard let data = data else {
//                  completed(.failure(.invalidData))
//                  return
//              }
//
//              do {
//                  let decoder                 = JSONDecoder()
//                decoder.dateDecodingStrategy  = .iso8601
//                  let user                    = try decoder.decode(User.self, from: data)
//                  completed(.success(user))
//              } catch {
//                  completed(.failure(.invalidData))
//              }
//          }
//
//          task.resume()
//      }
    
    func downLoadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image  = cache.object(forKey: cacheKey) {
            completed(image)
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }   
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
