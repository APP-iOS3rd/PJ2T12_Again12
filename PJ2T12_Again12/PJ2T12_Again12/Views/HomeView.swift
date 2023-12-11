//
//  HomeView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

// TODO: 이모티콘에 대한 고민 나눠보기
struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var todoList: FetchedResults<Todo>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var wantTodoList: FetchedResults<WantTodo>
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                ScrollView {
                    // NavBar
                    HStack {
                        Text("2023. 12")
                            .foregroundStyle(Color(hex: 0x432D00))
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink {
                            HistoryView()
                        } label: {
                            Image(systemName: "doc.text")
                                .font(.title)
                                .foregroundStyle(Color(hex: 0x432D00))
                        }
                    }
                    .padding(.bottom, 4)
                    VStack(spacing: 16) {
                        // 하고 싶은 일
                        VStack {
                            HStack {
                                Text("하고 싶으면")
                                    .bold()
                                Spacer()
                            }
                            VStack {
                                ForEach(todoList, id: \.self) { todo in
                                    Button() {
                                        homeVM.showingAlert = true
                                    } label: {
                                        Text(todo.title ?? "Unknown")
                                            .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                    }
                                }
                                if todoList.count < 3 {
                                    Button {
                                        let todo = Todo(context: moc)
                                        todo.title = "투두!"
                                        todo.review = ""
                                        todo.status = false
                                        homeVM.showingModalAlert = true
                                    } label: {
                                        Text("새로운 투두를 추가해보세요")
                                            .padding()
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .fill(Color.white.opacity(0.6))
                                            )
                                            .padding(.top, 32)
                                    }
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: 0xA58B00).opacity(0.32), lineWidth: 2)
                            )
                        }
                        // 해야 하는 일
                        VStack {
                            HStack {
                                Text("해야 하면")
                                    .bold()
                                Spacer()
                            }
                            VStack {
                                ForEach(wantTodoList, id: \.self) { todo in
                                    Button() {
                                        homeVM.showingAlert = true
                                    } label: {
                                        Text(todo.title ?? "Unknown")
                                            .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB76300))
                                    }
                                }
                                if wantTodoList.count < 3 {
                                    Button {
                                        let wantTodo = WantTodo(context: moc)
                                        wantTodo.title = "원투두!"
                                        wantTodo.review = ""
                                        wantTodo.status = false
                                        homeVM.showingModalAlert = true
                                    } label: {
                                        Text("새로운 투두를 추가해보세요")
                                            .padding()
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .fill(Color.white.opacity(0.6))
                                            )
                                            .padding(.top, 32)
                                    }
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: 0xA58B00).opacity(0.32), lineWidth: 2)
                            )
                        }
                    }
                }
                .padding()
                
                if homeVM.showingModalAlert {
                    HomeModalView(shown: $homeVM.showingModalAlert)
                }
            }
            .alert("일정을 달성 하셨나요?" ,isPresented: $homeVM.showingAlert) {
                NavigationLink("일정 수정") { DetailView() }
                NavigationLink("일정 달성") { DetailView() }
            }
        }
    }
}

struct TodoCellModifier: ViewModifier {
    let status: Bool
    let hexCode: UInt
    func body(content: Content) -> some View {
        content
            .padding()
            .bold()
            .foregroundColor(status ? .white : Color(hex: hexCode))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(status ? Color(hex: hexCode, alpha: 0.4) : .white)
            )
    }
}

#Preview {
    HomeView()
}
