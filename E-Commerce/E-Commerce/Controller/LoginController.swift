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
        setupView()
    }
    
    func setupView(){
        objLoginModel.delegate = self
        btnSignIn.cardify()
        btnGoogle.cardify()
        btnFB.cardify()
        txtUsername.delegate = self
        txtUsername.returnKeyType = .done
        txtPassword.addTarget(self, action: #selector(self.checkFields(_:)), for: .editingChanged)
        txtUsername.addTarget(self, action: #selector(self.checkFields(_:)), for: .editingChanged)
        
    }

    @IBAction func loginWithFB(_ sender: Any) {
        objLoginModel.loginWithFacebook { (response) in
        }
    }
    
    @objc func checkFields(_ textField: UITextField) {
        print(isValidCredentials(email: self.txtUsername.text!, pw: self.txtPassword.text!))
        if isValidCredentials(email: self.txtUsername.text!, pw: self.txtPassword.text!){
            btnSignIn.isEnabled = true
            btnSignIn.backgroundColor = UIColor.darkGray
        }else{
            btnSignIn.isEnabled = false
            btnSignIn.backgroundColor = UIColor.lightGray
        }
    }
    
    func isValidCredentials(email : String, pw : String) -> Bool {
        return self.objLoginModel.isValidCredentials(txtEMail: email, txtPw: pw)
    }
    
    @IBAction func loginWIthGoogle(_ sender: UIButton) {
        objLoginModel.loginWithGoogle(controller: self)
    }
    
    func goToHome(){
        let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: false, completion: nil)
    }
}

extension LoginController : LoginDelegate {
    func LoginSuccess() {
        goToHome()
    }
}

extension LoginController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
