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
    
    @State var showMedal = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("목표 달성도")
                .font(.largeTitle)
                .bold()
            Divider()
                .background(Color.black)
            HStack {
                Text("기록")
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
                .padding(.bottom, 30.0)
//                ZStack {
//                    Button(action: { showMedal = true }) {
                        LazyVGrid(columns: columns, spacing: 20) {
                    
                                ZStack {
                                    Button(action: { showMedal = true }) {
                                Image(systemName: "hare")
                                    .font(.system(size: 20))
                                    .frame(width: 90, height: 90)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                                
                            }
                            
                            StatusModalView(isShowing: $showMedal)
                        }
                        .frame(width: .infinity, height: 150, alignment: .center)
                    }
                
            }
        }
    }
}


//struct MedalView: View {
//    @State var transitionView: Bool = false
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            VStack{
//                Button("버튼") {
//                    transitionView.toggle()
//                }
//                Spacer()
//            }
//
//            if transitionView {
//            RoundedRectangle(cornerRadius: 20)
//                .frame(height: UIScreen.main.bounds.height * 0.5)
//                .transition(AnyTransition.opacity.animation(.easeInOut))
//                .animation(.easeIn)
//            }
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//}
//    struct MedalView: View {
//        @Environment(\.presentationMode) var presentation
//
//        var body: some View {
//            VStack {
//                Text("헌신적인 학습자")
//                Image(systemName: "hare")
//                Button(action: {
//                    presentation.wrappedValue.dismiss()
//                }) {
//                    Text("Modal view 닫기").bold()
//                }
//                .frame(width: 150, height: 30, alignment: .center)
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
//                .font(.system(size: 16))
//                .foregroundColor(Color.white)
//                .offset(y: UIScreen.main.bounds.height / 4)
//
//            }
//
//        }
//    }
//struct MedalView: View {
//    @State var isPresented = false
//
//    var body: some View {
//        Button("Show Modal") {
//            isPresented.toggle()
//        }
//        .sheet(isPresented: $isPresented) {
//            VStack {
//                Text("This is a modal view")
//                Button("Dismiss") {
//                    isPresented.toggle()
//                }
//            }
//            .frame(width: 300, height: 300)
//            .background(Color.white)
//            .cornerRadius(10)
//            .shadow(radius: 5)
//            .offset(y: UIScreen.main.bounds.height / 2)
//        }
//    }
//}


#Preview {
    StatusView()
}

