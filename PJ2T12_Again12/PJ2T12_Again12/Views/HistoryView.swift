//
//  HistoryView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct HistoryView: View {

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .brown
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.brown], for: .normal)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
    }

    @State private var searchTitle: String = ""
    @State private var selectedSegment = 0
    @StateObject private var homeVM = HomeViewModel()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == %@", "true")) var todoList: FetchedResults<Todo>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == %@", "false")) var wantTodoList: FetchedResults<Todo>

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                VStack {
                    Picker("Select Segment", selection: $selectedSegment) {
                        Text("모두").tag(0)
                        Text("해야 하는 일").tag(1)
                        Text("하고 싶은 일").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if selectedSegment == 0 {
                        ScrollView {
                            ForEach(todoList) { todo in
                                NavigationLink(destination: EditView(), label: {
                                    HStack {
                                        Text(" 🍞 ")
                                        VStack(alignment: .leading) {
                                            Text(todo.wrappedTitle)
                                            Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                        }
                                    }
                                    .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                })
                            }
                            ForEach(wantTodoList) { todo in
                                NavigationLink(destination: EditView(), label: {
                                    HStack {
                                        Text(" 🍁 ")
                                        VStack(alignment: .leading) {
                                            Text(todo.wrappedTitle)
                                            Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                        }
                                    }
                                    .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB76300))
                                })
                            }
                        }
                        .padding()
                    } else if selectedSegment == 1 {
                        ScrollView {
                            ForEach(todoList) { todo in
                                NavigationLink(destination: EditView(), label: {
                                    HStack {
                                        Text(" 🍞 ")
                                        VStack(alignment: .leading) {
                                            Text(todo.wrappedTitle)
                                            Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                        }
                                    }
                                    .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                })
                            }
                        }
                        .padding()
                    } else {
                        ScrollView {
                            ForEach(wantTodoList) { todo in
                                NavigationLink(destination: EditView(), label: {
                                    HStack {
                                        Text(" 🍁 ")
                                        VStack(alignment: .leading) {
                                            Text(todo.wrappedTitle)
                                            Text("yyyy.MM".stringFromDate(now: todo.wrappedDate))
                                        }
                                    }
                                    .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB76300))
                                })
                            }
                        }
                        .padding()
                    }
                }
                .searchable(text: $searchTitle)
            }
            .navigationBarTitle("전체 일정 보기")
        }
    }
}

#Preview {
    HistoryView()
}
