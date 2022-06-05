//
//  SceneDelegate.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appBoundary = AppBoundary.Resolved()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appBoundary.rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

