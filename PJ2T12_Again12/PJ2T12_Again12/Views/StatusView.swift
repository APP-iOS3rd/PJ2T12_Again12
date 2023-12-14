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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == true")) var todoList: FetchedResults<Todo>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == false")) var wantTodoList: FetchedResults<Todo>
    
    @State private var selectedbadge = ""

    
    @State var Data = [

        
        DataType(doType: "해야하면", data: TodoOverView.todoMonth),
        DataType(doType: "하고싶으면", data: TodoOverView.wantTodoMonth)
    ]

    
    init() {
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
                            ForEach(Data, id: \.doType) { element in
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
            .onAppear  {
//                groupTodoByMonth(todoList: todoList, index: 0)
//                groupTodoByMonth(todoList: wantTodoList, index: 1)
            }
        }
    }
    func groupTodoByMonth(todoList: FetchedResults<Todo>, index: Int) {
        let groupdByMonth = Dictionary(grouping: todoList) { todo in
            return Calendar.current.component(.month, from: todo.wrappedDate)
        }
        
        // todoMonth
        var todoOverViews: [TodoOverView] = []
        
        for (month, todos) in groupdByMonth {
            let doneCount = todos.filter { $0.status == true }.count
            let undoneCount = todos.filter { $0.status == false }.count
            let todoOverView = TodoOverView(date: month, done: doneCount, undone: undoneCount)
            todoOverViews.append(todoOverView)
        }
        let type = (index == 0) ? "Todo" : "WantTodo"
        Data[index].data = todoOverViews.sorted { $0.date < $1.date }
        for todoOverView in todoOverViews {
            print("[\(type)] Month: \(todoOverView.date), Done: \(todoOverView.done), Undone: \(todoOverView.undone)")
        }
    }
    
}

#Preview {
    StatusView()
}


