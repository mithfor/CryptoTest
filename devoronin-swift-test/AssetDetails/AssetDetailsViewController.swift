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
    
    private var assetPriceUSDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        label.textColor = ColorConstants.Asset.priceUSD
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var assetChangePercent24HrLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textColor = ColorConstants.Asset.changePercent24HrPositive
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupLayout()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = ColorConstants.mainBackground
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(assetPriceUSDLabel)
        view.addSubview(assetChangePercent24HrLabel)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            assetPriceUSDLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            assetPriceUSDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            assetPriceUSDLabel.heightAnchor.constraint(equalToConstant: 76)
        ])
        
        NSLayoutConstraint.activate([
            assetChangePercent24HrLabel.topAnchor.constraint(equalTo: assetPriceUSDLabel.bottomAnchor, constant: 8),
            assetChangePercent24HrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            assetChangePercent24HrLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        
    }
    
    private func updateUI() {
        title = "\(asset.name ?? "") \(asset.symbol ?? "")"
        
        assetPriceUSDLabel.text = "$\((asset.priceUsd ?? "").decimalPlaces(equalsTo: 2))"
        
        let changePercent24HrTrend = Double(asset.changePercent24Hr ?? "0.00") ?? 0.0
        assetChangePercent24HrLabel.textColor = changePercent24HrTrend >= 0
                                                ? ColorConstants.Asset.changePercent24HrPositive
                                                : ColorConstants.Asset.changePersent24HrNegative
        let positiveSign = changePercent24HrTrend >= 0 ? "+" : ""
        assetChangePercent24HrLabel.text = "\(positiveSign)\(NSString(format: "%.2f", changePercent24HrTrend))%"
                title = "\(asset.name ?? "") \(asset.symbol ?? "")"
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetDetailsViewController().showPreview()
//    }
//}
