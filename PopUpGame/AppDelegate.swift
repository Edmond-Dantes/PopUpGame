//
//  AppDelegate.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
        
        //GADMobileAds
        
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

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        print("Accessed from another application:")
        print(url.scheme)
        print(url.path!)
        print(url.query!)
        
        print(sourceApplication!)
        
        if sourceApplication! == "com.apple.mobilesafari"{
            
            var queryDictionary:[String:String] = [:]
            
            let queryElements = url.query!.componentsSeparatedByString("&")
            for element in queryElements{
                let tempArray = element.componentsSeparatedByString("=")
                queryDictionary[tempArray[0]] = tempArray[1]
            }
            
            let state = queryDictionary["state"]!
            let code = queryDictionary["code"]!
            
            print("state = \(state)")
            print("code = \(code)")
            
            let body = "grant_type=authorization_code&code=\(code)&redirect_uri=\(myUrl)"
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "\(tokenUrl)\(body)")!)
            print("\(request.allHTTPHeaderFields)")
            
            request.allHTTPHeaderFields = ["Authorization":"Basic \(encodedString)"]
            
            if let accessTokenDict = serverRequestObject.httpPost(request){
                
                //let userId = accessTokenDict["user_id"]
                accessToken = accessTokenDict["access_token"] as? String
                
            }
            
            
            
            
        }
        
        return true
    }

}

