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

enum NetworkResponse {
    
}

class NetworkManager {
    
    static let shared           = NetworkManager()
    let cache                   = NSCache<NSString, UIImage>()
    
    typealias AssetsHandler = (Result<AssetListResponse, NetworkError>) -> Void
    typealias ImageHandler = (Result<UIImage, NetworkError>) -> Void
    
    private let baseURL: String = "http://api.coincap.io/v2/"
    
    private init() {}
    
    func fetchAssets( page: Int,
                      completed: @escaping AssetsHandler) {
        
        let endpoint = String("\(baseURL)assets")
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.endpoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (jsonData, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let jsonData = jsonData else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                let assets = try decoder.decode(AssetListResponse.self, from: jsonData)
                completed(.success(assets))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func downloadImage(from asset: Asset, completed: @escaping ImageHandler) {
        
        // urlFromAsset
        
        let urlString = "https://cryptoicon-api.vercel.app/api/icon/\(asset.symbol?.lowercased() ?? "btc")"
        
        let cacheKey = NSString(string: urlString)
        
        if let image  = cache.object(forKey: cacheKey) {
            completed(.success(image))
        }
        
        guard let url = URL(string: urlString) else {
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
                if let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: cacheKey)
                    completed(.success(image))
                } else {
                    completed(.failure(.invalidData))
                }
                
            }
        }
        
        task.resume()
    }
}
