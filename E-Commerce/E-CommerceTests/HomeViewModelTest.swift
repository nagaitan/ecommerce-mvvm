//
//  HomeViewModelTest.swift
//  E-CommerceTests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest
@testable import E_Commerce

class HomeViewModelTest: XCTestCase {

    var sut: HomeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPromoItemSouldNotBeNull(){
        XCTAssertEqual(0, sut.getPromoCount())
        //add 1 item
        sut.promoItems.append(PromoItem())
        XCTAssertEqual(1, sut.getPromoCount())
    }
    
    func testCategoryItemSouldNotBeNull(){
        XCTAssertEqual(0, sut.getCategoriesCount())
        //add 1 item
        sut.categories.append(Category())
        XCTAssertEqual(1, sut.getCategoriesCount())
    }

}
