//
//  MySceneDelegate.swift
//  PJ2T12_Again12
//
//  Created by 권운기 on 12/13/23.
//

import Foundation
import KakaoSDKAuth
import UIKit

class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
