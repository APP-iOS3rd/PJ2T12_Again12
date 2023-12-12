//
//  SettingsView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct SettingsView: View {
    @State private var totalToggle = true
    @State private var isLogin = true
    @State private var nickname = "투두리"
    
    var body: some View {
        NavigationSplitView {
            List {
                // 로그인 뷰
                Section() {
                    if !isLogin {
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("\n 로그인을 해서 개인정보를 입력하세요. \n")
                                .foregroundStyle(Color.gray)
                        }
                    } else {
                        NavigationLink {
                            ProfileEditView(nickname: $nickname)
                        } label: {
                            ProfileView(nickname: $nickname)
                        }
                    }
                }
                
                Section(header: Text("알림 설정")) {
                    TotalAlarmRow(totalToggle: $totalToggle)
                    MyAlarmRow(totalToggle: $totalToggle)
                    FriendsAlarmRow(totalToggle: $totalToggle)
                }
                
                Section(header: Text("테마")) {
                    if !isLogin {
                        Text("로그인 하여 각자의 테마를 만들어 보세요.")
                            .foregroundStyle(Color.gray)
                    } else {
                        NavigationLink {
                            ThemeView()
                        } label: {
                            Text("커스텀 테마를 골라보세요.")
                        }
                    }
                }
                
                Section(header: Text("설정")) {
                    NavigationLink {
                        NoticeView()
                    } label: {
                        Text("공지사항")
                    }
                    NavigationLink {
                        SettingDetailView()
                    } label: {
                        Text("정보")
                    }
                    NavigationLink {
                        QnAView()
                    } label: {
                        Text("문의사항")
                    }
                }
                
                Section(header: Text("계정 관리")) {
                    NavigationLink {
                        LogoutView()
                    } label: {
                        Text("로그아웃")
                    }
                    NavigationLink {
                        WithDrawView()
                    } label: {
                        Text("회원 탈퇴")
                    }
                }
            }
            .listStyle(.grouped)
            .background(Color(hex: 0xFFFAE1))
            .scrollContentBackground(.hidden)
            
            .navigationTitle("설정")
        } detail: {
            Text("")
        }
    }
}

// 로그인 하는뷰
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

// 로그인 이후 뷰
struct ProfileView: View {
    @Binding var nickname: String
    var body: some View {
        HStack {
            Image(systemName: "airplane")
                .frame(width: 100)
            VStack (alignment: .leading) {
                Text("닉네임: \(nickname)")
                Text("")
            }
        }
        .padding()
    }
}

struct ProfileEditView: View {
    @Binding var nickname: String
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "airplane")
                        .frame(width: 100)
                    VStack (alignment: .leading) {
                        Text("닉네임")
                        TextField("닉네임을 설정해주세요.", text: $nickname)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
            }
            .padding()
        }
    }
}

// 전체 알림 Row
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

// 나의 알림 Row
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

// 친구 알림 Row
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

// 커스텀테마 뷰
struct ThemeView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("커스텀 테마 기능 지원 예정")
                    .foregroundStyle(Color.gray)
            }
        }
    }
}

struct NoticeView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("공지 사항 뷰")
            }
        }
    }
}

struct SettingDetailView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("어플 정보 뷰")
            }
        }
    }
}

struct QnAView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("문의사항 뷰")
            }
        }
    }
}

struct LogoutView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("로그아웃 뷰")
            }
        }
    }
}

struct WithDrawView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                Text("회원탈퇴 뷰")
            }
        }
    }
}


#Preview {
    SettingsView()
}
