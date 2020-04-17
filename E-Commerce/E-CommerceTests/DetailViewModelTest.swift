//
//  DetailViewModelTest.swift
//  E-CommerceTests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest
@testable import E_Commerce

class DetailViewModelTest: XCTestCase {

    var sut: DetailViewModel!
    var purchased : PurchaseViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailViewModel()
        purchased = PurchaseViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testItemSouldIncreasedAfterBuy(){
        purchased.getPurchasedItems()
        let countBefore = purchased.getCount()
        
        let newItem = PromoItem()
        newItem.descriptions = "Item Test"
        newItem.id = "123"
        newItem.imageUrl = "Test"
        newItem.price = "Test"
        newItem.loved = 0
        newItem.title = "test"
        
        sut.purchaseItem(item: newItem)
        purchased.getPurchasedItems()
        
        let countAfter = purchased.getCount()
        
        XCTAssertEqual(countAfter, countBefore + 1)
    }

}
