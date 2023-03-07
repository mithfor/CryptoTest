//
//  WatchlistConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation

protocol WatchlistConfiguratorProtocol {
    static func configured(_ vc: WatchlistViewController) -> WatchlistViewController
}

class WatchlistConfigurator: WatchlistConfiguratorProtocol {
    
    static func configured(_ vc: WatchlistViewController) -> WatchlistViewController {
        let interactor = WatchlistInteractor()
//        let presenter = AssetDetailsPresenter()
//        vc.interactor = interactor
//        interactor.presenter = presenter
//        presenter.viewController = vc
        
        return vc
    }
}
