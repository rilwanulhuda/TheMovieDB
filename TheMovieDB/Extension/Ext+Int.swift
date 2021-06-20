//
//  Ext+Int.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 20/06/21.
//

import Foundation

extension Int {
    func toUSDollarFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? "n/a"
    }
}
