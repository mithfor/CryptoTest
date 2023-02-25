//
//  ViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 17.02.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
    }
    
    fileprivate func configure() {
        
        createTabBar()
    }
    
    private func createTabBar() {
        
        viewControllers = [
            createAssetsNavigationConroller(),
            createWatchlistNavigationController(),
            createSettingsNavigationController()
        ]
    }
    
    private func createAssetsNavigationConroller() -> UINavigationController {
        
        let assetsVC = AssetsViewController()
        assetsVC.title = "Assets"
        assetsVC.tabBarItem = UITabBarItem(title: assetsVC.title,
                                           image: UIImage(systemName: "bitcoinsign.circle.fill"),
                                           tag: 0)
        assetsVC.view.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return UINavigationController(rootViewController: assetsVC)
    }
    
    private func createWatchlistNavigationController() -> UINavigationController {
        let watchlistVC = WatchlistViewController()
        watchlistVC.title = "Watchlist"
        watchlistVC.tabBarItem = UITabBarItem(title: watchlistVC.title,
                                              image: UIImage(systemName: "heart.fill"),
                                              tag: 1)
        return UINavigationController(rootViewController: watchlistVC)
    }
    
    private func createSettingsNavigationController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: settingsVC.title,
                                             image: UIImage(systemName: "gearshape.fill"),
                                             tag: 2)
        return UINavigationController(rootViewController: settingsVC)
    }
}

