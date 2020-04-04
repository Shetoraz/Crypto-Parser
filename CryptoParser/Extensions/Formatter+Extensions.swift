//
//  Formatter+Extensions.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/12/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
