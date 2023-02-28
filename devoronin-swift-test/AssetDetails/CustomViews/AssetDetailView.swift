//
//  DetailView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 28.02.2023.
//

import UIKit

final class AssetDetailView: UIView {
    
    //MARK: VARIABLES
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var assetPriceUSDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        label.textColor = ColorConstants.Asset.priceUSD
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    lazy var assetChangePercent24HrLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textColor = ColorConstants.Asset.changePercent24HrPositive
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var fooView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fooView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fooView3: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupScrollViewContstraints()
        setupContentViewConstraints()
        
        setupAssetPriceUSDLabelConstraints()
        setupAssetChangePercent24HrLabelConstraints()
        setupChartViewConstraints()
        setupStackViewConstraints()
        setupFooViewsConstraints()
    }
    
    // MARK: - CONSTRAINTS METHODS
    
    private func setupScrollViewContstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
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
            assetPriceUSDLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.50)
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
    
    private func setupChartViewConstraints() {
        contentView.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 240),
            chartView.topAnchor.constraint(lessThanOrEqualTo: assetChangePercent24HrLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 172),
            stackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupFooViewsConstraints() {
        
        stackView.addArrangedSubview(fooView1)
        stackView.addArrangedSubview(fooView2)
        stackView.addArrangedSubview(fooView3)
        
        NSLayoutConstraint.activate([
            fooView1.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            fooView1.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            fooView2.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            fooView2.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            fooView3.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            fooView3.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    
    
 
    
//    private func setupItemImageViewConstraints() {
//        contentView.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.50)
//        ])
//    }
//
//    private func setupDescriptionLabelConstraints() {
//        contentView.addSubview(descriptionLabel)
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
//            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
}


