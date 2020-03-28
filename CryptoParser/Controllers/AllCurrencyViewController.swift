//
//  AllCurrencyViewController.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/23/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class AllCurrencyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let model = AllCurrencyModel(.kernel)
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.setupSearchController()
        self.addObserver()
    }

    private func setupTable() {
        self.tableView.register(UINib(nibName: "AllCurrencyCustomCell", bundle: .main), forCellReuseIdentifier: "allCurrency")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "Refresh"), object: nil)
    }

    @objc private func refresh(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AllCurrencyViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCurrency") as! AllCurrencyCustomCell
        let item: Response
        if resultSearchController.isActive {
            item = self.model.filteredCurrencies[indexPath.section]
        } else {
            item = self.model.currencies[indexPath.section]
        }
        let name = item.symbol?.uppercased()
        let price = item.currentPrice
        cell.accessoryType = self.model.selectedCurrencies.contains(item) ? .checkmark : .none
        cell.setup(name, price: price)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if resultSearchController.isActive {
            return self.model.filteredCurrencies.count
        } else {
            return self.model.currencies.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item: Response
            if resultSearchController.isActive {
                item = self.model.filteredCurrencies[indexPath.section]
            } else {
                item = self.model.currencies[indexPath.section]
            }
            if cell.accessoryType == .checkmark {
                self.model.selectedCurrencies.removeAll{$0 == item}
                cell.accessoryType = .none
            } else {
                self.model.selectedCurrencies.append(item)
                cell.accessoryType = .checkmark
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
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

extension AllCurrencyViewController: UISearchResultsUpdating {

    private func setupSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar

            return controller
        })()
    }

    internal func updateSearchResults(for searchController: UISearchController) {
        self.model.filteredCurrencies.removeAll()
        if let searchTerm = searchController.searchBar.text?.lowercased() {
            let array = self.model.currencies.filter { result in
                let name = result.name?.lowercased() ?? ""
                let symbol = result.symbol?.lowercased() ?? ""
                return name.contains(searchTerm) || symbol.contains(searchTerm)
            }
            self.model.filteredCurrencies = array
            self.tableView.reloadData()
        }
    }
}
