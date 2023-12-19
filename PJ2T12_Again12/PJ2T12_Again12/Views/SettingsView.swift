//
//  SettingsView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI
import UserNotifications
import PopupView

struct SettingsView: View {
    @State private var totalToggle = true
    @State private var isLogin = false
    @State private var nickname = ""
    @State private var profileImage = UIImage()
    
    var body: some View {
        NavigationStack {
            List {
                // 로그인 뷰
                Section() {
                    if !isLogin {
                        NavigationLink {
                            LoginView(isLogin: $isLogin)
                        } label: {
                            Text("\n 로그인을 해서 더 많은 기능을 사용해보세요. \n")
                                .font(.Hel15Bold)
                                .foregroundStyle(Color.TextDefaultGray)
                        }
                    } else {
                        NavigationLink {
                            ProfileEditView(nickname: $nickname, profileImage: $profileImage, isLogin: $isLogin)
                        } label: {
                            ProfileView(nickname: $nickname, profileImage: $profileImage)
                        }
                    }
                }
                .listRowBackground(Color.AlertBackWhite)
                
                Section(header: Text("알림 설정")) {
                    TotalAlarmRow(totalToggle: $totalToggle)
                    MyAlarmRow(totalToggle: $totalToggle)
                    FriendsAlarmRow(totalToggle: $totalToggle)
                }
                .listRowBackground(Color.AlertBackWhite)
                
                Section(header: Text("테마")) {
                    if !isLogin {
                        Text("로그인 하여 각자의 테마를 만들어 보세요.")
                            .foregroundStyle(Color.TextDefaultGray)
                            .font(.Hel13Bold)
                    } else {
                        NavigationLink {
                            ThemeView()
                        } label: {
                            Text("커스텀 테마를 골라보세요.")
                                .foregroundStyle(Color.DefaultBlack)
                                .font(.Hel15Bold)
                        }
                    }
                }
                .listRowBackground(Color.AlertBackWhite)
                
                Section(header: Text("설정")) {
                    NavigationLink {
                        NoticeView()
                    } label: {
                        Text("공지사항")
                            .foregroundStyle(Color.DefaultBlack)
                            .font(.Hel15Bold)
                    }
                    NavigationLink {
                        SettingDetailView()
                    } label: {
                        Text("정보")
                            .foregroundStyle(Color.DefaultBlack)
                            .font(.Hel15Bold)
                    }
                    NavigationLink {
                        QnAView()
                    } label: {
                        Text("문의사항")
                            .foregroundStyle(Color.DefaultBlack)
                            .font(.Hel15Bold)
                    }
                }
                .listRowBackground(Color.AlertBackWhite)
            }
            .listStyle(.grouped)
            .background(Color.BackgroundYellow)
            .scrollContentBackground(.hidden)
            .navigationTitle("설정")
        }
        .accentColor(Color.DefaultBlack)
    }
}

// 로그인 하는뷰
struct LoginView: View {
    @State private var ID = ""
    @State private var password = ""
    @Binding var isLogin: Bool
    @StateObject var kakaoAuthVM : KaKaoAuthVM = KaKaoAuthVM()
    @State var shouldShowBottomToastMessage : Bool = false
    
    func createBottomToastMessage() -> some View {
        VStack(alignment: .leading){
            Text("아직 미구현 기능 입니다.\n카카오 로그인을 이용해 주세요.")
                .font(.system(size: 14))
                .foregroundColor(Color.white)
                .padding(10)
            Divider().opacity(0)
        }
        .frame(width: 300)
        .background(Color(hex: 0x6E6F70))
        .cornerRadius(15)
    }
    
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Button(action: {
                    kakaoAuthVM.handleKakaoLogin()
                    isLogin = true
                }, label: {
                    Image("KakaoLoginImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 50)
                })
                Button(action: {
                    self.shouldShowBottomToastMessage = true
                }, label: {
                    Image("GoogleLoginImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 195, height: 50)
                })
                Button(action: {
                    self.shouldShowBottomToastMessage = true
                }, label: {
                    Image("NaverLoginImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 215, height: 50)
                })
            }
            .padding()
        }
        .popup(isPresented: $shouldShowBottomToastMessage) {
            createBottomToastMessage()
        } customize: {
            $0
                .type(.floater())
                .position(.center)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.3))
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
                    .overlay(Circle().stroke(Color.TextDefaultGray, lineWidth: 0.5))
            } else {
                Image("Mickey")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.TextDefaultGray, lineWidth: 0.5))
                    .clipped()
            }
            Spacer()
            VStack (alignment: .leading, spacing: 18) {
                Text("닉네임")
                    .font(.Hel20Bold)
                    .foregroundStyle(Color.DefaultBlack)
                if nickname == "" {
                    Text("닉네임을 입력하세요")
                        .font(.Hel15)
                        .foregroundStyle(Color.TextDefaultGray)
                } else {
                    Text(nickname)
                        .font(.Hel17)
                        .foregroundStyle(Color.DefaultBlack)
                }
            }
            .padding()
            Spacer()
            Spacer()
        }
        .padding()
    }
}

