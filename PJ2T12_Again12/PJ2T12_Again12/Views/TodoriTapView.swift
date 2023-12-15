//
//  TodoriTapView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI
enum Views {
    case home, social, status, settings
}
struct TodoriTapView: View {
    @State private var selectedTap: Views = .home
    
    var body: some View {
        TabView(selection: $selectedTap) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("투두리")
                }
                .onAppear { selectedTap = .home }
                .tag(Views.home)
            SocialView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("동네사람들")
                }
                .onAppear { selectedTap = .social }
                .tag(Views.social)
            StatusView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("기록")
                }
                .onAppear { selectedTap = .status }
                .tag(Views.status)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
                .onAppear { selectedTap = .settings }
                .tag(Views.settings)
        }
        .tint(Color.DefaultBlack)
    }
}

#Preview {
    TodoriTapView()
}
