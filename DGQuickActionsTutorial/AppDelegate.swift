//
//  AppDelegate.swift
//  DGQuickActionsTutorial
//
//  Created by Danil Gontovnik on 9/27/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

enum DGShortcutItemType: String {
    case Search
    case Favorites
    case Dynamic
    
    init?(shortcutItem: UIApplicationShortcutItem) {
        guard let last = shortcutItem.type.componentsSeparatedByString(".").last else { return nil }
        self.init(rawValue: last)
    }
    
    var type: String {
        return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            handleShortcutItem(shortcutItem)
        }
        
        return true
    }
    
    private func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) {
        if let rootViewController = window?.rootViewController, let shortcutItemType = DGShortcutItemType(shortcutItem: shortcutItem) {
            rootViewController.dismissViewControllerAnimated(false, completion: nil)
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            switch shortcutItemType {
            case .Search:
                alertController.message = "It's time to search"
                break
            case .Favorites:
                alertController.message = "Show me my favorites"
                break
            case .Dynamic:
                alertController.message = "Dynamic shortcut works!"
                break
            }
            
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            rootViewController.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        handleShortcutItem(shortcutItem)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

