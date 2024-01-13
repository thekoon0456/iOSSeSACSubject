//
//  AppDelegate.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //키보드 설정
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        //네비게이션바 설정
        //버튼 색상
        UINavigationBar.appearance().tintColor = .label
        //네비바 불투명
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

