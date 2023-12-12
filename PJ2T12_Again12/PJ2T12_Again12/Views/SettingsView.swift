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
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                List {
                    Section(header: Text("알림 설정")) {
                        TaskRow()
                        TaskRow()
                        TaskRow()
                        TaskRow()
                    }
                    Section(header: Text("테마")) {
                        TaskRow()
                    }
                    Section(header: Text("설정")) {
                        TaskRow()
                        TaskRow()
                        TaskRow()
                    }
                    Section(header: Text("계정 관리")) {
                        TaskRow()
                        TaskRow()
                    }
                }
                .listStyle(.grouped)
                
            }
            .navigationBarTitle("설정")
        }
    }
}

struct TaskRow: View {
  var body: some View {
      HStack {
          Text("Test")
      }
  }
}

#Preview {
    SettingsView()
}
