//
//  MockAppDelegate.swift
//  CodeChallangeTests
//
//  Created by Andrei Stefanescu on 30.06.2022.
//

import UIKit
import CoreData

@objc(MockAppDelegate)
class MockAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Launchig with the mock AppDelegate")
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
         sceneConfiguration.delegateClass = MockSceneDelegate.self
         sceneConfiguration.storyboard = nil

         return sceneConfiguration
     }
}

class MockSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene is UIWindowScene) else { return }
    }
}
