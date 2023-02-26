//
//  AssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

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

    
    //MARK: - Overriden
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier,
                                                          for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: self, and: indexPath.row, image: UIImage(systemName: "house"))
            
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
    func assetDetails(with data: Int) {
        presentAlertOnMainThread(title: "Details",
                                 message: "Asset #\(data)",
                                 buttonTitle: "Ok")
    }
    
    
}

