//
//  AppDelegate.swift
//  Global_Garner
//
//  Created by indianic on 21/06/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import MBProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var HUD:MBProgressHUD?
    var navigationController:UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
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
    }

    
    func appDelegate () -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    func showActivityIndicator() -> Bool {
        //DispatchQueue.main.async {
        if Utility().isNetworkAvailable() == true {
//            MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window!)! , animated: true)
            self.showLoadingHUD()
            return true
        }else
        {
            UIAlertController.showAlertWithOkButton((self.window?.rootViewController!)!, aStrMessage: "Internet Not Avilable", completion: nil)
            return false
        }
        
        // }
    }
    
    func hideActivityIndicator() {
        // DispatchQueue.main.async {
        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        // }
    }
    
    func showLoadingHUD() {
        
        HUD?.hide(animated: true)
        HUD = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window!)!, animated: true)
        HUD?.bezelView.color = UIColor.clear // Your backgroundcolor
        HUD?.bezelView.style = .solidColor
        
        let imageViewAnimatedGif = UIImageView()
        imageViewAnimatedGif.loadGif(name: "LoadingNew@2x")
        
        let jeremyGif = UIImage.gif(name: "LoadingNew@2x")
        
        self.HUD?.customView = UIImageView(image: jeremyGif)
        
        
        
        HUD?.customView?.frame = CGRect(x: CGFloat((HUD?.customView?.frame.origin.x)!), y: CGFloat((HUD?.customView?.frame.origin.y)!), width: CGFloat((HUD?.customView?.frame.size.width)! + 100), height: CGFloat((HUD?.customView?.frame.size.height)! + 100))
        HUD?.mode = .customView
        self.navigationController?.view.addSubview(self.HUD!)
        self.HUD?.show(animated: true)
    }
    


}

