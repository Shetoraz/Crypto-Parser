//
//  XAxisNameFormater.swift
//  CryptoParser
//
//  Created by Anton Asetski on 3/28/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()

    override init() {
        super.init()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM"
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value / 1000)
        let format = dateFormatter.string(from: date)
        return format
    }
}
