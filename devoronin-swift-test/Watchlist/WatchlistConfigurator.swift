//
//  WatchListConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation

protocol WatchListConfiguratorProtocol {
    static func configured(_ vc: WatchListViewController) -> WatchListViewController
}

class WatchListConfigurator: WatchListConfiguratorProtocol {
    
    static func configured(_ vc: WatchListViewController) -> WatchListViewController {
        let interactor = WatchListInteractor()
        let presenter = WatchListPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc as? WatchListPresenterOutput
        
        return vc
    }
}
