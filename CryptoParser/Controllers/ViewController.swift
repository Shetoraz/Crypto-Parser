//
//  ViewController.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let model = Model(.kernel)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.addObserver()
    }

    private func setupTable() {
        self.tableView.register(UINib(nibName: "CurrencyCustomTableViewCell", bundle: .main), forCellReuseIdentifier: "currencyCell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear

    }

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "Reload"), object: nil)
    }

    @objc private func refresh(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyCustomTableViewCell
        let item = self.model.currencies[indexPath.section]
        let name = item.name ?? ""
        let price = item.currentPrice ?? 0.0
        let change = item.priceChange24H ?? 0.0
        cell.setup(name, price: price, change: change)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.currencies.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
}
