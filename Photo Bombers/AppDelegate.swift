//
//  AppDelegate.swift
//  Photo Bombers
//
//  Created by Tim Walsh on 3/17/15.
//  Copyright (c) 2015 ClassicTim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let instagramAuthDictionary: [String:String] = ["client_id" : "e9c21e63a7374d009d391c0ac7b2d2c2", SimpleAuthRedirectURIKey : "photobombers://auth/instagram"]
        
        
        SimpleAuth.configuration()["instagram"] = instagramAuthDictionary
        
//        SimpleAuth.configuration[@"instagram"] = @{
//            @"client_id" : @"CLIENT_ID",
//            SimpleAuthRedirectURIKey : @"https://mysite.com/auth/instagram/callback"
//        };
       // [SimpleAuth authorize:@"instagram" completion:^(id responseObject, NSError *error) {}];
        
        var photosViewController = PhotosViewController()
        
        //create the root navigation controller and pass it the photosViewController as the initial screen
        var navigationController = UINavigationController(rootViewController: photosViewController)
        
        //create and customize the navigation bar which is part of the navigationController
        var navigationBar = navigationController.navigationBar
        navigationBar.barTintColor = UIColor(red: 242/255.0, green: 122/255.0, blue: 87/255.0, alpha: 1.0)
        navigationBar.barStyle = UIBarStyle.Black
        navigationBar.translucent = true //this defaults to true, but still a good idea to implement.  "false" appears to create a background that matches the barTintColor
        
        //set the rootViewController to our custom built navigationController
        self.window?.rootViewController = navigationController
        return true
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

