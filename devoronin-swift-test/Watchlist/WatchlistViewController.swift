//
//  WatchlistViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    var watchlist = WatchList()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        
        print(DatabaseManager().load())
        
        setupUI()
        
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }

}
