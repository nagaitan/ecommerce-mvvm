//
//  LoginViewUITests.swift
//  E-CommerceUITests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest

class LoginViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSignInButtonDisabledAfterLaunch() throws {
        let isEnabled = app.buttons["Sign In"].isEnabled
        XCTAssertFalse(isEnabled)
    }
    
    func testSubmitButtonEnablesAfterFillingTextFields() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("adi@gmail.com")
        let isEnabledAfterFillingEmail = app.buttons["Sign In"].isEnabled
        XCTAssertFalse(isEnabledAfterFillingEmail)
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("p")
        
        let isEnabledAfterFillingPassword = app.buttons["Sign In"].isEnabled
        XCTAssertTrue(isEnabledAfterFillingPassword)
    }

}
