//
//  WatchListViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

protocol WatchListViewControllerInput: class {
    
}

protocol WatchListViewControllerOutput: class {
    func fetchFavoriteAssets(watchList: WatchList)
}

class WatchListViewController: UIViewController {
    var interactor: WatchListInteractorInput?
    
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
        
        fetchFavoriteAssets()
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
    
    private func fetchFavoriteAssets() {
        interactor?.fetchFavoriteAssets(watchList: watchlist)
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier, for: indexPath) as? AssetsTableViewCell {
//            cell.configureWith(delegate: nil, and: Asset(from: <#Decoder#>), image: UIImage(systemName: "house"))
//            return cell
//        } else {
            return UITableViewCell()
//        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            assets?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension WatchListViewController:UITableViewDelegate {
    
}
