//
//  SocialView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct SocialView: View {
    @StateObject private var socialVM = SocialViewModel()
    
    var body: some View {
        if socialVM.isLogin {
            SocialViewIfLogin(socialVM: socialVM)
        } else {
            SocialViewIfNotLogin(socialVM: socialVM)
        }
    }
}

struct SocialViewIfNotLogin: View {
    @ObservedObject var socialVM: SocialViewModel
    @State private var alertIsPresented: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Text("친구")
                            .font(.system(size: 25, weight: .heavy))
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text("로그인 해서\n친구들의 투두리를 살펴보세요")
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                    
                    Button {
                        alertIsPresented = true
                    } label: {
                        Text("카카오 로그인하기")
                            .foregroundStyle(.white)
                            .font(.system(.body, weight: .bold))
                            .frame(width: 173, height: 52)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } //Button
                    .alert(isPresented: $alertIsPresented) {
                        let leftButton = Alert.Button.default(Text("로그인")) {
                            socialVM.isLogin = true
                        }
                        
                        let rightButton = Alert.Button.default(Text("취소")) {
                            socialVM.isLogin = false
                        }
                        
                        return Alert(title: Text("로그인 하시겠습니까?"), 
                                     primaryButton: rightButton,
                                     secondaryButton: leftButton)
                    } //alert
                    
                    Spacer()
                } //VStack
                .frame(width: geo.size.width, height: geo.size.height)
                .background(.yellow)
            }
        } //VStack
    }
}

struct SocialViewIfLogin: View {
    @ObservedObject var socialVM: SocialViewModel
    
    var body: some View {
        Text("로그인되었습니다")
    }
}

#Preview {
    SocialView()
}
