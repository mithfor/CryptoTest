//
//  WatchList.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation

class WatchList : ObservableObject {
    var assets = Set<String>()
    var key = "WatchList"
    
    init() {
        
        //load saved adata
        self.load()
    }
    
    func contains(_ asset: Asset) -> Bool {
        print(#function)
        return assets.contains(asset.id ?? "bitcoin")
    }
    
    func add(_ asset: Asset) {

        assets.insert(asset.id ?? "bitcoin")
        save()
    }
    
    func remove(_ asset: Asset) {
        assets.remove(asset.id ?? "bitcoin")
        save()
    }
    
    func save() {
        UserDefaults.standard.set(Array(assets), forKey: key)
    }
    
    func load(){
        let array = UserDefaults.standard.object(forKey: key) as? [String]
        assets = Set(array ?? [String]())
    }
}
