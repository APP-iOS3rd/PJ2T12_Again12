//
//  MyAppDelegate.swift
//  PJ2T12_Again12
//
//  Created by 권운기 on 12/13/23.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

// 카카오에서 기본 제공하는 코드. 크게 이해할 필요 없을듯
class MyAppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let kakaoAppkey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        print("kakaoAppKey : \(kakaoAppkey)")
        KakaoSDK.initSDK(appKey: kakaoAppkey as! String)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = MySceneDelegate.self 
        return sceneConfiguration
    }
    
}
