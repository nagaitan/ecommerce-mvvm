//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

import Foundation

class HomeViewModel : BaseVM {
    let api: APIConnector
    let disposeBag = DisposeBag()
    
    var categories = [Category]()
    var promoItems = [PromoItem]()
    
    convenience override init() {
        self.init(apiConnector: APIConnector.instance)
    }
    
    init(apiConnector: APIConnector) {
        self.api = apiConnector
    }
    
    func getListProduct() -> Observable<Void> {
        return api.getListProduct()
            .do ( onNext :  {
                _items in
                print("Load Data")
                self.categories = _items.0
                self.promoItems = _items.1
            }).map { _ in return Void() }
    }
    
    
}
