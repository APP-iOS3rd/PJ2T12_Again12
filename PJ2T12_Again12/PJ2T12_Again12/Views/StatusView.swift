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
    
    @State var Data = [
//        DataType(doType: "todo", data: [TodoOverView(date: 1, done: 1, undone: 1)]),
//        DataType(doType: "wantTodo", data: [TodoOverView(date: 1, done: 1, undone: 1)])

        DataType(doType: "todo", data: TodoOverView.todoMonth),
        DataType(doType: "wantTodo", data: TodoOverView.wantTodoMonth)
    ]
    
    @State var showMedals = false
    @State var settingsDetent = PresentationDetent.medium
    
    let firstWantTodoIt = UserDefaults.standard.integer(forKey: "firstWantTodoIt")
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundYellow
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("기록")
                            .padding(10)
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
                                        BarMark(x: .value("Month", "\($0.date)월"),
                                                y: .value("Count", $0.done))
                                        // undone
                                        BarMark(x: .value("Month", "\($0.date)월"),
                                                y: .value("Count", $0.undone))
                                        .foregroundStyle(.gray)
                                    }
                                    .foregroundStyle(by: .value("doType", element.doType))
                                    .position(by: .value("doType", element.doType))
                                }
                            }
                            .chartForegroundStyleScale([
                                "todo": Color.WanttoYesButtonBrown,
                                "wantTodo": Color.TodoButtonBrown
                            ])
                            //막대그래프 기존 크기 정하기
                            .frame(width: 500, height: 280, alignment: .center)
                            // hexcode를 rgb값으로 변경하여 넣기
                            .background(Color.AlertBackWhite)
                            .padding(10)
                        }
                        .frame(width: geometry.size.width , height: geometry.size.height)
                    }
                    VStack {
                        HStack {
                            Text("뱃지")
                                .padding(10)
                                .position(x: 25, y: 5)
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<6, id: \.self) {_ in
                                ZStack {
                                    Button(action: { showMedals = true }) {
                                        if(self.firstWantTodoIt != 0) {
                                        Image(systemName: "hare.circle")
                                            .frame(width: 90, height: 90)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                                                    } else {
                                                        Image(systemName: "hare.circle.fill")
                                                            .frame(width: 90, height: 90)
                                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                                                    }
                                    }
                                    .sheet(isPresented: $showMedals) {
                                        StatusModalView()
                                            .presentationDetents( [.height(250), .large], selection: $settingsDetent)
                                    }
                                }
                            }
                        }
                        .frame(width: 380, height: 260)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                        )
                    }
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


