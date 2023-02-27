//
//  AssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias AssetsPresenterInput = AssetsInteractorOutput
typealias AssetsPresenterOutput = AssetsViewControllerInput

final class AssetsPresenter {
    weak var viewController: AssetsPresenterOutput?
}

extension AssetsPresenter: AssetsPresenterInput {
    func fetchFailure() {
        print(#function)
    }
    
    func fetched(assets: Assets) {
        viewController?.updateAssets(assets: assets)
    }
}
