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
    
    func setup(_ name: String?, price: Double?, change: Double?, rank: Int?) {
        if let name = name {
            if let rank = rank {
                self.nameLabel.text = "\(rank). \(name)"
            }
        }
        if let price = price {
            self.priceLabel.text = "$" + price.formattedWithSeparator
        }
        if let change = change {
            self.changeLabel.text = String(format: "%.2f", change) + "%"
            if change < 0 {
                self.changeLabel.textColor = .systemRed
            } else {
                self.changeLabel.textColor = .systemGreen
            }
        }
    }
}
