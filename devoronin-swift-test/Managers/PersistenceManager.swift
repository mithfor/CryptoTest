//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 27.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorities):
                
                switch actionType {
                case .add:
                    guard !favorities.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorities.append(favorite)
                    
                case .remove:
                    favorities.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: favorities))
                
            case .failure(let error):
                completed(error)
            }
            
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorites
        }
    }
}
