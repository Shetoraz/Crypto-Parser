//
//  AllCurrencyCustomCell.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/23/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class AllCurrencyCustomCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

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

    func setup(_ name: String?, price: Double?) {
        if let nameLabel = self.nameLabel {
            nameLabel.text = name
        }
        if let priceLabel = self.priceLabel {
            priceLabel.text = price?.formattedWithSeparator
        }
    }
}
