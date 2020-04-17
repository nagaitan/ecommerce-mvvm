//
//  LoginViewTests.swift
//  E-CommerceTests
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest
@testable import E_Commerce

class LoginViewTests: XCTestCase {

    var sut: LoginController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testChecCredentialsShouldReturnFalse(){
        let email = "adi"
        let pw = ""
        let result = sut.isValidCredentials(email: email, pw: pw)
        XCTAssertFalse(result, "Positive result for invalid Credentials")
    }
    
    func testChecCredentialsShouldReturnTrue(){
        let email = "adi@gmail.com"
        let pw = "password"
        let result = sut.isValidCredentials(email: email, pw: pw)
        XCTAssertTrue(result, "Positive result for valid Credentials")
    }

}
