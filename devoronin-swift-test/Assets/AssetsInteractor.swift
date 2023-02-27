//
//  AssetsInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation
import UIKit

typealias Assets = [Asset]
typealias AssetsInteractorInput = AssetsViewControllerOutput

protocol AssetsInteractorOutput: AnyObject {
    func fetched(assets: Assets)
    func fetched(image: UIImage, completion: @escaping ((UIImage) -> ()))
    func fetchFailure()
}

final class AssetsInteractor {
    private var assets = Assets()
    
    var presenter: AssetsPresenterInput?
}

extension AssetsInteractor: AssetsInteractorInput {
    
    func fetchImageFor(asset: Asset, completion: @escaping (UIImage) -> ()){
//        NetworkManager.shared.downloadImage(from: asset) { [weak self] result in
//            switch result {
//            case .success(let image):
//                self?.presenter?.fetched(image: image, completion: completion)
//            case .failure(let error):
//                print(error)
//            }
//        }
        guard let image = UIImage(named: asset.symbol?.lowercased() ?? "usd") else {
            return completion(UIImage(named: "usd") ?? UIImage())
        }
        self.presenter?.fetched(image: image, completion: completion)
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
