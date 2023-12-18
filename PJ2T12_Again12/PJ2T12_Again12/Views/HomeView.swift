//
//  HomeView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeVM = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundYellow
                    .ignoresSafeArea()
                ScrollView {
                    // NavBar
                    navigationBar
                    VStack(spacing: 16) {
                        // 하고싶은 투두
                        VStack {
                            HStack {
                                Text("하고싶으면")
                                    .font(.Hel17Bold)
                                    .foregroundStyle(.defaultBlack)
                                Spacer()
                            }
                            VStack {
                                ForEach(homeVM.wantTodoList, id: \.self) { todo in
                                    Button() {
                                        homeVM.selectedTodoId = todo.wrappedId
                                        homeVM.selectedTodo = todo
                                        homeVM.isTodo = false
                                        homeVM.showingAlert = true
                                    } label: {
                                        Label(todo.wrappedTitle, systemImage: todo.wrappedImage)
                                            .font(.Hel17Bold)
                                            .modifier(WantTodoCellModifier(status: todo.status))
                                    }
                                }
                                // 투두 추가 버튼
                                if homeVM.wantTodoList.count < 3 {
                                    addTodoButton(isTodo: false)
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.BorderBrown, lineWidth: 2)
                            )
                        }
                        // 해야하는 투두
                        VStack {
                            HStack {
                                Text("해야하면")
                                    .font(.system(size: 17))
                                    .bold()
                                    .foregroundStyle(.defaultBlack)
                                Spacer()
                            }
                            VStack {
                                ForEach(homeVM.todoList, id: \.self) { todo in
                                    Button {
                                        homeVM.selectedTodoId = todo.wrappedId
                                        homeVM.selectedTodo = todo
                                        homeVM.isTodo = true
                                        homeVM.showingAlert = true
                                    } label: {
                                        Label(todo.wrappedTitle, systemImage: todo.wrappedImage)
                                            .font(.Hel17Bold)
                                            .modifier(TodoCellModifier(status: todo.status))
                                    }
                                }
                                // 투두 추가 버튼
                                if homeVM.todoList.count < 3 {
                                    addTodoButton(isTodo: true)
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.BorderBrown, lineWidth: 2)
                            )
                        }
                    }
                }
                .padding()
                if homeVM.showingModalAlert {
                    HomeModalView(todo: homeVM.selectedTodo, isTodo: homeVM.isTodo) {
                        homeVM.showingModalAlert = false
                        homeVM.selectedTodo = nil
                        homeVM.getAllTodoList()
                    }
                }
            }
            .alert("투두를 달성 하셨나요?", isPresented: $homeVM.showingAlert) {
                Button("투두 수정") {
                    // HomeModalView 제목 수정
                    homeVM.showingModalAlert = true
                }
                .foregroundStyle(.brown)
                NavigationLink("투두 완료") {
                    EditView(todoId: homeVM.selectedTodoId, homeVM: homeVM)
                }
            }
            .onAppear {
                homeVM.getAllTodoList()
            }
        }
    }
    
    // MARK: - Computed Views
    
    var navigationBar: some View {
        HStack {
            Text("yyyy.MM".stringFromDate(now: Date.now))
                .foregroundStyle(Color.DefaultBlack)
                .font(.Alata28)
            Spacer()
            NavigationLink {
                HistoryView(homeVM: homeVM)
            } label: {
                Image(systemName: "doc.text")
                    .font(.title)
                    .foregroundStyle(Color.DefaultBlack)
            }
        }
        .padding(.bottom, 4)
    }
    @ViewBuilder
    func addTodoButton(isTodo: Bool) -> some View {
            Button {
                homeVM.isTodo = isTodo
                homeVM.selectedTodoId = UUID()
                homeVM.showingModalAlert = true
            } label: {
                Text("새로운 투두를 추가해보세요")
                    .font(.Hel17Bold)
                    .modifier(AddCellModifier())
            }
    }
}

// MARK: - Modifiers

struct TodoCellModifier: ViewModifier {
    let status: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .bold()
            .foregroundColor(status ? Color(hex: 0xFFFAF4) : .todoNoTextBrown)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(status ? .todoButtonBrown : .white)
            )
    }
}

struct WantTodoCellModifier: ViewModifier {
    let status: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .bold()
            .foregroundColor(status ? Color(hex: 0xFFFADE) : .wanttoNoTextBrown)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(status ? .wanttoYesButtonBrown : .white)
            )
    }
}


struct AddCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.defaultBlack)
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.newTodoButtonBrown)
            )
            .padding(.top, 32)
    }
}

#Preview {
    HomeView()
}

