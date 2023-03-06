//
//  WatchList.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation

class WatchList : ObservableObject {
    @Published var assets: Set<String>
    @Published var key = "Watchlist"
    
    init() {
        
        //load saved adata
        assets = []
    }
    
    func contains(_ asset: Asset) -> Bool {
        print(#function)
        return assets.contains(asset.id ?? "bitcoin")
    }
    
    func add(_ asset: Asset) {
        print(#function)
        objectWillChange.send()
        assets.insert(asset.id ?? "bitcoin")
        save()
    }
    
    func remove(_ asset: Asset) {
        print(#function)
        objectWillChange.send()
        assets.remove(asset.id ?? "bitcoin")
        save()
    }
    
    func save() {
        // write out our data
        
        print(#function)
    }
    
    func load() -> Set<String>{
        print(#function)
        return Set<String>()
    }
}
