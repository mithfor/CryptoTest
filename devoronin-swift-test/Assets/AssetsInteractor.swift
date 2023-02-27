//
//  AssetsInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias Assets = [Asset]
typealias AssetsInteractorInput = AssetsViewControllerOutput

protocol AssetsInteractorOutput: AnyObject {
    func fetched(assets: Assets)
    func fetched(_ assetIcon: AssetIcon, completion: @escaping ((AssetIcon) -> ()))
    func fetchFailure()
}

final class AssetsInteractor {
    private var assets = Assets()
    
    var presenter: AssetsPresenterInput?
}

extension AssetsInteractor: AssetsInteractorInput {
    
    func fetchImageFor(asset: Asset, completion: @escaping (AssetIcon) -> ()){

        let assetIcon = IconManager.shared.fetchIconFor(asset: asset)
        
        self.presenter?.fetched(assetIcon, completion: completion)
    }
    
    func fetchAssets() {
        NetworkManager.shared.fetchAssets(page: 1) { [weak self] result in
            switch result {
            case .success(let responce):
                self?.assets = responce.data
                self?.presenter?.fetched(assets: self?.assets ?? Assets())
            case .failure(_):
                self?.presenter?.fetchFailure()
            }
        }
    }
}


