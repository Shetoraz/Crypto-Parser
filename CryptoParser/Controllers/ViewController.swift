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
        return self.model.currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyCustomTableViewCell
        let name = self.model.currencies[indexPath.row].name ?? ""
        let price = self.model.currencies[indexPath.row].currentPrice ?? 0.0
        cell.setup(name, price: price)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
