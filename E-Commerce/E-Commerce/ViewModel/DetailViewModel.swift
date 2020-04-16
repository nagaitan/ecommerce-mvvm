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

class DetailViewModel {
    func purchaseItem(item : PromoItem) {
        do {
          let realm = try! Realm()
          // Persist your data easily
          try realm.write {
              realm.add(item)
          }
        } catch let error as NSError {
          // handle error
            print("Erros \(error.localizedDescription)")
        }
        
    }
    
    func shareItem(vc : DetailVC, item : PromoItem) {
        let shareText = "For Only \(item.price ?? "$0") "
        if let image = item.imageUrl {
            let pop = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
            pop.setValue(item.title ?? "", forKey: "Subject")
            vc.present(pop, animated: true)
        }
    }
}
