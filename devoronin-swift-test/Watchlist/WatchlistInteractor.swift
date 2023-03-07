//
//  WatchlistInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation
typealias WatchlistInteractorInput =  AssetDetailsViewControllerOutput

protocol WatchlistInteractorOutput: AnyObject {
//    func historyFetched(assetHistory : [AssetHistory])
    func fetchFailure(error: NetworkError)
}

final class WatchlistInteractor {}