struct ProfileEditView: View {
    @Binding var nickname: String
    @StateObject private var viewModel = EditViewModel(todo: Todo())
    @State private var checkSave = false
    @Binding var profileImage: UIImage
    @Binding var isLogin: Bool
    @StateObject var kakaoAuthVM : KaKaoAuthVM = KaKaoAuthVM()
    @State private var logoutAlert: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("나의 정보")) {
                HStack {
                    HStack {
                        Button(action: {
                            viewModel.checkAlbumPermission()
                        }) {
                            ZStack {
                                if !checkSave {
                                    if profileImage.size != CGSize.zero {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.TextDefaultGray, lineWidth: 0.5))
                                    } else {
                                        Image("Mickey")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color.SocialChartBrown)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.TextDefaultGray, lineWidth: 0.5))
                                    }
                                }
                                Image(systemName: "camera.circle")
                                    .font(.title)
                                    .foregroundColor(Color.CameraGray)
                                    .offset(x: 40, y: 40)
                            }
                        }
                        .sheet(isPresented: $viewModel.albumPermissionGranted) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                        }
                        .padding()
                        Spacer()
                        
                    }
                    VStack (alignment: .leading) {
                        Text(" 닉네임")
                            .font(.Hel20Bold)
                        TextField("닉네임 입력하기", text: $nickname)
                            .textFieldStyle(.roundedBorder)
                            .font(.Hel15)
                    }
                    .foregroundStyle(Color.DefaultBlack)
                    .padding()
                }
                .background(Color(hex: 0xFFFFFF))
            }
            .listRowBackground(Color.AlertBackWhite)
            
            Section(header: Text("계정 관리")) {
                Button("로그아웃", action: {
                    logoutAlert = true
                })
                .foregroundStyle(Color.DefaultBlack)
                .font(.Hel15Bold)
                .alert(isPresented: $logoutAlert) {
                    let leftButton = Alert.Button.default(Text("로그아웃")) {
                        isLogin = false
                        kakaoAuthVM.kakaoLogout()
                    }
                    let rightButton = Alert.Button.default(Text("취소")) {
                        isLogin = true
                    }
                    return Alert(title: Text("로그아웃 하시겠습니까?"),
                                 primaryButton: rightButton,
                                 secondaryButton: leftButton)
                }
                
                NavigationLink {
                    WithDrawView()
                } label: {
                    Text("회원 탈퇴")
                        .foregroundStyle(Color.DefaultBlack)
                        .font(.Hel15Bold)
                }
            }
            .listRowBackground(Color.AlertBackWhite)
            
        }
        .listStyle(.grouped)
        .background(Color.BackgroundYellow)
        .scrollContentBackground(.hidden)
    }
}

// 더미 함수
func login() {
    print("login")
}

func logout() {
    print("logout")
}

func profileSave() {
    print("profile saved")
}

// 전체 알림 Row
struct TotalAlarmRow: View {
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            Toggle(isOn: $totalToggle, label: {
                Text("전체 알림")
                    .foregroundStyle(Color.DefaultBlack)
                    .font(.Hel15Bold)
                Text("전체 알림을 조절할 수 있습니다.")
                    .font(.Hel13)
            })
            .tint(Color.SocialChartBrown)
        }
        .onChange(of: totalToggle) { newValue in
            if !newValue {
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                print("successfully remove all pending notifications")
            }
        }
        
    }
}

// 나의 알림 Row
struct MyAlarmRow: View {
    @State private var myToggle = true
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            if totalToggle {
                Toggle(isOn: $myToggle, label: {
                    Text("나의 알림")
                        .font(.Hel15Bold)
                        .foregroundStyle(Color.DefaultBlack)
                    Text("나의 일정 알림을 조절할 수 있습니다.")
                        .font(.Hel13)
                })
                .tint(Color.SocialChartBrown)
            } else {
                Toggle(isOn: $totalToggle, label: {
                    Text("나의 알림")
                        .font(.Hel15Bold)
                        .foregroundStyle(Color.DefaultBlack)
                    Text("나의 일정 알림을 조절할 수 있습니다.")
                        .font(.Hel13)
                })
                .disabled(true)
                .tint(Color.SocialChartBrown)
                
            }
        }
    }
}

// 친구 알림 Row
struct FriendsAlarmRow: View {
    @State private var friendsToggle = true
    @Binding var totalToggle: Bool
    
    var body: some View {
        HStack {
            if totalToggle {
                Toggle(isOn: $friendsToggle, label: {
                    Text("친구 알림")
                        .font(.Hel13Bold)
                        .foregroundStyle(Color.DefaultBlack)
                    Text("친구들이 보내는 알림을 조절할 수 있습니다.")
                        .font(.Hel10)
                })
                .tint(Color.SocialChartBrown)
            } else {
                Toggle(isOn: $totalToggle, label: {
                    Text("친구 알림")
                        .font(.Hel13Bold)
                        .foregroundStyle(Color.DefaultBlack)
                    Text("친구들이 보내는 알림을 조절할 수 있습니다.")
                        .font(.Hel10)
                })
                .disabled(true)
                .tint(Color.SocialChartBrown)
            }
        }
    }
}

// 커스텀테마 뷰
struct ThemeView: View {
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text("커스텀 테마 기능 지원 예정")
                    .foregroundStyle(Color.TextDefaultGray)
                    .font(.Hel13Bold)
            }
        }
    }
}

struct NoticeView: View {
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text("공지 사항 뷰")
                    .font(.Hel13Bold)
            }
        }
    }
}

struct SettingDetailView: View {
    var body: some View {
        ZStack {
            Color.BackgroundYellow
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
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text("문의사항 뷰")
            }
        }
    }
}


struct WithDrawView: View {
    var body: some View {
        ZStack {
            Color.BackgroundYellow
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
