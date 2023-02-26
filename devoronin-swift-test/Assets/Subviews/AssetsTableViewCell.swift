//
//  AssetsTableViewCell.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

class AssetsTableViewCell: UITableViewCell {
    
    static let identifier = "AssetsTableViewCell"
    
    var assetDetailsButtonCompletion: () -> () = {}

    private var assetDetailsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: IconConstants.details),
                        for: .normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func assetDetailButtonDidTap() {
        assetDetailsButtonCompletion()
    }
    
    // MARK: - Setup
    private func setupUI() {
       autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
       contentView.addSubview(assetDetailsButton)

       contentView.clipsToBounds = true
       contentView.contentMode = .center
       contentView.isMultipleTouchEnabled = true

       assetDetailsButton.contentVerticalAlignment = .center
       assetDetailsButton.tintColor = UIColor.systemGray2
       assetDetailsButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
        assetDetailsButton.addTarget(self,
                                     action: #selector(assetDetailButtonDidTap),
                                     for: .touchUpInside)

    }
    
    private func setupLayout() {
       trailingAnchor.constraint(equalTo: assetDetailsButton.trailingAnchor, constant: 8).isActive = true
       assetDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
       assetDetailsButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
 }


   
