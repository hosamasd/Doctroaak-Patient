//
//  AppDelegate.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MOLH

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
               userDefaults.synchronize()
        MOLH.shared.activate(true)

        keyboardChanges()
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: LapSearchVC(index: 0))//PharmacyOrderVC(latt: 00.0, lon: 0.0, insurance: 0, delivery: 0))//PharmacyOrderVC(latt: 0.0, lon: 0.0, insurance: 0, delivery: 0))//DoctorBookVC(clinic_id: 16, patient_id: 50, api_token: "BrieOhmeR8CqML2RqBQDtXZWETE")//UINavigationController(rootViewController:ForgetPasswordVC())//VerificationVC(user_id: 47, isFromForget: false))//LAPOrderVC(index: 0))//PharmacyOrderVC())
        return true
    }

    func reset() {
           userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
           userDefaults.synchronize()
           window?.rootViewController = BaseSlidingVC()
       }
    
    fileprivate func keyboardChanges() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
               userDefaults.synchronize()
    }


}

