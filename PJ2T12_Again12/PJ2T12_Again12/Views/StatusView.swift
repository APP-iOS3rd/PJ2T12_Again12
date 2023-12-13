//
//  StatusView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//
import Foundation
import SwiftUI
import Charts

struct StatusView: View {
    let Data = [
        (doType: "todo", data: ViewMonth.todoMonth),
        (doType: "wantTodo", data: ViewMonth.wantTodoMonth),
    ]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
    }
    
    @State var showMedals = false
    @State var settingsDetent = PresentationDetent.medium
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("기록")
                            .navigationTitle("나의 투두 기록")
                        Spacer()
                    }
                    GeometryReader{ geometry in
                        ScrollView(.horizontal) {
                            Chart {
                                // element는 Data
                                ForEach(Data, id: \.doType) { element in
                                    // $0은 따로 정하지 않아 element.data
                                    ForEach(element.data, id: \.date) {
                                        //todoMonth
                                        BarMark(x: .value("Month", $0.date),
                                                y: .value("Count", $0.done))
                                        // undone
                                        BarMark(x: .value("Month", $0.date),
                                                y: .value("Count", $0.undone))
                                        .foregroundStyle(.gray)
                                    }
                                    .foregroundStyle(by: .value("doType", element.doType))
                                    .position(by: .value("doType", element.doType))
                                }
                            }
                            .chartForegroundStyleScale([
                                "todo": .pink,
                                "wantTodo": .blue
                            ])
                            //막대그래프 기존 크기 정하기
                            .frame(width: 500, height: 280, alignment: .center)
                            .background(Color.white)
                            .padding(10)
                        }
                        .frame(width: geometry.size.width , height: geometry.size.height)
                    }
                    VStack {
                        Divider()
                            .background(Color.black)
                        HStack {
                            Text("메달")
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<6, id: \.self) {_ in
                                ZStack {
                                    Button(action: { showMedals = true }) {
                                        Image(systemName: "hare")
                                            .font(.system(size: 20))
                                            .frame(width: 90, height: 90)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                                        
                                    }
                                    .sheet(isPresented: $showMedals) {
                                        StatusModalView()
                                            .presentationDetents( [.height(250), .large], selection: $settingsDetent)
                                    }
                                }
                                .frame(width: .infinity, height: 150, alignment: .center)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StatusView()
}

