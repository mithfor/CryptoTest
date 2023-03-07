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
        
        let assetsVC = AssetsConfigurator.configured(AssetsViewController())
        assetsVC.title = TitlesConstants.assets
        assetsVC.tabBarItem = UITabBarItem(title: TitlesConstants.assets,
                                           image: UIImage(systemName: Constants.IconFill.assets),
                                           tag: 0)
        return UINavigationController(rootViewController: assetsVC)
    }
    
    private func createWatchlistNavigationController() -> UINavigationController {
        let watchlistVC = WatchlistViewController()
        watchlistVC.title = TitlesConstants.watchlist
        watchlistVC.tabBarItem = UITabBarItem(title: watchlistVC.title,
                                              image: UIImage(systemName: Constants.IconFill.watchlist),
                                              tag: 1)
        return UINavigationController(rootViewController: watchlistVC)
    }
    
    private func createSettingsNavigationController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.title = TitlesConstants.settings
        settingsVC.tabBarItem = UITabBarItem(title: settingsVC.title,
                                             image: UIImage(systemName: Constants.IconFill.settings),
                                             tag: 2)
        return UINavigationController(rootViewController: settingsVC)
    }
}

