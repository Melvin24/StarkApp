//
//  AppDelegate.swift
//  Stark
//
//  Created by Melvin John on 14/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mainWindow = UIWindow(frame: UIScreen.main.bounds)

        let mainFactory = MainViewControllerFactory()

        guard let mainViewController = try? mainFactory.make() else {
            return false
        }

        let navigationController = UINavigationController()
        navigationController.setViewControllers([mainViewController], animated: false)

        navigationController.navigationBar.prefersLargeTitles = true

        window = mainWindow
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true

    }



}

