//
//  Int+Extensions.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/12/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
