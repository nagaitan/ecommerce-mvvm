//
//  SearchVC.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchVM = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchVM.loadItems()
    }
    
    func setupView() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchItemCell", bundle: nil), forCellReuseIdentifier: "SearchItemCell")
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.reloadData()
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension SearchVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchVM.getCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as? SearchItemCell
            
            cell?.bind(promoItem: self.searchVM.items[indexPath.row])
            
            return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let cont = DetailVC.initiate(item: self.searchVM.items[indexPath.row])
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    
}

extension SearchVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Filter")
        self.searchVM.filterByName(searchText: searchText)
        self.tableView.reloadData()
    }
}
