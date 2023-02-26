//
//  AssetsTableViewCell.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

protocol AssetsTableViewCellDelegate: class {
    func assetDetails(with data: Int)
}

class AssetsTableViewCell: UITableViewCell {
    
    static let identifier = "AssetsTableViewCell"
    
    weak var delegate: AssetsTableViewCellDelegate?
    
    private var assetId: Int = .zero
    private var assetImage: UIImage?
    
    private var assetDetailsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: IconConstants.details),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var assetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()
    
    
    private var assetFullTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var assetShortTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func assetDetailsButtonDidTap() {
        delegate?.assetDetails(with: assetId)
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
        contentView.addSubview(assetImageView)
        
        contentView.addSubview(assetFullTitleLabel)
        contentView.addSubview(assetShortTitleLabel)
        

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            assetDetailsButton.trailingAnchor.constraint (equalTo: contentView.trailingAnchor, constant: -16),
            assetDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assetDetailsButton.heightAnchor.constraint(equalToConstant: 22),
            assetDetailsButton.widthAnchor.constraint(equalToConstant: 16),
            
            assetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            assetImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assetImageView.widthAnchor.constraint(equalToConstant: 60),
            assetImageView.heightAnchor.constraint(equalToConstant: 60),
            
            
            assetFullTitleLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: 8),
            assetFullTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            assetShortTitleLabel.leadingAnchor.constraint(equalTo: assetFullTitleLabel.leadingAnchor),
            assetShortTitleLabel.topAnchor.constraint(equalTo: assetFullTitleLabel.bottomAnchor, constant: 0)
            
        ])
    }
    
    func configureWith(delegate: AssetsTableViewCellDelegate, and data: Int, image: UIImage?) {
        self.delegate = delegate
        self.assetId = data
        self.assetImage = image
        update()
    }
    
    func update() {
        assetImageView.image = assetImage
        assetFullTitleLabel.text = "BTC"
        assetShortTitleLabel.text = "Bitcoin"
    }
 }


   
