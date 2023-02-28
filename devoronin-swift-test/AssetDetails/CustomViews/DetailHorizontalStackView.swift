//
//  DetailHorizontalStackView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 28.02.2023.
//

import UIKit

class DetailHorizontalStackView: UIStackView {

    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.axis = .horizontal
        leftLabel.text = "Market Cap"
        rightLabel.text = "$119,150,835,874"
        
        addArrangedSubview(leftLabel)
        addArrangedSubview(rightLabel)
        
        
    }
    
    
    
}
