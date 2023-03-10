//
//  WatchListInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation
typealias WatchListInteractorInput = WatchListViewControllerOutput

protocol WatchListInteractorOutput: AnyObject {
    func fetchFailure(error: NetworkError)
    func fetchAssets(_ assets: Assets)
}

final class WatchListInteractor {
    lazy var watchList = WatchList()
    
//    private var asset: Ass®et?
    private var assets = Assets()
    
    var presenter: WatchListPresenterInput?
}


//MARK: - WatchListInteractorInput
extension WatchListInteractor: WatchListInteractorInput {
    
    func fetchAssetDetails(by id: String,
                           completion: @escaping ((AssetResponse) -> ())) {
        
        NetworkManager.shared.fetchAsset(by: id) { [weak self] result in
            switch result {
            case .success(let response):
//                self?.asset = response.data
//                print(self?.asset as Any)
                completion(response)
            case .failure(let error):
                print(error)
                self?.presenter?.fetchFailure(error: error)
            }
        }
        
    }
    
    func fetchFavoriteAssets(watchList: WatchList) {
        print(#function)
        
        watchList.load()
        
        let assetsIds = watchList.assetsIds
        
        DispatchQueue.global().async {
            let group = DispatchGroup()
            
            assetsIds.forEach { id in
                group.enter()
                
                self.fetchAssetDetails(by: id) { [weak self] result in
                    self?.assets.append(result.data)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.presenter?.fetchAssets(self.assets)
            }
        }
    }
}
