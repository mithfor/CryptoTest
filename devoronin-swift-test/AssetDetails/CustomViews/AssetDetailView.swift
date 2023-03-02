//
//  DetailView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 28.02.2023.
//

import UIKit
import Charts

protocol AssetDetailAccessable: class {
    
    func updateLine1(with value: String)
    func updateLine2(with value: String)
    func updateLine3(with value: String)
    func updateAssetPriceUSD(with text: String, and color:  UIColor)
    func updateAssetChangePercent24Hr(with value: String, and color:  UIColor)
}

final class AssetDetailView: UIView, ChartViewDelegate {
    //MARK: - CHARTS
    
     var barChart = BarChartView()
    
    
    //MARK: VARIABLES
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var assetPriceUSDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        label.textColor = Constants.Color.Asset.priceUSD
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private lazy var assetChangePercent24HrLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textColor = Constants.Color.Asset.changePercent24HrPositive
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chartViewController: ChartViewController = {
        let vc = ChartViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    private lazy var stackLine1: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Market Cap"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    private lazy var stackLine2: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Supply"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    private lazy var stackLine3: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Volume (24h)"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        barChart.delegate = self
        
        setupScrollViewContstraints()
        setupContentViewConstraints()
        
        setupAssetPriceUSDLabelConstraints()
        setupAssetChangePercent24HrLabelConstraints()
        setupChartControllerViewConstraints()
        setupStackViewConstraints()
        setupLinesConstraints()
    }
    
    // MARK: - CONSTRAINTS METHODS
    
    private func setupScrollViewContstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupContentViewConstraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
        ])
    }
    
    private func setupAssetPriceUSDLabelConstraints(){
        contentView.addSubview(assetPriceUSDLabel)
        NSLayoutConstraint.activate([
            assetPriceUSDLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            assetPriceUSDLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            assetPriceUSDLabel.heightAnchor.constraint(equalToConstant: 76),
        ])
    }
    
    private func setupAssetChangePercent24HrLabelConstraints() {
        contentView.addSubview(assetChangePercent24HrLabel)
        NSLayoutConstraint.activate([
            assetChangePercent24HrLabel.topAnchor.constraint(equalTo: assetPriceUSDLabel.bottomAnchor, constant: 8),
            assetChangePercent24HrLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            assetChangePercent24HrLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func setupChartControllerViewConstraints() {
        contentView.addSubview(chartViewController.view)
        NSLayoutConstraint.activate([
            chartViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartViewController.view.heightAnchor.constraint(equalToConstant: 240),
            chartViewController.view.topAnchor.constraint(lessThanOrEqualTo: assetChangePercent24HrLabel.bottomAnchor, constant: 10)
        ])
        chartViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 172),
            stackView.topAnchor.constraint(equalTo: chartViewController.view.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupLinesConstraints() {
        
        stackView.addArrangedSubview(stackLine1)
        stackView.addArrangedSubview(stackLine2)
        stackView.addArrangedSubview(stackLine3)
        
        NSLayoutConstraint.activate([
            stackLine1.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -24),
            stackLine1.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            stackLine2.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -24),
            stackLine2.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            stackLine3.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -24),
            stackLine3.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}

// MARK: - AssetDetailAccessable
extension AssetDetailView: AssetDetailAccessable {
    func updateAssetPriceUSD(with text: String, and color: UIColor) {
        assetPriceUSDLabel.text = text
    }
    
    func updateAssetChangePercent24Hr(with value: String, and color: UIColor) {
        assetChangePercent24HrLabel.text = value
    }
    
    func updateLine1(with value: String) {
        stackLine1.rightLabel.text = value
    }
    
    func updateLine2(with value: String) {
        stackLine2.rightLabel.text = value
    }
    
    func updateLine3(with value: String) {
        stackLine3.rightLabel.text = value
    }
}

// MARK - ChartViewDelegate

extension AssetDetailsViewController: ChartViewDelegate {


}


