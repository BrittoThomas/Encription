//
//  AppDelegate.swift
//  Encription
//
//  Created by UVIONICS on 08/05/18.
//  Copyright © 2018 Citta.ai. All rights reserved.
//

import UIKit
import CryptoSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var encryptionKey = "Abcdefghijklmnop"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Encription
        //Dictionary > JSON Data > String ASCII > Data UTF8 > Encripted Data
        let json = ["key1":"value1","ket2":"value2"]
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let stringData = string.data(using: .utf8)!
        let encrypted = try! AES(key: AppDelegate.encryptionKey.bytes, blockMode: .ECB, padding: .pkcs7).encrypt([UInt8](stringData))
        let encryptedData = Data(encrypted)

        
        //Decription
        //Encripted Data > Decripted Data > String ASCII > JSON Data > Dictionary
        let decrypted = try! AES(key: AppDelegate.encryptionKey.bytes, blockMode: .ECB, padding: .pkcs7).decrypt([UInt8](encryptedData))
        let decryptedStringData = Data(decrypted)
        let decryptedString = String(bytes: decryptedStringData.bytes, encoding: .utf8) ?? "Could not decrypt"
        let decryptedData = decryptedString.data(using:String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let decryptedJson = try! JSONSerialization.jsonObject(with: decryptedData, options: JSONSerialization.ReadingOptions.allowFragments)
        print(decryptedJson)


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


}

