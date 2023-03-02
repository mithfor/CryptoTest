//
//  AssetDetailsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit
import SwiftUI

final class AssetDetailsViewController: UIViewController {
    
    //MARK: - Private vars
    private let asset: Asset
    
    private var detailView: AssetDetailView = {
        let view = AssetDetailView()
        
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
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watchlist", style: .plain, target: self, action: #selector(didTapAddToWatchList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Icon.watchlist, style: .plain, target: self, action: #selector(didTapAddToWatchList))

        
        view.addSubview(detailView)
    }
    
    @objc func didTapAddToWatchList() {
        print(#function)
    }
    
    private func updateUI() {
        
        title = "\(asset.name ?? "") \(asset.symbol ?? "")"
        
        detailView.updateAssetPriceUSD(with: "$\(String.formatToCurrency(string: asset.priceUsd ?? "No data"))", and: Constants.Color.Asset.priceUSD)
        
        detailView.updateAssetChangePercent24Hr(with: "\(String.formatToCurrency(string: asset.changePercent24Hr ?? "No data"))%", and: Constants.Color.Asset.priceUSD)
        
        detailView.updateLine1(with: "$\(String.formatToCurrency(string: asset.marketCapUsd ?? "No data"))")
        detailView.updateLine2(with: "$\(String.formatToCurrency(string: asset.maxSupply ?? "No data"))")
        detailView.updateLine3(with: "$\(String.formatToCurrency(string: asset.volumeUsd24Hr ?? "No data"))")
        
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetDetailsViewController().showPreview()
//    }
//}


