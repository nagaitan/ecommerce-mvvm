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
    func LoginSuccess()
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
    // Facebook SignIn
    
    func loginWithFacebook(completion:@escaping (UserDetails) -> Void){

        SocialLoginClass.sharedManager().loginWithFacebook { (status,error) in
            if status{
                self.delegate.LoginSuccess()
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
    func LoginSuccess() {
        self.delegate.LoginSuccess()
    }
}

