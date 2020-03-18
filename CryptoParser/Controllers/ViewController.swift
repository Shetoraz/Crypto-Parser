//
//  ViewController.swift
//  CryptoParser
//
//  Created by Anton Asetski on 2/19/20.
//  Copyright © 2020 Anton Asetski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let model = Model(.kernel)
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.setupAddButton()
    }
    
    private func setupTable() {
        self.tableView.register(UINib(nibName: "CurrencyCustomTableViewCell", bundle: .main), forCellReuseIdentifier: "currencyCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.refreshControl = refreshControl
        self.refreshControl.attributedTitle = NSAttributedString(string: "Updating...")
        self.refreshControl.addTarget(self, action: #selector(refreshPrice), for: .valueChanged)
    }
    
    private func setupAddButton() {
        self.addButton.layer.shadowOffset = CGSize(width: 3, height: 5)
        self.addButton.layer.shadowRadius = 3
        self.addButton.layer.shadowColor = UIColor.lightGray.cgColor
        self.addButton.layer.shadowOpacity = 0.5
    }
    
    @objc private func refreshPrice(_ sender: Any) {
        self.model.refresh()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
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
        let rank = item.marketCapRank
        let name = item.symbol?.uppercased()
        let price = item.currentPrice
        let change = item.priceChange24H
        cell.setup(name, price: price, change: change, rank: rank)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.currencies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailed", sender: self)
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: "Delete") { (_ ,_) in
                                                    self.model.delete(at: indexPath.section)
                                                    self.tableView.deleteSections([indexPath.section], with: .left)
        }
        return [deleteAction]
    }
}

extension ViewController {
    
    @IBAction func backToFavorite(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is AllCurrencyViewController {
            if let vc = unwindSegue.source as? AllCurrencyViewController {
                self.model.addToFavourite(from: vc.model.selectedCurrencies)
            }
        }
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailed" {
            let vc = segue.destination as! DetailedViewController
            vc.setupUI(curr: self.model.currencies[self.tableView?.indexPathForSelectedRow?.section ?? 0])
        }
    }
}
