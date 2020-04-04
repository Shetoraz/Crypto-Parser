//
//  ImageView+Network.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/12/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(_ url: URL) {
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
