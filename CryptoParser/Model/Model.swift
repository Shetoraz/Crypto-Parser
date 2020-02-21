//
//  Model.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class Model {

    var currencies = Currency()
    let kernel: Kernel?

    init(_ kernel: Kernel) {
        self.kernel = kernel
        self.refresh()
    }

    private func refresh() {
        self.kernel?.network.sentRequest { (response) in
            switch response {
            case .success(let currencys):
                for item in currencys {
                    self.currencies.append(item)
                }
                NotificationCenter.default.post(name: Notification.Name("Reload"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func delete(at index: Int) {
        self.currencies.remove(at: index)
    }
}
