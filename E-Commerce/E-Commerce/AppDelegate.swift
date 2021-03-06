//
//  AppDelegate.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 15/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn

let GOOGLE_CLIENTID = "296171066110-ost7vo3635cn2gpv0aguvkg8ir60bjbu.apps.googleusercontent.com"
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyBoard = UIStoryboard()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
//    func setRootController(){
//        storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//        let initialViewController = self.storyBoard.instantiateViewController(withIdentifier: "loginController")
//        appDelegate.window?.rootViewController = initialViewController
//        appDelegate.window?.makeKeyAndVisible()
//    }


}

