//
//  PurchaseViewModel.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import RealmSwift

class PurchaseViewModel {
    var items : [PromoItem]!
    
    func getPurchasedItems()  {
        let realm = try! Realm()
        let itemsSaved = realm.objects(PromoItem.self)
        self.items = [PromoItem]()
        self.items.append(contentsOf: itemsSaved)
        print("Count \(items.count)")
        
    }
    
    func getCount() -> Int{
        return items == nil ? 0 : items.count
    }
}
