//
//  SettingsView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationSplitView {
                    List {
                        Rectangle() // 로그인 뷰
                            .frame(width: 400, height: 100)
                            .foregroundStyle(Color.white)
                        
                        Section(header: Text("알림 설정")) {
                            TotalAlarmRow()
                            MyAlarmRow()
                            FriendsAlarmRow()
                            NightAlarmRow()
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
                } detail: {
                    Text("")
                }
            }
            .navigationBarTitle("설정")
        }
    }
}

struct TotalAlarmRow: View {
    @State private var totalToggle = true
    
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
    
    var body: some View {
        HStack {
            Toggle(isOn: $myToggle, label: {
                Text("나의 알림")
                Text("나의 일정 알림을 조절할 수 있습니다.")
            })
        }
    }
}

struct FriendsAlarmRow: View {
    @State private var friendsToggle = true
    
    var body: some View {
        HStack {
            Toggle(isOn: $friendsToggle, label: {
                Text("친구 알림")
                Text("친구들이 보내는 알림을 조절할 수 있습니다.")
            })
        }
    }
}

struct NightAlarmRow: View {
    @State private var nightToggle = true
    
    var body: some View {
        HStack {
            Toggle(isOn: $nightToggle, label: {
                Text("야간 알림")
                Text("야간에 오는 알림을 조절할 수 있습니다.")
            })
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
