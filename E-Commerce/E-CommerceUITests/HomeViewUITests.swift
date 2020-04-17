//
//  HomeViewUITests.swift
//  E-CommerceUITests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest

class HomeViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testCompleteTransaction() {
        //this is test for complete transaction Login -> Buy Item
        //LOGIN
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("adi@gmail.com")
        let isEnabledAfterFillingEmail = app.buttons["Sign In"].isEnabled
        XCTAssertFalse(isEnabledAfterFillingEmail)
        
        app.textFields["E-mail"].typeText("\n")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("p")
        
        let isEnabledAfterFillingPassword = app.buttons["Sign In"].isEnabled
        XCTAssertTrue(isEnabledAfterFillingPassword)
        
        app.buttons["Sign In"].tap()
        //HOME, waiting load items, tap item
        let inProgressActivityIndicator = app.activityIndicators["In progress"]
        
        while inProgressActivityIndicator.exists {
            sleep(1)
        }
        sleep(1);
        //DETAIL, show detail, hit back
        let itemCell = app.tables.cells.element(boundBy: 2)
        XCTAssertTrue(itemCell.exists)
        itemCell.tap()
        
        sleep(1);
        
        app.buttons["arrow.left"].tap()
        
        sleep(1);
        //HIT SEARCH BAR,
        app.searchFields["search here"].tap()
        
        sleep(1);
        //SEARCH AN ITEM
        app.searchFields["search item"].tap()
        app.searchFields["search item"].typeText("a")
        
        sleep(1);
        //TAP AN ITEM
        let itemSearchCell = app.tables.cells.element(boundBy: 1)
        XCTAssertTrue(itemSearchCell.exists)
        itemSearchCell.tap()
        
        sleep(1);
         //DETAIL ITEM, BUY!
        app.buttons["     Buy    "].tap()
        
        sleep(1);
        //SEE ITEM ALREADY PURCHASED
        app.buttons["Profile"].tap()
        
        sleep(2);
        
    }

}
