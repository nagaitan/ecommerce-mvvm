//
//  SearchViewModel.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchViewModel {
    var items : [PromoItem]!
    var tempItems : [PromoItem]!
    
    func loadPromoItem(){
        
    }
    
    func setupItemsData() {
        items = [PromoItem]()
        tempItems = [PromoItem]()
        if let path = Bundle.main.path(forResource: "items", ofType: "json"), let items = NSData(contentsOfFile: path) {
            do {
            let json = try JSON(data: items as Data)
                for itemJson in json.arrayValue {
                    if let item = PromoItem.with(json: itemJson) {
                        self.items.append(item)
                    }
                }
                tempItems.append(contentsOf: self.items)
            }catch{
                
            }
        }
    }
    
    func filterByName(searchText : String){
        if searchText.count == 0 {
            items = tempItems
        }else {
            items = tempItems.filter({ (data: PromoItem) -> Bool in
                if let title = data.title {
                    return (title.lowercased().contains(searchText.lowercased()))
                }
                return false
            })
        }
    }
    
    func loadItems(){
        setupItemsData()
    }
    
    func getCount() -> Int {
        return items == nil ? 0 : items.count
    }
    
}
