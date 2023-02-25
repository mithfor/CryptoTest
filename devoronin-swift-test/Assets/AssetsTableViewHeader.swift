//
//  AssetsTableViewHeader.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

class AssetsTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Static vars
    static let identifier = "TableHeader"
    
    //MARK: - Private vars
    private let label: UILabel = {
       let label = UILabel()
        label.text = TitlesConstants.assets
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchTextField = SearchTextField()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(searchTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 41),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            searchTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
