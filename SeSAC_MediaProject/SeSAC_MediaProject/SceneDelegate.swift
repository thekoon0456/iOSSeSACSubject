//
//  SceneDelegate.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        
        let vc = TVViewController()
//        let vc = DramaViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nav
    }

}

