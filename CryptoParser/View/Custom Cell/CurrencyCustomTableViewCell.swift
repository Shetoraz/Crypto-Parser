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
    @IBOutlet weak var changeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.3
        layer.frame = frame
    }

    func setup(_ name: String, price: Double, change: Double) {
        self.nameLabel.text = name
        self.priceLabel.text = String(format: "%.3f", price)
        self.changeLabel.text = String(format: "%.3f", change)
        if change > 0 {
            self.changeLabel.textColor = .systemGreen
        } else {
            self.changeLabel.textColor = .systemRed
        }
    }
}
