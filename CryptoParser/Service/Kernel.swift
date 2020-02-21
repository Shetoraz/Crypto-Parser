//
//  Service.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class Kernel {
    
    public let network: Networker
    
    public static let kernel: Kernel = {
        let kernel = Kernel()
        return kernel
    }()
    
    private init() {
        self.network = Networker()
    }
}
