//
//  LoginViewModel.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 15/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

private var shared : LoginViewModel? = nil

protocol LoginDelegate {
    func googleLoginSuccess()
}

class LoginViewModel: NSObject {

    var objUser : UserDetails?
    var Email : String = ""
    let loginManager = LoginManager()
    var delegate : LoginDelegate!
    
    class func sharedLogin() -> LoginViewModel{
        if shared == nil{
            shared = LoginViewModel()
        }
        return shared!
    }
    
    func getLoginData(completion:@escaping (UserDetails) -> Void) {
        
        if (self.Email.isEmptyString()){
            ValidataionClass.sharedInstance().alertMessage(withTitle: APP_TITLE, alertMessage: emailBlank)
        }
        else{
            
        }
    }
    
    // Facebook SignIn
    
    func loginWithFacebook(completion:@escaping (UserDetails) -> Void){

        SocialLoginClass.sharedManager().loginWithFacebook { (status,error) in
            if status{
                self.getLoginData(completion: { (response) in
                    completion(response)
                })
            }else{
                ValidataionClass.sharedInstance().alertMessage(withTitle: APP_TITLE, alertMessage: error)
            }
        }
    }
    
    func loginWithGoogle(controller: LoginController){
        let socialLogin = SocialLoginClass.sharedManager()
        socialLogin.delegate = self
        socialLogin.loginWithGoogle(controller: controller)
    }
}

extension LoginViewModel : SocialLoginDelegate {
    func googleLoginSuccess() {
        self.delegate.googleLoginSuccess()
    }
}

