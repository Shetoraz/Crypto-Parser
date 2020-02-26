//
//  AllCurrencyModel.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/23/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class AllCurrencyModel {

    var currencies = Currency()
    var selectedCurrencies = Currency()
    var filteredCurrencies = Currency()
    private let kernel: Kernel?

    init(_ kernel: Kernel) {
        self.kernel = kernel
        self.refresh()
    }

    func refresh() {
        self.kernel?.network.sentRequest(.all) { (response) in
            switch response {
            case .success(let currencys):
                for item in 0...currencys.count - 1 {
                    // TODO: - Fix array adding
                    if self.currencies.contains(currencys[item]) {
                        self.currencies[item] = currencys[item]
                    } else {
                        self.currencies.append(currencys[item])
                    }
                }
                NotificationCenter.default.post(name: Notification.Name("Refresh"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
