//
//  AssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit
//import SwiftUI

class AssetsViewController: UIViewController {
    
    let assetsTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(AssetsTableViewCell.self,
                           forCellReuseIdentifier: AssetsTableViewCell.identifier)
        tableView.register(AssetsTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: AssetsTableViewHeader.identifier)
        tableView.backgroundColor = ColorConstants.mainBackground
        
        return tableView
    }()
    
    private var assets: [Asset]?

    
    //MARK: - Overriden
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchAssets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customAppearance()
    }
    // MARK: - Private methods
    private func setupUI() {
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        customAppearance()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(assetsTableView)
    }
    
    fileprivate func customAppearance() {
        
        let navigationTitleFont = UIFont(name: "Helvetica", size: 34)
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = ColorConstants.mainBackground
        
        if #available(iOS 13, *) {
            appearance.shadowColor = .clear
        } else {
            navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "BarBackground"), for: .default)
            appearance.shadowImage = UIImage()
        }
        
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont as Any]
    }
}

// MARK: - UITableViewDataSource
extension AssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.pagination
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let assets = self.assets else {
            return UITableViewCell()
        }
        
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier,
                                                          for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: self,
                               and: assets[indexPath.row],
                               image: UIImage(systemName: "house"))
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension AssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: AssetsTableViewHeader.identifier)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableHeaderHeight
    }
    
}
//MARK: - AssetsTableViewCellDelegate
extension AssetsViewController: AssetsTableViewCellDelegate {
    func assetDetails(with data: String) {
        presentAlertOnMainThread(title: "Details",
                                 message: "Asset #\(data)",
                                 buttonTitle: "Ok")
    }
}

extension AssetsViewController {
    private func fetchAssets() {
        NetworkManager.shared.fetchAssets(page: 1) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responce):
                    self?.assets = responce.data
                    self?.assetsTableView.reloadData()
                case .failure(_):
                    self?.presentAlertOnMainThread(title: "ERROR", message: "Loading Data", buttonTitle: "OK")
                }
            }

        }
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetsViewController().showPreview()
//    }
//}

