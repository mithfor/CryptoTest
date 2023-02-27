//
//  AssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation
import UIKit

typealias AssetsPresenterInput = AssetsInteractorOutput
typealias AssetsPresenterOutput = AssetsViewControllerInput

final class AssetsPresenter {
    weak var viewController: AssetsPresenterOutput?
}

extension AssetsPresenter: AssetsPresenterInput {
    func fetched(image: UIImage, completion: (UIImage) -> ()) {
        completion(image)
    }
    
    func fetchFailure() {
        print(#function)
    }
    
    func fetched(assets: Assets) {
        viewController?.updateAssets(assets: assets)
    }
}
