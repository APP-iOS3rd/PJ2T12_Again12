//
//  KaKaoAuthVM.swift
//  PJ2T12_Again12
//
//  Created by 권운기 on 12/13/23.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KaKaoAuthVM: ObservableObject {
    
    @Published var isLoggedIn : Bool = false
    
    // 버튼에 사용하는 로그인 함수
    @MainActor
    func handleKakaoLogin(){
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                
                isLoggedIn = await handleLoginWithKakoTalkApp()
                
            } else {
                isLoggedIn = await handleWithKakaoAccount()
            }
        }
    }
    
    // 버튼에 사용하는 로그아웃 함수
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 카카오 앱이 있을경우 -> 어플로 로그인
    func handleLoginWithKakoTalkApp() async -> Bool{
        
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 카카오 앱이 없을경우 -> 웹뷰로 로그인
    func handleWithKakaoAccount() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
        
    }
}
