//
//  AssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit
//import SwiftUI

typealias AssetsWithImages = [Asset: UIImage]
typealias AssetImage = UIImage

protocol AssetsViewControllerInput: AnyObject {
    func updateAssets(assets: Assets)
}

protocol AssetsViewControllerOutput: AnyObject {
    func fetchAssets()
    func fetchImageFor(asset: Asset, completion: @escaping (AssetIcon) -> ())
}

class AssetsViewController: UIViewController {
    
    var interactor: AssetsInteractorInput?
    
    let assetsTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(AssetsTableViewCell.self,
                           forCellReuseIdentifier: AssetsTableViewCell.identifier)
        tableView.register(AssetsTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: AssetsTableViewHeader.identifier)
        tableView.backgroundColor = ColorConstants.mainBackground
        
        return tableView
    }()
    
    private var assets: Assets?
    private var assetWithImage = [Asset: UIImage]()
    
    
    //MARK: - Overriden
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        interactor?.fetchAssets()
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
        return assets?.count ?? Constants.pagination
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let assets = self.assets else {
            return UITableViewCell()
        }
        
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier,
                                                          for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: self,
                               and: assets[indexPath.row],
                               image: assetWithImage[assets[indexPath.row]])
            
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

extension AssetsViewController: AssetsPresenterOutput {
    
    func updateAssets(assets: Assets) {
        self.assets = assets
        
        let group = DispatchGroup()
        
        self.assets?.forEach { [weak self] asset in
            group.enter()
            self?.interactor?.fetchImageFor(asset: asset) {  [weak self] (assetIcon) in
                self?.assetWithImage[asset] = assetIcon.image
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.assetsTableView.reloadData()
        }
        
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetsViewController().showPreview()
//    }
//}

