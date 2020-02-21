//
//  TableViewCell.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class CurrencyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ name: String, price: Double) {
        self.nameLabel.text = name
        self.priceLabel.text = String(price)
    }
}
