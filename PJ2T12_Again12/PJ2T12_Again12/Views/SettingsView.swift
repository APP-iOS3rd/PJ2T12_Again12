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
    @State private var profileImage = UIImage()
    
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
                            ProfileEditView(nickname: $nickname, profileImage: $profileImage)
                        } label: {
                            ProfileView(nickname: $nickname, profileImage: $profileImage)
                        }
                    }
                }
                .listRowBackground(Color(hex: 0xFFFEF6))
                
                Section(header: Text("알림 설정")) {
                    TotalAlarmRow(totalToggle: $totalToggle)
                    MyAlarmRow(totalToggle: $totalToggle)
                    FriendsAlarmRow(totalToggle: $totalToggle)
                }
                .listRowBackground(Color(hex: 0xFFFEF6))
                
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
                .listRowBackground(Color(hex: 0xFFFEF6))
                
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
                        // QnAView() 가 맞음
                        // EditView() 확인용
                        EditView()
                    } label: {
                        Text("문의사항")
                    }
                }
                .listRowBackground(Color(hex: 0xFFFEF6))
                
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
                .listRowBackground(Color(hex: 0xFFFEF6))
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
    @Binding var profileImage: UIImage
    
    var body: some View {
        HStack {
            if profileImage.size.width != 0 && profileImage.size.height != 0 {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.yellow, lineWidth: 1))
            } else {
                Image(systemName: "hare.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.pink)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: 0xE5F5FF), lineWidth: 1))
            }
            VStack (alignment: .leading) {
                Text("닉네임: \(nickname)")
                Text("")
            }
            .padding()
        }
        .padding()
    }
}

struct ProfileEditView: View {
    @Binding var nickname: String
    @StateObject private var viewModel = EditViewModel()
    @State private var checkSave = false
    @State private var openPhoto = false
    @Binding var profileImage: UIImage
    
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAE1)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button("저장", action: profileSave)
                        .padding()
                }
                Spacer()
                HStack {
                    HStack {
                        Button(action: {
                            viewModel.checkAlbumPermission()
                            if viewModel.albumPermissionGranted {
                                self.openPhoto = true
                            }
                        }) {
                            ZStack {
                                if !checkSave {
                                    if profileImage.size != CGSize.zero {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color(hex: 0xE5F5FF), lineWidth: 1))
                                    } else {
                                        Image(systemName: "hare.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.pink)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color(hex: 0xE5F5FF), lineWidth: 1))
                                    }
                                }
                                Image(systemName: "camera.circle")
                                    .font(.title)
                                    .foregroundColor(.gray)
                                    .offset(x: 40, y: 40)
                            }
                        }
                        .sheet(isPresented: $openPhoto) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                        }
                        .padding()
                        Spacer()
                            
                    }
                    VStack (alignment: .leading) {
                        Text("닉네임")
                        TextField("닉네임을 설정해주세요.", text: $nickname)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                }
                .background(Color.white)
                Spacer()
                Spacer()
            }
        }
    }
}

func profileSave() {
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
            .tint(Color(hex: 0xFFCD7B))
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
            .tint(Color(hex: 0xFFCD7B))
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
            .tint(Color(hex: 0xFFCD7B))
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
