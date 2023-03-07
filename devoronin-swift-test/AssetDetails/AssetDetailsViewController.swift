//
//  AssetDetailsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit
import SwiftUI

protocol AssetDetailsViewControllerInput: AnyObject {
    func updateHistory(with assetHistory: [AssetHistory])
    func updateFailed(with error: NetworkError)
}

protocol AssetDetailsViewControllerOutput: AnyObject {
    func fetchHistory(asset: Asset)
}

final class AssetDetailsViewController: UIViewController {
    
    //MARK: - Private vars
    private let asset: Asset
    private let watchList = WatchList()
    
    var interactor: AssetDetailsInteractorInput?
    
    private var detailView: AssetDetailsView = {
        let view = AssetDetailsView()
        
        return view
    }()
    
    
    
    // MARK: - Init
    init(asset: Asset) {
        self.asset = asset

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        interactor?.fetchHistory(asset: asset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        detailView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = Constants.Color.mainBackground
        navigationItem.largeTitleDisplayMode = .never
    
        view.addSubview(detailView)
    }
    

    // MARK: UPDATES
    private func updateUI() {
                
        updateTitle(with: asset.name ?? "Default Name", and: asset.symbol ?? "Default Symbol")
        
        updateWatchList()
        
        updateDetailView()
    }
    
    private func updateDetailView() {
        detailView.updateAssetPriceUSD(with: "$\(String.formatToCurrency(string: asset.priceUsd ?? "No data"))", and: Constants.Color.Asset.symbol)
        detailView.updateAssetChangePercent24Hr(with: asset.changePercent24Hr ?? "No data")
        detailView.updateLine1(with: "$\(String.formatToCurrency(string: asset.marketCapUsd ?? "No data"))")
        detailView.updateLine2(with: "$\(String.formatToCurrency(string: asset.maxSupply ?? "No data"))")
        detailView.updateLine3(with: "$\(String.formatToCurrency(string: asset.volumeUsd24Hr ?? "No data"))")
    }
    
    private func updateWatchList() {
        
        watchList.load()
        
        let imageName = watchList.contains(asset) == false ? Constants.Icon.watchlist : Constants.IconFill.watchlist
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: #selector(didTapAddToWatchList))
    }
    
    
    //MARK: - ACTIONS
    @objc func didTapAddToWatchList() {
        
        var imageName = ""
        if watchList.contains(asset) {
            imageName = Constants.Icon.watchlist
            watchList.remove(asset)
           
        } else {
            imageName = Constants.IconFill.watchlist
            watchList.add(asset)
        }

        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        
                
    }
}

extension AssetDetailsViewController: AssetDetailsViewControllerInput {
    func updateHistory(with assetHistory: [AssetHistory]) {
        detailView.updateHistoryChart(with: assetHistory)
    }
    
    func updateTitle(with name: String, and symbol: String) {
        
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: name, attributes:[
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: AppConstants.navigationItemTextSize),
                                                    NSAttributedString.Key.foregroundColor: Constants.Color.Asset.symbol,])
        navTitle.append(NSMutableAttributedString(string: " "))
        navTitle.append(NSMutableAttributedString(string: symbol, attributes:[
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: AppConstants.navigationItemTextSize),
                                                    NSAttributedString.Key.foregroundColor: Constants.Color.Asset.name]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: "NetworkError", message: error.rawValue, buttonTitle: "OK")
    }
}
