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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    
    //MARK: - Overriden
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assetsTableView.frame = view.bounds
    }
    
    
    // MARK: - Private methods
    private func configure() {
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        customAppearance()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(assetsTableView)
    }
    
    fileprivate func customAppearance() {
        view.backgroundColor = .orange
        
        let navigationTitleFont = UIFont(name: "Helvetica", size: 34)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont as Any]
    }
}

// MARK: - UITableViewDataSource

extension AssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.pagination
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = assetsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "House #\(indexPath.row + 1)"
        cell.imageView?.image = UIImage(systemName:"house")
        cell.imageView?.tintColor = .red
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return Constants.tableCellHeight

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("Header \(section)")
    }
}

//MARK: - Constants
struct Constants {
    static let pagination: Int = 10
    static let tableCellHeight: CGFloat = 80.4
}
