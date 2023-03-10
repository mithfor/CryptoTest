//
//  WatchListViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

//MARK: - WatchListViewControllerInput
protocol WatchListViewControllerInput: class {
    func updateFailed(with error: NetworkError)
    func updateAssets(_ assets: Assets)
}

//MARK: - WatchListViewControllerOutput
protocol WatchListViewControllerOutput: class {
    func fetchFavoriteAssets(watchList: WatchList)
    func fetchAssetDetails(by id: String, completion: @escaping (AssetResponse) -> ())
}

//MARK: - WatchListViewController
class WatchListViewController: UIViewController {
    var interactor: WatchListInteractorInput?
    
    //MARK: - VARIABLES
    var watchlist = WatchList()
    var assets = Assets()
    
    private lazy var assetsTableView: AssetsTableView = {
        let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self, forCellReuseIdentifier: AssetsTableViewCell.identifier)
                
        return tableView
    }()

    //MARK:- OVERRIDEN METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
                
        setupUI()
        
        fetchFavoriteAssets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchFavoriteAssets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    
    // MARK: - SETUP
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


// MARK: - UITableViewDataSource
extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlist.assetsIds.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !assets.isEmpty else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier, for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: nil, and: assets[indexPath.row], image: UIImage(systemName: "house"))
            return cell
        } else {
            return UITableViewCell()
        }
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            watchlist.remove(assets.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension WatchListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
}


//MARK: - WatchListViewControllerInput
extension WatchListViewController: WatchListViewControllerInput {
    func updateAssets(_ assets: Assets) {
        self.assets = assets
        assetsTableView.reloadData()
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
    }
}
