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
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var fooView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var fooView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var fooView3: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
//        fooView.addSubview(assetPriceUSDLabel)
        
        stackView.addArrangedSubview(fooView1)
        stackView.addArrangedSubview(fooView2)
        stackView.addArrangedSubview(fooView3)
        
        view.addSubview(assetPriceUSDLabel)
        view.addSubview(assetChangePercent24HrLabel)
        view.addSubview(chartView)
        view.addSubview(stackView)
        
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
        
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 150),
            chartView.topAnchor.constraint(lessThanOrEqualTo: assetChangePercent24HrLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 172),
            stackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            fooView1.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            fooView1.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            fooView2.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            fooView2.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            fooView3.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            fooView3.heightAnchor.constraint(equalToConstant: 44)
        ])
        
//        NSLayoutConstraint.activate([
//            assetPriceUSDLabel.leadingAnchor.constraint(equalTo: fooView.leadingAnchor, constant: 8),
//            assetPriceUSDLabel.centerYAnchor.constraint(equalTo: fooView.centerYAnchor),
//            assetPriceUSDLabel.heightAnchor.constraint(equalTo: fooView.heightAnchor, multiplier: 0.9)
//        ])
        
    }
    
    private func updateUI() {
        
        title = "\(asset.name ?? "") \(asset.symbol ?? "")"
        
        assetPriceUSDLabel.text = "$\(String.formatToCurrency(string: asset.priceUsd ?? ""))"
        
        let changePercent24HrTrend = Double(asset.changePercent24Hr ?? "0.00") ?? 0.0
        assetChangePercent24HrLabel.textColor = changePercent24HrTrend >= 0
                                                ? ColorConstants.Asset.changePercent24HrPositive
                                                : ColorConstants.Asset.changePersent24HrNegative
        let positiveSign = changePercent24HrTrend >= 0 ? "+" : ""
        assetChangePercent24HrLabel.text = "\(positiveSign)\(String.formatToCurrency(string: asset.changePercent24Hr ?? ""))%"
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetDetailsViewController().showPreview()
//    }
//}
