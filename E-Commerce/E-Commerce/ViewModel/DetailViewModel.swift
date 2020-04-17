//
//  DetailViewModel.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol DetailViewDelegate {
    func doneBuy()
}

class DetailViewModel {
    var delegate : DetailViewDelegate?
    
    func purchaseItem(item : PromoItem) {
        let newItem = PromoItem()
        newItem.descriptions = item.descriptions
        newItem.id = item.id
        newItem.imageUrl = item.imageUrl
        newItem.price = item.price
        newItem.loved = item.loved
        newItem.title = item.title
        
        do {
          let realm = try! Realm()
          try realm.write {
              realm.add(newItem)
            delegate?.doneBuy()
          }
        } catch let error as NSError {
            print("Erros \(error.localizedDescription)")
        }
        
    }
    
    func likeItem(vc : DetailVC){
        let realm = try! Realm()
        if vc.item.loved == 0{
            try! realm.write {
                vc.item.loved = 1
            }
            vc.btnLoved.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            try! realm.write {
                vc.item.loved = 0
            }
            vc.btnLoved.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func shareItem(vc : DetailVC, item : PromoItem) {
        let items: [Any] = ["Grab Now! \(item.title ?? "") only \(item.price ?? "")", URL(string: item.imageUrl ?? "")!]
        let pop = UIActivityViewController(activityItems: items, applicationActivities: [])
        pop.setValue(item.title ?? "", forKey: "Subject")
        vc.present(pop, animated: true)
        
    }
}
