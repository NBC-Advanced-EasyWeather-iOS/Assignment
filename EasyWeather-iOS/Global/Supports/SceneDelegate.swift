//
//  SceneDelegate.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        
        let splashVC = SplashViewController()
        window.rootViewController = splashVC
        window.makeKeyAndVisible()
        
        self.window = window
        
        let rootVC = MainGPSViewController()
        
        // 스플래시 화면 2초 노출
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let navigationController = UINavigationController(rootViewController: rootVC)
            
            self.window?.rootViewController = navigationController
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
