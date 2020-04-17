//
//  SocialLoginClass.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 15/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

private var shared:SocialLoginClass? = nil

protocol SocialLoginDelegate {
    func LoginSuccess()
}

class SocialLoginClass: NSObject {

    let loginManager = LoginManager()
    var delegate : SocialLoginDelegate!
    
    class func sharedManager() -> SocialLoginClass{
        if shared == nil{
            shared = SocialLoginClass()
        }
        return shared!
    }
}

extension SocialLoginClass{
    
    // Facebook SignIn
    
    func loginWithFacebook(completion:@escaping (Bool, String) -> Void){
        
        loginManager.logIn(permissions: ["email"], from: APPDELEGATE.window?.rootViewController) { (result, error) in
            if (error == nil)
            {
                let fbloginresult : LoginManagerLoginResult = result! //fbloginresult.isCancelled
                if(fbloginresult.grantedPermissions.contains("email")){
                    // start loader
                    self.getFBUserData(completion: { (status, error) in
                        completion(status,error)
                    })
                }
                else{
                    // Stop Loader
                    //completion(false,(error?.localizedDescription)!)
                }
            }
        }
    }
    
    // Get Facebook LoggedIn User data.
    
    func getFBUserData(completion:@escaping (Bool, String) -> Void){
        
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result!)
                    self.loginManager.logOut()
                    if let dataDic = result as? [String:Any]{
                        LoginViewModel.sharedLogin().Email = "\(dataDic["email"]!)"
                        completion(true,"")
                    }else{
                        completion(false,"Data parsing fail!")
                    }
                }else{
                    completion(false,(error?.localizedDescription)!)
                }
            })
        }
    }
    
    // Google SignIn
    
    func loginWithGoogle(controller : LoginController) {
        GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENTID
        GIDSignIn.sharedInstance()?.shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = controller
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension SocialLoginClass : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil{
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
            
            print("response : \(user.profile.email ?? "No Email")")
            
            let email = user.profile.email
            LoginViewModel.sharedLogin().Email = email!
            self.delegate.LoginSuccess()
//            LoginViewModel.sharedLogin().getLoginData { (response) in
//                print("response : \(response)")
//            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("disConnect googlePlus Login" + error.localizedDescription)
    }
    
    func signIn(_ signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        APPDELEGATE.window?.rootViewController!.present(viewController, animated: true, completion: nil)
    }
    
    func signIn(_ signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        APPDELEGATE.window?.rootViewController!.dismiss(animated: true, completion: nil)
    }
}
