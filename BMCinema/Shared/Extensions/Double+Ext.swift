//
//  Double+Ext.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation

extension Double {
    func formattedString(decimalPoints: Int) -> String {
        let format = "%.\(decimalPoints)f"
        return String(format: format, self)
    }
}
