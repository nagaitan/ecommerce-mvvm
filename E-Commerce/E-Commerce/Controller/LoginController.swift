//
//  ViewController.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 15/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var objLoginModel = LoginViewModel()
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblLogin: UILabel!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objLoginModel.delegate = self
    }

    @IBAction func loginWithFB(_ sender: Any) {
        objLoginModel.loginWithFacebook { (response) in
            print("Response :\(response)")
        }
    }
    
    @IBAction func loginWIthGoogle(_ sender: UIButton) {
        objLoginModel.loginWithGoogle(controller: self)
    }
}

extension LoginController : LoginDelegate {
    func googleLoginSuccess() {
        
    }
}

