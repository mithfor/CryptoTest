//
//  AssetsTableViewCell.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

protocol AssetsTableViewCellDelegate: class {
    func assetDetailsButtonDidTap(with data: Int)
}

class AssetsTableViewCell: UITableViewCell {
    
    static let identifier = "AssetsTableViewCell"
    
    weak var delegate: AssetsTableViewCellDelegate?

    private var assetDetailsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: IconConstants.details),
                        for: .normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var assetId: Int = .zero
    
    
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
    @objc func assetDetailsButtonDidTap() {
        delegate?.assetDetailsButtonDidTap(with: assetId)
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
                                     action: #selector(assetDetailsButtonDidTap),
                                     for: .touchUpInside)
    }
    
    private func setupLayout() {
       trailingAnchor.constraint(equalTo: assetDetailsButton.trailingAnchor, constant: 8).isActive = true
       assetDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
       assetDetailsButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func configureWith(delegate: AssetsTableViewCellDelegate, and data: Int) {
        self.delegate = delegate
        self.assetId = data
    }
 }


   
