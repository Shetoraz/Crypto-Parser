//
//  Networker.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class Networker {

    enum Requests: String {
        typealias RawValue = String
        case all = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false"
    }

    private static var networkService: Networker?

    func sentRequest(_ type: Requests, completion: @escaping (Result<Currency, Error>) -> Void) {
        guard let url = URL(string: type.rawValue) else { return }
        let session = URLSession.shared
        let decoder = JSONDecoder()
        session.dataTask(with: url) { data, _ , error in
            guard let data = data else { return }
            do {
                let response = try decoder.decode(Currency.self, from: data)
                completion(.success(response))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

