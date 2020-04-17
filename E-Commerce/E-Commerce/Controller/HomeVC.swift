//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import AlamofireImage

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = HomeViewModel()
    private let refreshStream = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStream()
        refreshStream.onNext(())
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        searchBar.delegate = self
        tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        //pull to refresh
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        refreshStream.onNext(())
    }
    
    func setupStream() {
        refreshStream
            .do(onNext : { _ in
                self.refreshControl.beginRefreshing()
            })
            .filter{
                return true
            }
            .flatMap { url in
                self.viewModel.getListProduct()
            }
            .do( onNext : { _ in
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }, onError : {
                errorType in
                print("Masuk Sini Dong \(errorType.localizedDescription)")
                self.viewModel.showToast(message: errorType.localizedDescription, vc: self)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

}

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)![0] as! HeaderView
        headerView.setHeader(section: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.getPromoCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0, indexPath.section == 0 {
            return 128
        }
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell
            cell?.bindData(categories: self.viewModel.categories)
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell
            
            cell?.bind(promoItem: self.viewModel.promoItems[indexPath.row])
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let cont = DetailVC.initiate(item: self.viewModel.promoItems[indexPath.row])
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    
}

extension HomeVC : UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        let searchController = SearchVC()
        
        searchController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(searchController, animated: true)
        
        return false
    }
}
