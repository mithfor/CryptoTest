//
//  WatchListInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation
typealias WatchListInteractorInput =  WatchListViewControllerOutput

protocol WatchListInteractorOutput: AnyObject {
//    func fetchFailure(error: NetworkError)
}

final class WatchListInteractor {
    lazy var watchList = WatchList()
    
    var presenter: WatchListPresenterInput?
}

extension WatchListInteractor: WatchListInteractorInput {
    func fetchFavoriteAssets(watchList: WatchList) {
        print(#function)
    }
    
}
