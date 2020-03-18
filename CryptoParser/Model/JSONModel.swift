//
//  JSONModel.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

// MARK: - WeatherElement
struct Response: Codable, Equatable {

    static func == (lhs: Response, rhs: Response) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }

    let athDate, image, id, symbol, name, lastUpdated: String?
    let currentPrice, totalVolume, high24H, low24H, priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H, circulatingSupply, ath, athChangePercentage: Double?
    let marketCap, marketCapRank, totalSupply: Int?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case totalVolume = "total_volume"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case lastUpdated = "last_updated"
    }
}

typealias Currency = [Response]

// MARK: - Chart

struct Chart: Codable {
    let prices, marketCaps, totalVolumes: [[Double]]?

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
