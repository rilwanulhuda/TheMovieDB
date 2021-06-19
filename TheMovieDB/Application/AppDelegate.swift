//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 16/06/21.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let rootVC = MainViewController()
        window?.rootViewController = rootVC
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //
    }
}
