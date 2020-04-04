//
//  DetailedViewController.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/9/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit
import Charts

class DetailedViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var selectedPrice: UILabel!
    @IBOutlet weak var chart: LineChartView!

    let model = DetailedModel(.kernel)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChart()
        self.addObserver()
    }

    private func setupChart() {
        self.chart.delegate = self
        self.supplyLabel.adjustsFontSizeToFitWidth = true
        self.chart.noDataText = "Loading..."
        self.chart.noDataTextColor = .black
        self.chart.borderLineWidth.native = 5
        self.chart.leftAxis.labelTextColor = .black
        self.chart.xAxis.labelCount = 5
        self.chart.xAxis.labelPosition = .bottom
        self.chart.xAxis.granularity = 1
        self.chart.xAxis.valueFormatter = DateValueFormatter()
        self.chart.scaleYEnabled = false
        self.chart.xAxis.drawGridLinesEnabled = false
        self.chart.drawGridBackgroundEnabled = false
        self.chart.rightAxis.enabled = false
        self.chart.legend.enabled = false
        self.chart.leftAxis.drawAxisLineEnabled = false
    }

    private func drawChart() {
        let dataSet = LineChartDataSet(entries: self.model.lineChartEntry, label: nil)
        let data = LineChartData()
        dataSet.colors = [NSUIColor.black]
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.lineWidth = 4
        dataSet.mode = .cubicBezier
        let gradientFill = [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientFill, locations: colorLocations) else { print ("gradient error"); return }
        dataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        data.addDataSet(dataSet)
        self.chart.data = data
        self.chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInOutCubic)
        dataSet.notifyDataSetChanged()
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "drawChart"), object: nil)
    }

    @objc private func refresh(notification: Notification) {
        DispatchQueue.main.async {
            self.drawChart()
        }
    }

    func setupUI(curr: Response) {
        DispatchQueue.main.async {
            self.model.getChart(for: curr)
            if let image = curr.image {
                if let url = URL(string: image) {
                    self.imageView.load(url)
                }
            }
            self.navigationController?.navigationBar.topItem?.title = curr.symbol?.uppercased()
            if let price = curr.currentPrice {
                self.priceLabel.text = "$ " + price.formattedWithSeparator
            }
            if let volume = curr.totalVolume {
                self.volumeLabel.text = "$ " + volume.formattedWithSeparator
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
                self.marketCapLabel.text = "$ " + marketCap.formattedWithSeparator
            }
            if let name = curr.name {
                self.nameLabel.text = name
            }
            if let supply = curr.circulatingSupply {
                self.supplyLabel.text = "\(Int(supply).formattedWithSeparator) \(curr.symbol?.uppercased() ?? "")"
            }
        }
    }
}

extension DetailedViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        DispatchQueue.main.async {
            self.selectedPrice.text = "$ " + entry.y.formattedWithSeparator
        }
    }

}
