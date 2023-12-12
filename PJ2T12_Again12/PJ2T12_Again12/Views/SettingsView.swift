//
//  SettingsView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct SettingsView: View {
    @State private var totalToggle = true
    @State private var isLogin = false
    
    var body: some View {
        NavigationSplitView {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                    List {
                        Section() { // 로그인뷰
                            if !isLogin {
                                NavigationLink {
                                    LoginView()
                                } label: {
                                    Text("\n 로그인을 해서 개인정보를 입력하세요. \n")
                                        .foregroundStyle(Color.gray)
                                }
                            } else {
                                AfterLoginView()
                            }
                        }
                        
                        Section(header: Text("알림 설정")) {
                            TotalAlarmRow(totalToggle: $totalToggle)
                            MyAlarmRow(totalToggle: $totalToggle)
                            FriendsAlarmRow(totalToggle: $totalToggle)
                        }
                        
                        Section(header: Text("테마")) {
                            ThemeRow()
                        }
                        
                        Section(header: Text("설정")) {
                            NavigationLink {
                                DetailView()
                            } label: {
                                Text("공지사항")
                            }
                            NavigationLink {
                                DetailView()
                            } label: {
                                Text("정보")
                            }
                            NavigationLink {
                                DetailView()
                            } label: {
                                Text("문의사항")
                            }
                        }
                        
                        Section(header: Text("계정 관리")) {
                            NavigationLink {
                                DetailView()
                            } label: {
                                Text("로그아웃")
                            }
                            NavigationLink {
                                DetailView()
                            } label: {
                                Text("회원 탈퇴")
                            }
                        }
                    }
                    .listStyle(.grouped)
                }
            
            .navigationTitle("설정")
        } detail: {
            Text("")
        }
    }
}

struct LoginView: View {
    @State private var ID = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("ID             ")
                    TextField("ID", text: $ID)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                HStack {
                    Text("Password")
                    TextField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                Image(systemName: "airplane") // 카카오 연동
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding(30)
        }
    }
}

struct AfterLoginView: View {
    @State private var nickname = "투두리"
    var body: some View {
        HStack {
            Image(systemName: "airplane")
                .frame(width: 100)
            VStack (alignment: .leading) {
                Text("닉네임")
                TextField("", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

struct TotalAlarmRow: View {
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            Toggle(isOn: $totalToggle, label: {
                Text("전체 알림")
                Text("전체 알림을 조절할 수 있습니다.")
            })
        }
    }
}

struct MyAlarmRow: View {
    @State private var myToggle = true
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            Toggle(isOn: $myToggle, label: {
                Text("나의 알림")
                Text("나의 일정 알림을 조절할 수 있습니다.")
            })
            .disabled(!totalToggle)
        }
    }
}

struct FriendsAlarmRow: View {
    @State private var friendsToggle = true
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            Toggle(isOn: $friendsToggle, label: {
                Text("친구 알림")
                Text("친구들이 보내는 알림을 조절할 수 있습니다.")
            })
            .disabled(!totalToggle)
        }
    }
}

struct ThemeRow: View {
    var body: some View {
        HStack {
            Text("로그인 하여 각자의 테마를 만들어 보세요.")
                .foregroundStyle(Color.gray)
        }
    }
}

#Preview {
    SettingsView()
}
