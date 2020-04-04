//
//  DetailedModel.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/17/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation
import Charts

class DetailedModel {
    
    private let kernel: Kernel?
    private var chart = Chart(prices: [[0.0]], marketCaps: [[0.0]], totalVolumes: [[0.0]])
    var lineChartEntry = [ChartDataEntry]()
    
    init(_ kernel: Kernel) {
        self.kernel = kernel
    }
    
    private func convertToChartData() {
        guard let prices = self.chart.prices else { return }
        for interval in stride(from: 0, to: prices.count-1, by: 10) {
            let value = ChartDataEntry()
            for data in 0..<prices[interval].count {
                if data == 0 {
                    value.x = prices[interval][data]
                }
                if data == 1 {
                    value.y = prices[interval][data]
                }
            }
            self.lineChartEntry.append(value)
        }
        NotificationCenter.default.post(name: Notification.Name("drawChart"), object: nil)
    }
    
    func getChart(for currency: Response) {
        guard let id = currency.id else { return }
        self.kernel?.network.requestChart(for: id) { response in
            switch response {
            case .success(let chart):
                self.chart = chart
                self.convertToChartData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
