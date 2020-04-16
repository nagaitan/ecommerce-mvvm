//
//  Category.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Category {
    var imageUrl : String?
    var name : String?
    var id : Int?
    
    static func with(json: JSON) -> Category? {
        var cat = Category()
        
        if json["id"].exists() {
            cat.id = json["id"].int
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

struct PromoItem {
    var imageUrl : String?
    var title : String?
    var id : String?
    var description : String?
    var price : String?
    var loved : Int?
    
    static func with(json: JSON) -> PromoItem? {
        var promo = PromoItem()
        
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
            promo.description = json["description"].string
        }
        if json["price"].exists() {
            promo.price = json["price"].string
        }
        if json["loved"].exists() {
            promo.loved = json["loved"].int
        }
        
        return promo
    }
}
