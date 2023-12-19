//
//  HistoryView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var homeVM: HomeViewModel
    @ObservedObject var historyVM: HistoryViewModel
    
    init(homeVM: HomeViewModel) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .brown
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.brown], for: .normal)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
        self.homeVM = homeVM
        self.historyVM = HistoryViewModel()
    }
    
//    private var filteredtodoList: [Todo] {
//        guard !searchTitle.isEmpty else {
//            return Array(todoList)
//        }
//        return todoList.filter { todo in
//            todo.title?.lowercased().contains(searchTitle.lowercased())
//        }
//    }
    
    var body: some View {
        
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Picker("Select Segment", selection: $historyVM.selectedSegment) {
                    Text("모두").tag(0)
                        .font(.custom("Helvetica", size: 10))
                    Text("하고 싶으면").tag(1)
                        .font(.custom("Helvetica", size: 10))
                    Text("해야 하면").tag(2)
                        .font(.custom("Helvetica", size: 10))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // 모두
                if historyVM.selectedSegment == 0 {
                    ScrollView {
                        ForEach(historyVM.wantTodoList) { todo in
                            NavigationLink(destination: EditView(todoId: todo.wrappedId, homeVM: homeVM), label: {
                                HStack {
                                    VStack {
                                        Label("", systemImage: todo.wrappedImage)
                                        Spacer()
                                    }
                                    VStack(alignment: .leading) {
                                        Text(todo.wrappedTitle)
                                            .font(.Hel17Bold)
                                        Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                            .font(.Hel15)
                                    }
                                }
                                // Color.TodoNoTextBrown
                                .modifier(WantTodoCellModifier(status: todo.status))
                            })
                        }
                        ForEach(historyVM.todoList) { todo in
                            NavigationLink(destination: EditView(todoId: todo.wrappedId, homeVM: homeVM), label: {
                                HStack {
                                    VStack {
                                        Label("", systemImage: todo.wrappedImage)
                                        Spacer()
                                    }
                                    VStack(alignment: .leading) {
                                        Text(todo.wrappedTitle)
                                            .font(.Hel17Bold)
                                        Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                            .font(.Hel15)
                                    }
                                }
                                // Color.WanttoNoTextBrown
                                .modifier(TodoCellModifier(status: todo.status))
                            })
                        }
                    }
                    .padding()
                    // 해야하는 일
                } else if historyVM.selectedSegment == 2 {
                    ScrollView {
                        ForEach(historyVM.todoList) { todo in
                            NavigationLink(destination: EditView(todoId: todo.wrappedId, homeVM: homeVM), label: {
                                HStack {
                                    VStack {
                                        Label("", systemImage: todo.wrappedImage)
                                        Spacer()
                                    }
                                    VStack(alignment: .leading) {
                                        Text(todo.wrappedTitle)
                                            .font(.Hel17Bold)
                                        Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                            .font(.Hel15)
                                    }
                                }
                                // Color.WanttoNoTextBrown
                                .modifier(TodoCellModifier(status: todo.status))
                            })
                        }
                    }
                    .padding()
                } else {
                    // 하고 싶은 일
                    ScrollView {
                        ForEach(historyVM.wantTodoList) { todo in
                            NavigationLink(destination: EditView(todoId: todo.wrappedId, homeVM: homeVM), label: {
                                HStack {
                                    VStack {
                                        Label("", systemImage: todo.wrappedImage)
                                        Spacer()
                                    }
                                    VStack(alignment: .leading) {
                                        Text(todo.wrappedTitle)
                                            .font(.Hel17Bold)
                                        Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                            .font(.Hel15)
                                    }
                                }
                                // Color.TodoNoTextBrown
                                .modifier(WantTodoCellModifier(status: todo.status))
                            })
                        }
                    }
                    .padding()
                }
            }
            .searchable(text: $historyVM.searchTitle)
            .navigationBarTitle("전체 일정 보기")
        }
    }
}

//#Preview {
//    NavigationView {
//        HistoryView()
//    }
//}
