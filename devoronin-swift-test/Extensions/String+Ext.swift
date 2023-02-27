//
//  String+Ext.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

extension String {
    func decimalPlaces(equalsTo: Int) -> String {
        guard let str = Double(self) else {
            return self
        }
        return "\(NSString(format: "%.\(equalsTo)f" as NSString, str))"
    }
}
