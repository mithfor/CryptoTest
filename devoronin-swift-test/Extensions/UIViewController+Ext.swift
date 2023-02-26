//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 07.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit
//import SafariServices

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
