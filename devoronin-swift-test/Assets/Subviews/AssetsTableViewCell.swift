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
        imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
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
            assetImageView.heightAnchor.constraint(equalToConstant: 60)
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
    }
 }

extension AssetsTableViewCell {
    func setIcon(_ image: UIImage?) {
        
        guard let image = image else {return}
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        iconView.image = image
        let iconConteinerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
        iconConteinerView.addSubview(iconView)
    }
}


   
