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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == true")) var todoList: FetchedResults<Todo>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == false")) var wantTodoList: FetchedResults<Todo>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                ScrollView {
                    // NavBar
                    navigationBar
                    VStack(spacing: 16) {
                        // 해야하는 투두
                        VStack {
                            HStack {
                                Text("해야하면")
                                    .bold()
                                Spacer()
                            }
                            VStack {
                                ForEach(todoList, id: \.self) { todo in
                                    Button {
                                        homeVM.selectedTodoId = todo.wrappedId
                                        homeVM.showingAlert = true
                                    } label: {
                                        Label(todo.wrappedTitle, systemImage: todo.wrappedImage)
                                            .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                    }
                                }
                                // 투두 추가 버튼
                                if todoList.count < 3 {
                                    addTodoButton(isTodo: true)
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: 0xA58B00).opacity(0.32), lineWidth: 2)
                            )
                        }
                        // 하고싶은 투두
                        VStack {
                            HStack {
                                Text("하고싶으면")
                                    .bold()
                                Spacer()
                            }
                            VStack {
                                ForEach(wantTodoList, id: \.self) { todo in
                                    Button() {
                                        homeVM.selectedTodoId = todo.wrappedId
                                        homeVM.showingAlert = true
                                    } label: {
                                        Label(todo.wrappedTitle, systemImage: todo.wrappedImage)
                                            .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB76300))
                                    }
                                }
                                // 투두 추가 버튼
                                if wantTodoList.count < 3 {
                                    addTodoButton(isTodo: false)
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
                    HomeModalView(todoId: homeVM.selectedTodoId, homeVM: homeVM)
                }
            }
            .alert("일정을 달성 하셨나요?", isPresented: $homeVM.showingAlert) {
                Button("제목 수정") {
                    // HomeModalView 제목 수정
                    homeVM.showingModalAlert = true
                }
                NavigationLink("소감 작성") {
                    EditView(todoId: homeVM.selectedTodoId)
                }
            }
        }
    }
    
    // MARK: - Computed Views
    
    var navigationBar: some View {
        HStack {
            Text("yyyy.MM".stringFromDate(now: Date.now))
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
    }
    @ViewBuilder
    func addTodoButton(isTodo: Bool) -> some View {
            Button {
                homeVM.isTodo = isTodo
                homeVM.selectedTodoId = UUID()
                homeVM.showingModalAlert = true
            } label: {
                Text("새로운 투두를 추가해보세요")
                    .modifier(AddCellModifier())
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

struct AddCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
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

#Preview {
    HomeView()
}
