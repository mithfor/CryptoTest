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
        view.backgroundColor = ColorConstants.mainBackground
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(detailView)
    }
    
    private func updateUI() {
        
        title = "\(asset.name ?? "") \(asset.symbol ?? "")"
        
        detailView.assetPriceUSDLabel.text = "$\(String.formatToCurrency(string: asset.priceUsd ?? ""))"
        
        let changePercent24HrTrend = Double(asset.changePercent24Hr ?? "0.00") ?? 0.0
        detailView.assetChangePercent24HrLabel.textColor = changePercent24HrTrend >= 0
                                                ? ColorConstants.Asset.changePercent24HrPositive
                                                : ColorConstants.Asset.changePersent24HrNegative
        let positiveSign = changePercent24HrTrend >= 0 ? "+" : ""
        detailView.assetChangePercent24HrLabel.text = "\(positiveSign)\(String.formatToCurrency(string: asset.changePercent24Hr ?? ""))%"
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetDetailsViewController().showPreview()
//    }
//}
