//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let splashController = SplashController()
        let navigationController = UINavigationController(rootViewController: splashController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}

