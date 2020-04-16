//
//  PurchasedVC.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class PurchasedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = PurchaseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getPurchasedItems()
        self.tableView.reloadData()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        
           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UINib(nibName: "SearchItemCell", bundle: nil), forCellReuseIdentifier: "SearchItemCell")
       }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension PurchasedVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as? SearchItemCell
            
            cell?.bind(promoItem: self.viewModel.items[indexPath.row])
            
            return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let cont = DetailVC.initiate(item: self.viewModel.items[indexPath.row])
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    
}
