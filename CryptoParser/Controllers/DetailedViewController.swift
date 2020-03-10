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
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupUI(curr: Response) {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.topItem?.title = curr.symbol?.uppercased()
            if let price = curr.currentPrice {
                self.priceLabel.text = "$ \(price)"
            }
            if let change = curr.priceChangePercentage24H {
                self.changeLabel.text = String(change)
                if change < 0 {
                    self.changeLabel.textColor = .systemRed
                } else {
                    self.changeLabel.textColor = .systemGreen
                }
            }
            if let marketCap = curr.marketCap {
                self.marketCapLabel.text = "$ \(marketCap)"
            }
            if let position = curr.marketCapRank {
                self.positionLabel.text = String(position)
            }
            if let supply = curr.circulatingSupply {
                self.supplyLabel.text = "\(Int(supply)) \(curr.symbol?.uppercased() ?? "")"
            }
            if let image = curr.image {
                self.imageView.load(url: URL(string:image)!)
            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
