//
//  Category.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Category : Object{
    @objc dynamic var imageUrl : String?
    @objc dynamic var name : String?
    @objc dynamic var id : Int = 0
    
    static func with(json: JSON) -> Category? {
        let cat = Category()
        
        if json["id"].exists() {
            cat.id = json["id"].intValue
        }
        if json["name"].exists() {
            cat.name = json["name"].string
        }
        if json["imageUrl"].exists() {
            cat.imageUrl = json["imageUrl"].string
        }
        return cat
    }
    
}

class PromoItem : Object{
    @objc dynamic var imageUrl : String?
    @objc dynamic var title : String?
    @objc dynamic var id : String?
    @objc dynamic var descriptions : String?
    @objc dynamic var price : String?
    @objc dynamic var loved : Int = 0
    
    static func with(json: JSON) -> PromoItem? {
        let promo = PromoItem()
        
        if json["id"].exists() {
            promo.id = json["id"].string
        }
        if json["title"].exists() {
            promo.title = json["title"].string
        }
        if json["imageUrl"].exists() {
            promo.imageUrl = json["imageUrl"].string
        }
        if json["description"].exists() {
            promo.descriptions = json["description"].string
        }
        if json["price"].exists() {
            promo.price = json["price"].string
        }
        if json["loved"].exists() {
            promo.loved = json["loved"].intValue
        }
        
        return promo
    }
}
