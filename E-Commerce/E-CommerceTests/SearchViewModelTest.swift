//
//  SearchViewModelTest.swift
//  E-CommerceTests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest
@testable import E_Commerce

class SearchViewModelTest: XCTestCase {

    var sut: SearchViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testItemSouldNotBeNullAfterLoad(){
        //before load count = 0
        XCTAssertEqual(0, sut.getCount())
        //load 6 items from json
        sut.loadItems()
        XCTAssertEqual(6, sut.getCount())
    }
    

}
