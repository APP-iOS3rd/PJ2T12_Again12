//
//  StatusView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import Charts
import Foundation
import SwiftUI

struct StatusView: View {
    @ObservedObject var statusVM: StatusViewModel

    init() {
        statusVM = StatusViewModel()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundYellow
                    .ignoresSafeArea()
                ScrollView {
                    HStack {
                        Text("기록")
                            .font(.Hel17Bold)
                            .padding(4)
                        Spacer()
                    }
                    .padding(.leading)
                    ScrollView(.horizontal) {
                        Chart {
                            // element는 Data
                            ForEach(statusVM.chartData, id: \.doType) { element in
                                // $0은 따로 정하지 않아 element.data
                                ForEach(element.data, id: \.date) {
                                    //todoMonth
                                    BarMark(x: .value("Month", "\($0.date)월"),
                                            y: .value("Count", $0.done))
                                    // undone
                                    BarMark(x: .value("Month", "\($0.date)월"),
                                            y: .value("Count", $0.undone))
                                    .foregroundStyle(Color("ChartNodoBrown"))
                                }
                                .foregroundStyle(by: .value("doType", element.doType))
                                .position(by: .value("doType", element.doType))
                            }
                        }
                        .chartForegroundStyleScale([
                            "해야하면": Color("ChartTodoBrown"),
                            "하고싶으면": Color("ChartWanttoBrown")
                        ])
                        //막대그래프 기존 크기 정하기
                        .frame(width: 500, height: 280, alignment: .center)
                        // hexcode를 rgb값으로 변경하여 넣기
                        .background(Color.AlertBackWhite)
                        .padding(10)
                    }
                    HStack {
                        Text("뱃지")
                            .font(.Hel17Bold)
                            .padding(4)
                        Spacer()
                    }
                    .padding(.horizontal)
                    BedgeView()
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("나의 투두 기록")
        }
    }
}

#Preview {
    StatusView()
}


