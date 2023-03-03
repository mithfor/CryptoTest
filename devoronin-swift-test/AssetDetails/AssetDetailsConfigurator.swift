//
//  AssetDetailsConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 03.03.2023.
//

import Foundation

protocol AssetDetailsCongfigurator {
    static func configured(_ vc: AssetDetailsViewController) -> AssetDetailsViewController
}

class DefaultAssetDetailsConfigurator: AssetDetailsCongfigurator {

    
    static func configured(_ vc: AssetDetailsViewController) -> AssetDetailsViewController {
        let interactor = AssetDetailsInteractor()
        let presenter = AssetDetailsPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc as? AssetDetailsPresenterOutput
        
        return vc
    }
}
