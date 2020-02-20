//
//  Networker.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation

class Networker {

    private static var networkService: Networker?

    func sentRequest(completion: @escaping (Result<Currency, Error>) -> Void) {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=3&page=1&sparkline=false")!
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

