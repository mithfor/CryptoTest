//
//  WatchlistViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

class WatchlistViewController: UIViewController {
    //MARK: - VARIABLES
    var watchlist = WatchList()
    
    private lazy var assetsTableView: AssetsTableView = {
        let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self, forCellReuseIdentifier: AssetsTableViewCell.identifier)
        
        tableView.backgroundColor = .systemRed
        
        return tableView
    }()

    //MARK:- OVERRIDEN METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
                
        setupUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    private func setupAssetsTableViewConstraints() {
        view.addSubview(assetsTableView)
        assetsTableView.pinToEdges(of: view)
    }
    
    private func setupUI() {
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        setupAssetsTableViewConstraints()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        
    }

}

extension WatchlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            assets?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension WatchlistViewController:UITableViewDelegate {
    
}
