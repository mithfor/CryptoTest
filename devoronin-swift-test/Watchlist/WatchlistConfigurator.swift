//
//  WatchListConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation

protocol WatchListConfiguratorProtocol {
    static func configured(_ vc: WatchListViewController, with watchList: WatchList) -> WatchListViewController
}

class WatchListConfigurator: WatchListConfiguratorProtocol {
    static func configured(_ vc: WatchListViewController, with watchList: WatchList = WatchList()) -> WatchListViewController {
        let interactor = WatchListInteractor()
        let presenter = WatchListPresenter()
        vc.interactor = interactor
        // Inject Data
        vc.watchlist = watchList
        interactor.presenter = presenter
        presenter.viewController = vc as? WatchListPresenterOutput
        
        return vc
    }
}
