//
//  DetailedViewController.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/9/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var volumeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupUI(curr: Response) {
        DispatchQueue.main.async {
            if let image = curr.image {
                if let url = URL(string: image) {
                    self.imageView.load(url)
                }
            }
            self.navigationController?.navigationBar.topItem?.title = curr.symbol?.uppercased()
            if let price = curr.currentPrice {
                self.priceLabel.text = "$ \(price.formattedWithSeparator)"
            }
            if let volume = curr.totalVolume {
                self.volumeLabel.text = "$ " + String(volume.formattedWithSeparator)
            }
            if let change = curr.priceChangePercentage24H {
                self.changeLabel.text = String(format: "%.2f", change) + "%"
                if change < 0 {
                    self.changeLabel.textColor = .systemRed
                } else {
                    self.changeLabel.textColor = .systemGreen
                }
            }
            if let marketCap = curr.marketCap {
                self.marketCapLabel.text = "$ \(marketCap.formattedWithSeparator)"
            }
            if let name = curr.name {
                self.nameLabel.text = "\(name)"
            }
            if let supply = curr.circulatingSupply {
                self.supplyLabel.text = "\(Int(supply).formattedWithSeparator) \(curr.symbol?.uppercased() ?? "")"
            }
        }
    }
}
